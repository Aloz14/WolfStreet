package com.ruoyi.framework.security.handle;

import com.ruoyi.framework.web.service.TokenService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import static org.mockito.MockitoAnnotations.initMocks;

class LogoutSuccessHandlerImplTest {

    @Mock
    private TokenService mockTokenService;

    @InjectMocks
    private LogoutSuccessHandlerImpl logoutSuccessHandlerImplUnderTest;

    @BeforeEach
    void setUp() {
        initMocks(this);
    }

    @Test
    void testOnLogoutSuccess() throws Exception {
        // Setup
        final HttpServletRequest request = null;
        final HttpServletResponse response = null;
        when(mockTokenService.getLoginUser(any(HttpServletRequest.class))).thenReturn(null);

        // Run the test
        logoutSuccessHandlerImplUnderTest.onLogoutSuccess(request, response, null);

        // Verify the results
        verify(mockTokenService).delLoginUser("token");
    }
}
