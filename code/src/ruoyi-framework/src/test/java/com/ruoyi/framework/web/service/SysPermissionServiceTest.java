package com.ruoyi.framework.web.service;

import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.system.service.ISysMenuService;
import com.ruoyi.system.service.ISysRoleService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;

import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.MockitoAnnotations.initMocks;

class SysPermissionServiceTest {

    @Mock
    private ISysRoleService mockRoleService;
    @Mock
    private ISysMenuService mockMenuService;

    @InjectMocks
    private SysPermissionService sysPermissionServiceUnderTest;

    @BeforeEach
    void setUp() {
        initMocks(this);
    }

    @Test
    void testGetRolePermission() {
        // Setup
        final SysUser user = null;

        // Run the test
        final Set<String> result = sysPermissionServiceUnderTest.getRolePermission(user);

        // Verify the results
        assertThat(result).isEqualTo(new HashSet<>(Arrays.asList("value")));
    }

    @Test
    void testGetMenuPermission() {
        // Setup
        final SysUser user = null;

        // Run the test
        final Set<String> result = sysPermissionServiceUnderTest.getMenuPermission(user);

        // Verify the results
        assertThat(result).isEqualTo(new HashSet<>(Arrays.asList("value")));
    }
}
