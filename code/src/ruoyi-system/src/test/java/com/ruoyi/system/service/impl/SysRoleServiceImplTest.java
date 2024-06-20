package com.ruoyi.system.service.impl;

import com.ruoyi.common.core.domain.entity.SysRole;
import com.ruoyi.system.domain.SysRoleDept;
import com.ruoyi.system.domain.SysRoleMenu;
import com.ruoyi.system.domain.SysUserRole;
import com.ruoyi.system.mapper.SysRoleDeptMapper;
import com.ruoyi.system.mapper.SysRoleMapper;
import com.ruoyi.system.mapper.SysRoleMenuMapper;
import com.ruoyi.system.mapper.SysUserRoleMapper;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;

import java.util.*;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import static org.mockito.MockitoAnnotations.initMocks;

class SysRoleServiceImplTest {

    @Mock
    private SysRoleMapper mockRoleMapper;
    @Mock
    private SysRoleMenuMapper mockRoleMenuMapper;
    @Mock
    private SysUserRoleMapper mockUserRoleMapper;
    @Mock
    private SysRoleDeptMapper mockRoleDeptMapper;

    @InjectMocks
    private SysRoleServiceImpl sysRoleServiceImplUnderTest;

    @BeforeEach
    void setUp() throws Exception {
        initMocks(this);
    }

    @Test
    void testSelectRoleList() {
        // Setup
        final SysRole role = null;
        when(mockRoleMapper.selectRoleList(any(SysRole.class))).thenReturn(Arrays.asList());

        // Run the test
        final List<SysRole> result = sysRoleServiceImplUnderTest.selectRoleList(role);

        // Verify the results
    }

    @Test
    void testSelectRoleList_SysRoleMapperReturnsNoItems() {
        // Setup
        final SysRole role = null;
        when(mockRoleMapper.selectRoleList(any(SysRole.class))).thenReturn(Collections.emptyList());

        // Run the test
        final List<SysRole> result = sysRoleServiceImplUnderTest.selectRoleList(role);

        // Verify the results
        assertThat(result).isEqualTo(Collections.emptyList());
    }

    @Test
    void testSelectRolesByUserId() {
        // Setup
        when(mockRoleMapper.selectRolePermissionByUserId(0L)).thenReturn(Arrays.asList());

        // Run the test
        final List<SysRole> result = sysRoleServiceImplUnderTest.selectRolesByUserId(0L);

        // Verify the results
    }

    @Test
    void testSelectRolesByUserId_SysRoleMapperReturnsNoItems() {
        // Setup
        when(mockRoleMapper.selectRolePermissionByUserId(0L)).thenReturn(Collections.emptyList());

        // Run the test
        final List<SysRole> result = sysRoleServiceImplUnderTest.selectRolesByUserId(0L);

        // Verify the results
        assertThat(result).isEqualTo(Collections.emptyList());
    }

    @Test
    void testSelectRolePermissionByUserId() {
        // Setup
        when(mockRoleMapper.selectRolePermissionByUserId(0L)).thenReturn(Arrays.asList());

        // Run the test
        final Set<String> result = sysRoleServiceImplUnderTest.selectRolePermissionByUserId(0L);

        // Verify the results
        assertThat(result).isEqualTo(new HashSet<>(Arrays.asList("value")));
    }

    @Test
    void testSelectRolePermissionByUserId_SysRoleMapperReturnsNoItems() {
        // Setup
        when(mockRoleMapper.selectRolePermissionByUserId(0L)).thenReturn(Collections.emptyList());

        // Run the test
        final Set<String> result = sysRoleServiceImplUnderTest.selectRolePermissionByUserId(0L);

        // Verify the results
        assertThat(result).isEqualTo(Collections.emptySet());
    }

    @Test
    void testSelectRoleAll() {
        // Setup
        // Run the test
        final List<SysRole> result = sysRoleServiceImplUnderTest.selectRoleAll();

        // Verify the results
    }

    @Test
    void testSelectRoleListByUserId() {
        // Setup
        when(mockRoleMapper.selectRoleListByUserId(0L)).thenReturn(Arrays.asList(0L));

        // Run the test
        final List<Long> result = sysRoleServiceImplUnderTest.selectRoleListByUserId(0L);

        // Verify the results
        assertThat(result).isEqualTo(Arrays.asList(0L));
    }

