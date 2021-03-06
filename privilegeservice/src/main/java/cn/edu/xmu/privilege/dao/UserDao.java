package cn.edu.xmu.privilege.dao;

import cn.edu.xmu.ooad.util.*;
import cn.edu.xmu.privilege.mapper.UserPoMapper;
import cn.edu.xmu.privilege.mapper.UserProxyPoMapper;
import cn.edu.xmu.privilege.mapper.UserRolePoMapper;
import cn.edu.xmu.privilege.model.bo.User;
import cn.edu.xmu.privilege.model.po.*;
import cn.edu.xmu.privilege.model.vo.UserEditVo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.dao.DataAccessException;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.*;
import java.util.concurrent.TimeUnit;

/**
 * @author Ming Qiu
 * @date Created in 2020/11/1 11:48
 * Modified in 2020/11/3 14:37
 **/
@Repository
public class UserDao implements InitializingBean {

    private static final Logger logger = LoggerFactory.getLogger(UserDao.class);

    /**
     * 是否初始化，生成signature和加密
     */
    @Value("${prvilegeservice.initialization}")
    private Boolean initialization;

    @Value("${prvilegeservice.user.expiretime}")
    private long timeout;

    @Value("${prvilegeservice.randomtime}")
    private int randomTime;

    @Autowired
    private UserRolePoMapper userRolePoMapper;

    @Autowired
    private UserProxyPoMapper userProxyPoMapper;

    @Autowired
    private UserPoMapper userMapper;

    @Autowired
    private RedisTemplate<String, String> redisTemplate;

    @Autowired
    private RoleDao roleDao;

    /**
     * 计算User自己的权限，load到Redis
     *
     * @param id userID
     * @return void
     * createdBy: Ming Qiu 2020-11-02 11:44
     * modifiedBy: Ming Qiu 2020-11-03 12:31
     * 将获取用户Roleid的代码独立, 增加redis过期时间
     */
    private void loadSingleUserPriv(Long id) {
        List<Long> roleIds = this.getRoleIdByUserId(id);
        String key = "u_" + id;
        if (roleIds.size() == 0){
            redisTemplate.opsForSet().add(key, "0");
        } else {
            Set<String> roleKeys = new HashSet<>(roleIds.size());
            for (Long roleId : roleIds) {
                String roleKey = "r_" + roleId;
                roleKeys.add(roleKey);
                if (!redisTemplate.hasKey(roleKey)) {
                    roleDao.loadRolePriv(roleId);
                }
            }
            redisTemplate.opsForSet().unionAndStore(roleKeys, key);
        }
        redisTemplate.expire(key, this.timeout + new Random().nextInt(randomTime), TimeUnit.SECONDS);
    }

    /**
     * 获得用户的角色id
     *
     * @param id 用户id
     * @return 角色id列表
     * createdBy: Ming Qiu 2020/11/3 13:55
     */
    private List<Long> getRoleIdByUserId(Long id) {
        UserRolePoExample example = new UserRolePoExample();
        UserRolePoExample.Criteria criteria = example.createCriteria();
        criteria.andUserIdEqualTo(id);
        List<UserRolePo> userRolePoList = userRolePoMapper.selectByExample(example);
        logger.debug("getRoleIdByUserId: userId = "+ id + "roleNum = "+ userRolePoList.size());
        List<Long> retIds = new ArrayList<>(userRolePoList.size());
        for (UserRolePo po : userRolePoList) {
            StringBuilder signature = StringUtil.concatString("-",
                    po.getUserId().toString(), po.getRoleId().toString(), po.getCreatorId().toString());
            String newSignature = SHA256.getSHA256(signature.toString());


            if (newSignature.equals(po.getSignature())) {
                retIds.add(po.getRoleId());
                logger.debug("getRoleIdByUserId: userId = " + po.getUserId() + " roleId = " + po.getRoleId());
            } else {
                logger.error("getRoleIdByUserId: Wrong Signature(auth_role_privilege): id =" + po.getId());
            }
        }
        return retIds;
    }

