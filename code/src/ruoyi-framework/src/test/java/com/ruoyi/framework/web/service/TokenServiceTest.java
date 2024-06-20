package com.ruoyi.framework.web.service;

import com.ruoyi.common.core.domain.model.LoginUser;
import com.ruoyi.common.core.redis.RedisCache;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;

import javax.servlet.http.HttpServletRequest;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.MockitoAnnotations.initMocks;

class TokenServiceTest {

    @Mock
    private RedisCache mockRedisCache;

    @InjectMocks
    private TokenService tokenServiceUnderTest;

    @BeforeEach
    void setUp() {
        initMocks(this);
        // TODO: Set the following fields: header, secret, expireTime.
    }

    @Test
    void testGetLoginUser() {
        // Setup
        final HttpServletRequest request = null;

        // Run the test
        final LoginUser result = tokenServiceUnderTest.getLoginUser(request);

        // Verify the results
    }

    @Test
    void testSetLoginUser() {
        // Setup
        final LoginUser loginUser = null;

        // Run the test
        tokenServiceUnderTest.setLoginUser(loginUser);

        // Verify the results
    }

    @Test
    void testDelLoginUser() {
        // Setup
        // Run the test
        tokenServiceUnderTest.delLoginUser("token");

        // Verify the results
    }

    @Test
    void testCreateToken1() {
        // Setup
        final LoginUser loginUser = null;

        // Run the test
        final String result = tokenServiceUnderTest.createToken(loginUser);

        // Verify the results
        assertThat(result).isEqualTo("result");
    }

    @Test
    void testVerifyToken() {
        // Setup
        final LoginUser loginUser = null;

        // Run the test
        tokenServiceUnderTest.verifyToken(loginUser);

        // Verify the results
    }

    @Test
    void testRefreshToken() {
        // Setup
        final LoginUser loginUser = null;

        // Run the test
        tokenServiceUnderTest.refreshToken(loginUser);

        // Verify the results
    }

    @Test
    void testSetUserAgent() {
        // Setup
        final LoginUser loginUser = null;

        // Run the test
        tokenServiceUnderTest.setUserAgent(loginUser);

        // Verify the results
    }

    @Test
    void testGetUsernameFromToken() {
        assertThat(tokenServiceUnderTest.getUsernameFromToken("token")).isEqualTo("result");
    }
}