    @Test
    void testSelectRoleListByUserId_SysRoleMapperReturnsNoItems() {
        // Setup
        when(mockRoleMapper.selectRoleListByUserId(0L)).thenReturn(Collections.emptyList());

        // Run the test
        final List<Long> result = sysRoleServiceImplUnderTest.selectRoleListByUserId(0L);

        // Verify the results
        assertThat(result).isEqualTo(Collections.emptyList());
    }

    @Test
    void testSelectRoleById() {
        // Setup
        when(mockRoleMapper.selectRoleById(0L)).thenReturn(null);

        // Run the test
        final SysRole result = sysRoleServiceImplUnderTest.selectRoleById(0L);

        // Verify the results
    }

    @Test
    void testCheckRoleNameUnique() {
        // Setup
        final SysRole role = null;
        when(mockRoleMapper.checkRoleNameUnique("roleName")).thenReturn(null);

        // Run the test
        final boolean result = sysRoleServiceImplUnderTest.checkRoleNameUnique(role);

        // Verify the results
        assertThat(result).isFalse();
    }

    @Test
    void testCheckRoleKeyUnique() {
        // Setup
        final SysRole role = null;
        when(mockRoleMapper.checkRoleKeyUnique("roleKey")).thenReturn(null);

        // Run the test
        final boolean result = sysRoleServiceImplUnderTest.checkRoleKeyUnique(role);

        // Verify the results
        assertThat(result).isFalse();
    }

    @Test
    void testCheckRoleAllowed() {
        // Setup
        final SysRole role = null;

        // Run the test
        sysRoleServiceImplUnderTest.checkRoleAllowed(role);

        // Verify the results
    }

    @Test
    void testCheckRoleDataScope() {
        // Setup
        // Run the test
        sysRoleServiceImplUnderTest.checkRoleDataScope(0L);

        // Verify the results
    }

    @Test
    void testCountUserRoleByRoleId() {
        // Setup
        when(mockUserRoleMapper.countUserRoleByRoleId(0L)).thenReturn(0);

        // Run the test
        final int result = sysRoleServiceImplUnderTest.countUserRoleByRoleId(0L);

        // Verify the results
        assertThat(result).isEqualTo(0);
    }

    @Test
    void testInsertRole() {
        // Setup
        final SysRole role = null;

        // Configure SysRoleMenuMapper.batchRoleMenu(...).
        final SysRoleMenu sysRoleMenu = new SysRoleMenu();
        sysRoleMenu.setRoleId(0L);
        sysRoleMenu.setMenuId(0L);
        final List<SysRoleMenu> roleMenuList = Arrays.asList(sysRoleMenu);
        when(mockRoleMenuMapper.batchRoleMenu(roleMenuList)).thenReturn(0);

        // Run the test
        final int result = sysRoleServiceImplUnderTest.insertRole(role);

        // Verify the results
        assertThat(result).isEqualTo(0);
        verify(mockRoleMapper).insertRole(any(SysRole.class));
    }

    @Test
    void testUpdateRole() {
        // Setup
        final SysRole role = null;

        // Configure SysRoleMenuMapper.batchRoleMenu(...).
        final SysRoleMenu sysRoleMenu = new SysRoleMenu();
        sysRoleMenu.setRoleId(0L);
        sysRoleMenu.setMenuId(0L);
        final List<SysRoleMenu> roleMenuList = Arrays.asList(sysRoleMenu);
        when(mockRoleMenuMapper.batchRoleMenu(roleMenuList)).thenReturn(0);

        // Run the test
        final int result = sysRoleServiceImplUnderTest.updateRole(role);

        // Verify the results
        assertThat(result).isEqualTo(0);
        verify(mockRoleMapper).updateRole(any(SysRole.class));
        verify(mockRoleMenuMapper).deleteRoleMenuByRoleId(0L);
    }

    @Test
    void testUpdateRoleStatus() {
        // Setup
        final SysRole role = null;
        when(mockRoleMapper.updateRole(any(SysRole.class))).thenReturn(0);

        // Run the test
        final int result = sysRoleServiceImplUnderTest.updateRoleStatus(role);

        // Verify the results
        assertThat(result).isEqualTo(0);
    }

    @Test
    void testAuthDataScope() {
        // Setup
        final SysRole role = null;

        // Configure SysRoleDeptMapper.batchRoleDept(...).
        final SysRoleDept sysRoleDept = new SysRoleDept();
        sysRoleDept.setRoleId(0L);
        sysRoleDept.setDeptId(0L);
        final List<SysRoleDept> roleDeptList = Arrays.asList(sysRoleDept);
        when(mockRoleDeptMapper.batchRoleDept(roleDeptList)).thenReturn(0);

        // Run the test
        final int result = sysRoleServiceImplUnderTest.authDataScope(role);

        // Verify the results
        assertThat(result).isEqualTo(0);
        verify(mockRoleMapper).updateRole(any(SysRole.class));
        verify(mockRoleDeptMapper).deleteRoleDeptByRoleId(0L);
    }