    /**
     * 计算User的权限（包括代理用户的权限，只计算直接代理用户），load到Redis
     *
     * @param id userID
     * @return void
     * createdBy Ming Qiu 2020/11/1 11:48
     * modifiedBy Ming Qiu 2020/11/3 14:37
     */
    public void loadUserPriv(Long id) {

        String key = "u_" + id;
        String aKey = "up_" + id;

        List<Long> proxyIds = this.getProxyIdsByUserId(id);
        List<String> proxyUserKey = new ArrayList<>(proxyIds.size());
        for (Long proxyId : proxyIds) {
            if (!redisTemplate.hasKey("u_" + proxyId)) {
                logger.debug("loadUserPriv: loading proxy user. proxId = "+ proxyId);
                loadSingleUserPriv(proxyId);
            }
            proxyUserKey.add("u_" + proxyId);
        }
        if (!redisTemplate.hasKey(key)) {
            logger.debug("loadUserPriv: loading user. id = "+ id);
            loadSingleUserPriv(id);
        }
        redisTemplate.opsForSet().unionAndStore(key, proxyUserKey, aKey);
        redisTemplate.expire(aKey, this.timeout + new Random().nextInt(randomTime), TimeUnit.SECONDS);
    }

    /**
     * 获得代理的用户id列表
     *
     * @param id 用户id
     * @return 被代理的用户id
     * createdBy Ming Qiu 14:37
     */
    private List<Long> getProxyIdsByUserId(Long id) {
        UserProxyPoExample example = new UserProxyPoExample();
        //查询当前所有有效的被代理用户
        UserProxyPoExample.Criteria criteria = example.createCriteria();
        criteria.andUserAIdEqualTo(id);
        criteria.andValidEqualTo((byte) 1);
        List<UserProxyPo> userProxyPos = userProxyPoMapper.selectByExample(example);
        List<Long> retIds = new ArrayList<>(userProxyPos.size());
        LocalDateTime now = LocalDateTime.now();
        for (UserProxyPo po : userProxyPos) {
            StringBuilder signature = StringUtil.concatString("-", po.getUserAId().toString(),
                    po.getUserBId().toString(), po.getBeginDate().toString(), po.getEndDate().toString(), po.getValid().toString());
            String newSignature = SHA256.getSHA256(signature.toString());
            UserProxyPo newPo = null;

            if (newSignature.equals(po.getSignature())) {
                if (now.isBefore(po.getEndDate()) && now.isAfter(po.getBeginDate())) {
                    //在有效期内
                    retIds.add(po.getUserBId());
                    logger.debug("getProxyIdsByUserId: userAId = " + po.getUserAId() + " userBId = " + po.getUserBId());
                } else {
                    //代理过期了，但标志位依然是有效
                    newPo = newPo == null ? new UserProxyPo() : newPo;
                    newPo.setValid((byte) 0);
                    signature = StringUtil.concatString("-", po.getUserAId().toString(),
                            po.getUserBId().toString(), po.getBeginDate().toString(), po.getEndDate().toString(), newPo.getValid().toString());
                    newSignature = SHA256.getSHA256(signature.toString());
                    newPo.setSignature(newSignature);
                }
            } else {
                logger.error("getProxyIdsByUserId: Wrong Signature(auth_user_proxy): id =" + po.getId());
            }

            if (null != newPo) {
                logger.debug("getProxyIdsByUserId: writing back.. po =" + newPo);
                userProxyPoMapper.updateByPrimaryKeySelective(newPo);
            }
        }
        return retIds;
    }

