package cn.edu.xmu.privilege.aop.annotation;

import cn.edu.xmu.ooad.util.JwtHelper;
import cn.edu.xmu.ooad.util.ResponseCode;
import cn.edu.xmu.ooad.util.ResponseUtil;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.lang.annotation.Annotation;
import java.lang.reflect.Method;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * @auther mingqiu
 * @date 2020/6/26 下午2:16
 */
@Aspect
@Component
public class AuditAspect {

    //注入Service用于把日志保存数据库

    private  static  final Logger logger = LoggerFactory.getLogger(AuditAspect. class);

    //Controller层切点
    @Pointcut("@annotation(cn.edu.xmu.privilege.aop.annotation.Audit)")
    public void auditAspect() {
    }

    /**
     * 前置通知 用于拦截Controller层记录用户的操作
     *
     * @param joinPoint 切点
     */
    @Before("auditAspect()")
    public void doBefore(JoinPoint joinPoint) {
    }

    //配置controller环绕通知,使用在方法aspect()上注册的切入点
    @Around("auditAspect()")
    public Object around(JoinPoint joinPoint){
        long start = System.currentTimeMillis();
        String operationTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
        MethodSignature ms = (MethodSignature) joinPoint.getSignature();
        Method method = ms.getMethod();
        // 获取注解的参数信息
        Audit auditAnno = method.getAnnotation(Audit.class);
        String operationName = auditAnno.name();
        boolean login = auditAnno.login();
        int userType = auditAnno.userType();

        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        String token = request.getHeader(JwtHelper.LOGIN_TOKEN_KEY);
        String ip = request.getRemoteAddr();
        Integer userId = new JwtHelper().getUserId(token);

        if (login) {
            if (userId == null) {
                return ResponseUtil.fail(ResponseCode.AUTH_NEED_LOGIN);
            }
        }

        Object[] args = joinPoint.getArgs();
        Annotation[][] annotations = method.getParameterAnnotations();
        for (int i = 0; i < annotations.length; i++) {
            Object param = args[i];
            Annotation[] paramAnn = annotations[i];
            //参数为空，直接下一个参数
            if (param == null || paramAnn.length == 0) {
                continue;
            }
            for (Annotation annotation : paramAnn) {
                //这里判断当前注解是否为LoginUser.class
                if (annotation.annotationType().equals(LoginUser.class)) {
                    //校验该参数，验证一次退出该注解
                    if (param instanceof Integer) {
                        args[i] = userId;
                        break;
                    }
                }
            }
        }

        Object obj = null;
        try {

            obj = ((ProceedingJoinPoint) joinPoint).proceed(args);
            long end = System.currentTimeMillis();
            logger.info("around " + joinPoint + "\tUse time : " + (end - start) + " ms!");
        } catch (Throwable e) {
            long end = System.currentTimeMillis();
                logger.info("around " + joinPoint + "\tUse time : " + (end - start) + " ms with exception : " + e.getMessage());
        }
        return obj;
    }
}