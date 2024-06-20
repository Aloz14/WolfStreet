package com.ruoyi.framework.security.handle;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

import static org.assertj.core.api.Assertions.assertThatThrownBy;

class AuthenticationEntryPointImplTest {

    private AuthenticationEntryPointImpl authenticationEntryPointImplUnderTest;

    @BeforeEach
    void setUp() {
        authenticationEntryPointImplUnderTest = new AuthenticationEntryPointImpl();
    }

    @Test
    void testCommence() throws Exception {
        // Setup
        final HttpServletRequest request = null;
        final HttpServletResponse response = null;

        // Run the test
        authenticationEntryPointImplUnderTest.commence(request, response, null);

        // Verify the results
    }

    @Test
    void testCommence_ThrowsIOException() {
        // Setup
        final HttpServletRequest request = null;
        final HttpServletResponse response = null;

        // Run the test
        assertThatThrownBy(() -> authenticationEntryPointImplUnderTest.commence(request, response, null)).isInstanceOf(
                IOException.class);
    }
}