    @Override
    public void afterPropertiesSet() throws Exception {
        if (! initialization){
            return;
        }
        //初始化user
        UserPoExample example = new UserPoExample();
        UserPoExample.Criteria criteria = example.createCriteria();
        criteria.andSignatureIsNull();

        List<UserPo> userPos = userMapper.selectByExample(example);

        for (UserPo po : userPos){
            UserPo newPo = new UserPo();
            newPo.setPassword(AES.encrypt(po.getPassword(), User.AESPASS));
            newPo.setEmail(AES.encrypt(po.getEmail(), User.AESPASS));
            newPo.setMobile(AES.encrypt(po.getMobile(), User.AESPASS));
            newPo.setName(AES.encrypt(po.getName(), User.AESPASS));
            newPo.setId(po.getId());

            StringBuilder signature = StringUtil.concatString("-", po.getUserName(), newPo.getPassword(),
                    newPo.getMobile(),newPo.getEmail(),po.getOpenId(),po.getState().toString(),po.getDepartId().toString(),
                    po.getCreatorId().toString());
            newPo.setSignature(SHA256.getSHA256(signature.toString()));

            userMapper.updateByPrimaryKeySelective(newPo);
        }

        //初始化UserProxy
        UserProxyPoExample example1 = new UserProxyPoExample();
        UserProxyPoExample.Criteria criteria1 = example1.createCriteria();
        criteria1.andSignatureIsNull();
        List<UserProxyPo> userProxyPos = userProxyPoMapper.selectByExample(example1);

        for (UserProxyPo po : userProxyPos) {
            UserProxyPo newPo = new UserProxyPo();
            newPo.setId(po.getId());
            StringBuilder signature = StringUtil.concatString("-", po.getUserAId().toString(),
                    po.getUserBId().toString(), po.getBeginDate().toString(), po.getEndDate().toString(), po.getValid().toString());
            String newSignature = SHA256.getSHA256(signature.toString());
            newPo.setSignature(newSignature);
            userProxyPoMapper.updateByPrimaryKeySelective(newPo);
        }

        //初始化UserRole
        UserRolePoExample example3 = new UserRolePoExample();
        UserRolePoExample.Criteria criteria3 = example3.createCriteria();
        criteria3.andSignatureIsNull();
        List<UserRolePo> userRolePoList = userRolePoMapper.selectByExample(example3);
        for (UserRolePo po : userRolePoList) {
            StringBuilder signature = StringUtil.concatString("-",
                    po.getUserId().toString(), po.getRoleId().toString(), po.getCreatorId().toString());
            String newSignature = SHA256.getSHA256(signature.toString());

            UserRolePo newPo = new UserRolePo();
            newPo.setId(po.getId());
            newPo.setSignature(newSignature);
            userRolePoMapper.updateByPrimaryKeySelective(newPo);
        }

    }

    /* auth009 */

    /**
     * 根据 id 修改用户信息
     * @param userEditVo 传入的 User 对象
     * @return 返回对象 ReturnObj
     */
    public ReturnObject<Object> modifyUserByVo(Long id, UserEditVo userEditVo) {
        // 查询密码等资料以计算新签名
        UserPo orig = userMapper.selectByPrimaryKey(id);
        // 不修改已被逻辑废弃的账户
        if (orig == null || (orig.getState() != null && User.State.getTypeByCode(orig.getState().intValue()) == User.State.DELETE)) {
            return new ReturnObject<>(ResponseCode.RESOURCE_ID_NOTEXIST);
        }

        // 构造 User 对象以计算签名
        User user = new User(orig);
        UserPo po = user.createUpdatePo(userEditVo);

        // 将更改的联系方式 (如发生变化) 的已验证字段改为 false
        if (userEditVo.getEmail() != null && !userEditVo.getEmail().equals(user.getEmail())) {
            po.setEmailVerified((byte) 0);
        }
        if (userEditVo.getMobile() != null && !userEditVo.getMobile().equals(user.getMobile())) {
            po.setMobileVerified((byte) 0);
        }

        // 更新数据库
        ReturnObject<Object> retObj;
        int ret;
        try {
            ret = userMapper.updateByPrimaryKeySelective(po);
        } catch (DataAccessException e) {
            // 如果发生 Exception，判断是邮箱还是啥重复错误
            if (Objects.requireNonNull(e.getMessage()).contains("auth_user.auth_user_mobile_uindex")) {
                retObj = new ReturnObject<>(ResponseCode.MOBILE_REGISTERED);
            } else if (e.getMessage().contains("auth_user.auth_user_email_uindex")) {
                retObj = new ReturnObject<>(ResponseCode.EMAIL_REGISTERED);
            } else {
                // 其他情况属未知错误
                retObj = new ReturnObject<>(ResponseCode.FIELD_NOTVALID);
            }
            return retObj;
        }
        // 检查更新有否成功
        if (ret == 0) {
            retObj = new ReturnObject<>(ResponseCode.RESOURCE_ID_NOTEXIST);
        } else {
            retObj = new ReturnObject<>();
        }
        return retObj;
    }

