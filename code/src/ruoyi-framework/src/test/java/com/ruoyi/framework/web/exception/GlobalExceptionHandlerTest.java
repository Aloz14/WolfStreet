package com.ruoyi.framework.web.exception;

import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.exception.ServiceException;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.validation.BindException;
import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.MissingPathVariableException;
import org.springframework.web.method.annotation.MethodArgumentTypeMismatchException;

import javax.servlet.http.HttpServletRequest;

class GlobalExceptionHandlerTest {

    private GlobalExceptionHandler globalExceptionHandlerUnderTest;

    @BeforeEach
    void setUp() {
        globalExceptionHandlerUnderTest = new GlobalExceptionHandler();
    }

    @Test
    void testHandleAccessDeniedException() {
        // Setup
        final AccessDeniedException e = null;
        final HttpServletRequest request = null;

        // Run the test
        final AjaxResult result = globalExceptionHandlerUnderTest.handleAccessDeniedException(e, request);

        // Verify the results
    }

    @Test
    void testHandleHttpRequestMethodNotSupported() {
        // Setup
        final HttpRequestMethodNotSupportedException e = null;
        final HttpServletRequest request = null;

        // Run the test
        final AjaxResult result = globalExceptionHandlerUnderTest.handleHttpRequestMethodNotSupported(e, request);

        // Verify the results
    }

    @Test
    void testHandleServiceException() {
        // Setup
        final ServiceException e = null;

        // Run the test
        final AjaxResult result = globalExceptionHandlerUnderTest.handleServiceException(e, null);

        // Verify the results
    }

    @Test
    void testHandleMissingPathVariableException() {
        // Setup
        final MissingPathVariableException e = null;
        final HttpServletRequest request = null;

        // Run the test
        final AjaxResult result = globalExceptionHandlerUnderTest.handleMissingPathVariableException(e, request);

        // Verify the results
    }

    @Test
    void testHandleMethodArgumentTypeMismatchException() {
        // Setup
        final MethodArgumentTypeMismatchException e = null;
        final HttpServletRequest request = null;

        // Run the test
        final AjaxResult result = globalExceptionHandlerUnderTest.handleMethodArgumentTypeMismatchException(e, request);

        // Verify the results
    }

    @Test
    void testHandleRuntimeException() {
        // Setup
        final HttpServletRequest request = null;

        // Run the test
        final AjaxResult result = globalExceptionHandlerUnderTest.handleRuntimeException(
                new RuntimeException("message"), request);

        // Verify the results
    }

    @Test
    void testHandleException() {
        // Setup
        final HttpServletRequest request = null;

        // Run the test
        final AjaxResult result = globalExceptionHandlerUnderTest.handleException(new Exception("message"), request);

        // Verify the results
    }

    @Test
    void testHandleBindException() {
        // Setup
        final BindException e = null;

        // Run the test
        final AjaxResult result = globalExceptionHandlerUnderTest.handleBindException(e);

        // Verify the results
    }

    @Test
    void testHandleMethodArgumentNotValidException() {
        // Setup
        final MethodArgumentNotValidException e = null;

        // Run the test
        final Object result = globalExceptionHandlerUnderTest.handleMethodArgumentNotValidException(e);

        // Verify the results
    }

    @Test
    void testHandleDemoModeException() {
        // Setup
        // Run the test
        final AjaxResult result = globalExceptionHandlerUnderTest.handleDemoModeException(null);

        // Verify the results
    }
}