    @Test
    void testInsertRoleMenu() {
        // Setup
        final SysRole role = null;

        // Configure SysRoleMenuMapper.batchRoleMenu(...).
        final SysRoleMenu sysRoleMenu = new SysRoleMenu();
        sysRoleMenu.setRoleId(0L);
        sysRoleMenu.setMenuId(0L);
        final List<SysRoleMenu> roleMenuList = Arrays.asList(sysRoleMenu);
        when(mockRoleMenuMapper.batchRoleMenu(roleMenuList)).thenReturn(0);

        // Run the test
        final int result = sysRoleServiceImplUnderTest.insertRoleMenu(role);

        // Verify the results
        assertThat(result).isEqualTo(0);
    }

    @Test
    void testInsertRoleDept() {
        // Setup
        final SysRole role = null;

        // Configure SysRoleDeptMapper.batchRoleDept(...).
        final SysRoleDept sysRoleDept = new SysRoleDept();
        sysRoleDept.setRoleId(0L);
        sysRoleDept.setDeptId(0L);
        final List<SysRoleDept> roleDeptList = Arrays.asList(sysRoleDept);
        when(mockRoleDeptMapper.batchRoleDept(roleDeptList)).thenReturn(0);

        // Run the test
        final int result = sysRoleServiceImplUnderTest.insertRoleDept(role);

        // Verify the results
        assertThat(result).isEqualTo(0);
    }

    @Test
    void testDeleteRoleById() {
        // Setup
        when(mockRoleMapper.deleteRoleById(0L)).thenReturn(0);

        // Run the test
        final int result = sysRoleServiceImplUnderTest.deleteRoleById(0L);

        // Verify the results
        assertThat(result).isEqualTo(0);
        verify(mockRoleMenuMapper).deleteRoleMenuByRoleId(0L);
        verify(mockRoleDeptMapper).deleteRoleDeptByRoleId(0L);
    }

    @Test
    void testDeleteRoleByIds() {
        // Setup
        when(mockRoleMapper.selectRoleById(0L)).thenReturn(null);
        when(mockUserRoleMapper.countUserRoleByRoleId(0L)).thenReturn(0);
        when(mockRoleMapper.deleteRoleByIds(any(Long[].class))).thenReturn(0);

        // Run the test
        final int result = sysRoleServiceImplUnderTest.deleteRoleByIds(new Long[]{0L});

        // Verify the results
        assertThat(result).isEqualTo(0);
        verify(mockRoleMenuMapper).deleteRoleMenu(any(Long[].class));
        verify(mockRoleDeptMapper).deleteRoleDept(any(Long[].class));
    }

    @Test
    void testDeleteAuthUser() {
        // Setup
        final SysUserRole userRole = new SysUserRole();
        userRole.setUserId(0L);
        userRole.setRoleId(0L);

        when(mockUserRoleMapper.deleteUserRoleInfo(any(SysUserRole.class))).thenReturn(0);

        // Run the test
        final int result = sysRoleServiceImplUnderTest.deleteAuthUser(userRole);

        // Verify the results
        assertThat(result).isEqualTo(0);
    }

    @Test
    void testDeleteAuthUsers() {
        // Setup
        when(mockUserRoleMapper.deleteUserRoleInfos(eq(0L), any(Long[].class))).thenReturn(0);

        // Run the test
        final int result = sysRoleServiceImplUnderTest.deleteAuthUsers(0L, new Long[]{0L});

        // Verify the results
        assertThat(result).isEqualTo(0);
    }

    @Test
    void testInsertAuthUsers() {
        // Setup
        // Configure SysUserRoleMapper.batchUserRole(...).
        final SysUserRole sysUserRole = new SysUserRole();
        sysUserRole.setUserId(0L);
        sysUserRole.setRoleId(0L);
        final List<SysUserRole> userRoleList = Arrays.asList(sysUserRole);
        when(mockUserRoleMapper.batchUserRole(userRoleList)).thenReturn(0);

        // Run the test
        final int result = sysRoleServiceImplUnderTest.insertAuthUsers(0L, new Long[]{0L});

        // Verify the results
        assertThat(result).isEqualTo(0);
    }
}