    /**
     * (物理) 删除用户
     * @param id 用户 id
     * @return 返回对象 ReturnObj
     */
    public ReturnObject<Object> physicallyDeleteUser(Long id) {
        ReturnObject<Object> retObj;
        int ret = userMapper.deleteByPrimaryKey(id);
        if (ret == 0) {
            retObj = new ReturnObject<>(ResponseCode.RESOURCE_ID_NOTEXIST);
        } else {
            retObj = new ReturnObject<>();
        }
        return retObj;
    }

    /**
     * (逻辑) 删除用户
     * @param id 用户 id
     * @return 返回对象 ReturnObj
     */
    public ReturnObject<Object> logicallyDeleteUser(Long id) {
        UserPo po = createUserStateModPo(id, User.State.DELETE);
        if (po == null) {
            return new ReturnObject<>(ResponseCode.RESOURCE_ID_NOTEXIST);
        }

        ReturnObject<Object> retObj;
        int ret = userMapper.updateByPrimaryKeySelective(po);
        if (ret == 0) {
            retObj = new ReturnObject<>(ResponseCode.RESOURCE_ID_NOTEXIST);
        } else {
            retObj = new ReturnObject<>();
        }
        return retObj;
    }


    /**
     * 创建可改变目标用户状态的 Po
     * @param id 用户 id
     * @param state 用户目标状态
     * @return UserPo 对象
     */
    private UserPo createUserStateModPo(Long id, User.State state) {
        // 查询密码等资料以计算新签名
        UserPo orig = userMapper.selectByPrimaryKey(id);
        // 不修改已被逻辑废弃的账户的状态
        if (orig == null || (orig.getState() != null && User.State.getTypeByCode(orig.getState().intValue()) == User.State.DELETE)) {
            return null;
        }

        // 构造 User 对象以计算签名
        User user = new User(orig);
        user.setState(state);
        // 构造一个全为 null 的 vo 因为其他字段都不用更新
        UserEditVo vo = new UserEditVo();

        return user.createUpdatePo(vo);
    }

    /**
     * 禁止用户登录
     * @param id 用户 id
     * @return 返回对象 ReturnObj
     */
    public ReturnObject<Object> forbidUser(Long id) {
        UserPo po = createUserStateModPo(id, User.State.FORBID);
        if (po == null) {
            return new ReturnObject<>(ResponseCode.RESOURCE_ID_NOTEXIST);
        }

        ReturnObject<Object> retObj;
        int ret = userMapper.updateByPrimaryKeySelective(po);
        if (ret == 0) {
            retObj = new ReturnObject<>(ResponseCode.RESOURCE_ID_NOTEXIST);
        } else {
            retObj = new ReturnObject<>();
        }
        return retObj;
    }

    /**
     * 解禁用户登录
     * @param id 用户 id
     * @return 返回对象 ReturnObj
     */
    public ReturnObject<Object> releaseUser(Long id) {
        UserPo po = createUserStateModPo(id, User.State.NORM);
        if (po == null) {
            return new ReturnObject<>(ResponseCode.RESOURCE_ID_NOTEXIST);
        }

        ReturnObject<Object> retObj;
        int ret = userMapper.updateByPrimaryKeySelective(po);
        if (ret == 0) {
            retObj = new ReturnObject<>(ResponseCode.RESOURCE_ID_NOTEXIST);
        } else {
            retObj = new ReturnObject<>();
        }
        return retObj;
    }

    /* auth009 ends */
}
