package com.ruoyi.framework.web.service;

import com.ruoyi.common.core.domain.model.LoginUser;
import com.ruoyi.common.core.redis.RedisCache;
import com.ruoyi.system.service.ISysConfigService;
import com.ruoyi.system.service.ISysUserService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.springframework.security.authentication.AuthenticationManager;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.when;
import static org.mockito.MockitoAnnotations.initMocks;

class SysLoginServiceTest {

    @Mock
    private TokenService mockTokenService;
    @Mock
    private AuthenticationManager mockAuthenticationManager;
    @Mock
    private RedisCache mockRedisCache;
    @Mock
    private ISysUserService mockUserService;
    @Mock
    private ISysConfigService mockConfigService;

    @InjectMocks
    private SysLoginService sysLoginServiceUnderTest;

    @BeforeEach
    void setUp() {
        initMocks(this);
    }

    @Test
    void testLogin() {
        // Setup
        when(mockTokenService.createToken(any(LoginUser.class))).thenReturn("result");

        // Run the test
        final String result = sysLoginServiceUnderTest.login("username", "password", "code",
                "d056a4ce-6444-41b3-98bb-bdd339ab255c");

        // Verify the results
        assertThat(result).isEqualTo("result");
    }

    @Test
    void testValidateCaptcha() {
        // Setup
        // Run the test
        sysLoginServiceUnderTest.validateCaptcha("username", "code", "6bbfba09-1a8a-4dd6-80b3-2d15f57c9285");

        // Verify the results
    }

    @Test
    void testLoginPreCheck() {
        // Setup
        // Run the test
        sysLoginServiceUnderTest.loginPreCheck("username", "password");

        // Verify the results
    }

    @Test
    void testRecordLoginInfo() {
        // Setup
        // Run the test
        sysLoginServiceUnderTest.recordLoginInfo(0L);

        // Verify the results
    }
}
