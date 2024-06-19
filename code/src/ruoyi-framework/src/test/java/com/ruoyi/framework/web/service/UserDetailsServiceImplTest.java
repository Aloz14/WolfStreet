package com.ruoyi.framework.web.service;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;

import java.util.Arrays;
import java.util.Collections;
import java.util.HashSet;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import static org.mockito.MockitoAnnotations.initMocks;

class UserDetailsServiceImplTest {

    @Mock
    private ISysUserService mockUserService;
    @Mock
    private SysPasswordService mockPasswordService;
    @Mock
    private SysPermissionService mockPermissionService;

    @InjectMocks
    private UserDetailsServiceImpl userDetailsServiceImplUnderTest;

    @BeforeEach
    void setUp() {
        initMocks(this);
    }

    @Test
    void testLoadUserByUsername() {
        // Setup
        when(mockPermissionService.getMenuPermission(any(SysUser.class))).thenReturn(
                new HashSet<>(Arrays.asList("value")));

        // Run the test
        final UserDetails result = userDetailsServiceImplUnderTest.loadUserByUsername("username");

        // Verify the results
        verify(mockPasswordService).validate(any(SysUser.class));
    }

    @Test
    void testLoadUserByUsername_SysPermissionServiceReturnsNoItems() {
        // Setup
        when(mockPermissionService.getMenuPermission(any(SysUser.class))).thenReturn(Collections.emptySet());

        // Run the test
        final UserDetails result = userDetailsServiceImplUnderTest.loadUserByUsername("username");

        // Verify the results
        verify(mockPasswordService).validate(any(SysUser.class));
    }

    @Test
    void testCreateLoginUser() {
        // Setup
        final SysUser user = null;
        when(mockPermissionService.getMenuPermission(any(SysUser.class))).thenReturn(
                new HashSet<>(Arrays.asList("value")));

        // Run the test
        final UserDetails result = userDetailsServiceImplUnderTest.createLoginUser(user);

        // Verify the results
    }

    @Test
    void testCreateLoginUser_SysPermissionServiceReturnsNoItems() {
        // Setup
        final SysUser user = null;
        when(mockPermissionService.getMenuPermission(any(SysUser.class))).thenReturn(Collections.emptySet());

        // Run the test
        final UserDetails result = userDetailsServiceImplUnderTest.createLoginUser(user);

        // Verify the results
    }
}
