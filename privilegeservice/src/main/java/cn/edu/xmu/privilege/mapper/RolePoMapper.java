package cn.edu.xmu.privilege.mapper;

import cn.edu.xmu.privilege.model.po.RolePo;
import cn.edu.xmu.privilege.model.po.RolePoExample;
import java.util.List;

public interface RolePoMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table auth_role
     *
     * @mbg.generated
     */
    int deleteByPrimaryKey(Long id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table auth_role
     *
     * @mbg.generated
     */
    int insert(RolePo record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table auth_role
     *
     * @mbg.generated
     */
    int insertSelective(RolePo record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table auth_role
     *
     * @mbg.generated
     */
    List<RolePo> selectByExample(RolePoExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table auth_role
     *
     * @mbg.generated
     */
    RolePo selectByPrimaryKey(Long id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table auth_role
     *
     * @mbg.generated
     */
    int updateByPrimaryKeySelective(RolePo record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table auth_role
     *
     * @mbg.generated
     */
    int updateByPrimaryKey(RolePo record);
}