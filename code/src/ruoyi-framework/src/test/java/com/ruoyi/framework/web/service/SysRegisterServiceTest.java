package com.ruoyi.framework.web.service;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.MockitoAnnotations.initMocks;

class SysRegisterServiceTest {

    @Mock
    private ISysUserService mockUserService;
    @Mock
    private ISysConfigService mockConfigService;
    @Mock
    private RedisCache mockRedisCache;

    @InjectMocks
    private SysRegisterService sysRegisterServiceUnderTest;

    @BeforeEach
    void setUp() {
        initMocks(this);
    }

    @Test
    void testRegister() {
        // Setup
        final RegisterBody registerBody = null;

        // Run the test
        final String result = sysRegisterServiceUnderTest.register(registerBody);

        // Verify the results
        assertThat(result).isEqualTo("");
    }

    @Test
    void testValidateCaptcha() {
        // Setup
        // Run the test
        sysRegisterServiceUnderTest.validateCaptcha("username", "code", "f5898e09-70af-48d7-9a87-ba9bb0c1a32d");

        // Verify the results
    }
}
