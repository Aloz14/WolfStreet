package com.ruoyi.web.controller.system;

import com.ruoyi.common.core.domain.TreeSelect;
import com.ruoyi.common.core.domain.entity.SysDept;
import com.ruoyi.common.core.domain.entity.SysRole;
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.common.core.domain.model.LoginUser;
import com.ruoyi.framework.web.service.SysPermissionService;
import com.ruoyi.framework.web.service.TokenService;
import com.ruoyi.system.domain.SysUserRole;
import com.ruoyi.system.service.ISysDeptService;
import com.ruoyi.system.service.ISysRoleService;
import com.ruoyi.system.service.ISysUserService;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.test.web.servlet.MockMvc;

import java.util.Arrays;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.user;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;

@ExtendWith(SpringExtension.class)
@WebMvcTest(SysRoleController.class)
class SysRoleControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private ISysRoleService mockRoleService;
    @MockBean
    private TokenService mockTokenService;
    @MockBean
    private SysPermissionService mockPermissionService;
    @MockBean
    private ISysUserService mockUserService;
    @MockBean
    private ISysDeptService mockDeptService;

    @Test
    void testList() {
        // Setup
        when(mockRoleService.selectRoleList(any(SysRole.class))).thenReturn(Arrays.asList(new SysRole(0L)));

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(get("/system/role/list")
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testList_ISysRoleServiceReturnsNoItems() {
        // Setup
        when(mockRoleService.selectRoleList(any(SysRole.class))).thenReturn(Collections.emptyList());

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(get("/system/role/list")
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testExport() {
        // Setup
        when(mockRoleService.selectRoleList(any(SysRole.class))).thenReturn(Arrays.asList(new SysRole(0L)));

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(post("/system/role/export")
                        .content("content").contentType(MediaType.APPLICATION_JSON)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testExport_ISysRoleServiceReturnsNoItems() {
        // Setup
        when(mockRoleService.selectRoleList(any(SysRole.class))).thenReturn(Collections.emptyList());

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(post("/system/role/export")
                        .content("content").contentType(MediaType.APPLICATION_JSON)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testGetInfo() {
        // Setup
        when(mockRoleService.selectRoleById(0L)).thenReturn(new SysRole(0L));

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(get("/system/role/{roleId}", 0)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
        verify(mockRoleService).checkRoleDataScope(0L);
    }

    @Test
    void testAdd() {
        // Setup
        when(mockRoleService.checkRoleNameUnique(any(SysRole.class))).thenReturn(false);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(post("/system/role")
                        .content("content").contentType(MediaType.APPLICATION_JSON)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testAdd_ISysRoleServiceCheckRoleNameUniqueReturnsTrue() {
        // Setup
        when(mockRoleService.checkRoleNameUnique(any(SysRole.class))).thenReturn(true);
        when(mockRoleService.checkRoleKeyUnique(any(SysRole.class))).thenReturn(false);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(post("/system/role")
                        .content("content").contentType(MediaType.APPLICATION_JSON)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testAdd_ISysRoleServiceCheckRoleKeyUniqueReturnsTrue() {
        // Setup
        when(mockRoleService.checkRoleNameUnique(any(SysRole.class))).thenReturn(true);
        when(mockRoleService.checkRoleKeyUnique(any(SysRole.class))).thenReturn(true);
        when(mockRoleService.insertRole(any(SysRole.class))).thenReturn(0);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(post("/system/role")
                        .content("content").contentType(MediaType.APPLICATION_JSON)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testEdit() {
        // Setup
        when(mockRoleService.checkRoleNameUnique(any(SysRole.class))).thenReturn(false);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(put("/system/role")
                        .content("content").contentType(MediaType.APPLICATION_JSON)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
        verify(mockRoleService).checkRoleAllowed(any(SysRole.class));
        verify(mockRoleService).checkRoleDataScope(0L);
    }

    @Test
    void testEdit_ISysRoleServiceCheckRoleNameUniqueReturnsTrue() {
        // Setup
        when(mockRoleService.checkRoleNameUnique(any(SysRole.class))).thenReturn(true);
        when(mockRoleService.checkRoleKeyUnique(any(SysRole.class))).thenReturn(false);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(put("/system/role")
                        .content("content").contentType(MediaType.APPLICATION_JSON)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
        verify(mockRoleService).checkRoleAllowed(any(SysRole.class));
        verify(mockRoleService).checkRoleDataScope(0L);
    }

    @Test
    void testEdit_ISysRoleServiceCheckRoleKeyUniqueReturnsTrue() {
        // Setup
        when(mockRoleService.checkRoleNameUnique(any(SysRole.class))).thenReturn(true);
        when(mockRoleService.checkRoleKeyUnique(any(SysRole.class))).thenReturn(true);
        when(mockRoleService.updateRole(any(SysRole.class))).thenReturn(0);
        when(mockPermissionService.getMenuPermission(any(SysUser.class))).thenReturn(
                new HashSet<>(Arrays.asList("value")));
        when(mockUserService.selectUserByUserName("userName")).thenReturn(new SysUser(0L));

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(put("/system/role")
                        .content("content").contentType(MediaType.APPLICATION_JSON)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
        verify(mockRoleService).checkRoleAllowed(any(SysRole.class));
        verify(mockRoleService).checkRoleDataScope(0L);
        verify(mockTokenService).setLoginUser(any(LoginUser.class));
    }

    @Test
    void testEdit_SysPermissionServiceReturnsNoItems() {
        // Setup
        when(mockRoleService.checkRoleNameUnique(any(SysRole.class))).thenReturn(true);
        when(mockRoleService.checkRoleKeyUnique(any(SysRole.class))).thenReturn(true);
        when(mockRoleService.updateRole(any(SysRole.class))).thenReturn(0);
        when(mockPermissionService.getMenuPermission(any(SysUser.class))).thenReturn(Collections.emptySet());
        when(mockUserService.selectUserByUserName("userName")).thenReturn(new SysUser(0L));

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(put("/system/role")
                        .content("content").contentType(MediaType.APPLICATION_JSON)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
        verify(mockRoleService).checkRoleAllowed(any(SysRole.class));
        verify(mockRoleService).checkRoleDataScope(0L);
        verify(mockTokenService).setLoginUser(any(LoginUser.class));
    }

    @Test
    void testDataScope() {
        // Setup
        when(mockRoleService.authDataScope(any(SysRole.class))).thenReturn(0);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(put("/system/role/dataScope")
                        .content("content").contentType(MediaType.APPLICATION_JSON)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
        verify(mockRoleService).checkRoleAllowed(any(SysRole.class));
        verify(mockRoleService).checkRoleDataScope(0L);
    }

    @Test
    void testChangeStatus() {
        // Setup
        when(mockRoleService.updateRoleStatus(any(SysRole.class))).thenReturn(0);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(put("/system/role/changeStatus")
                        .content("content").contentType(MediaType.APPLICATION_JSON)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
        verify(mockRoleService).checkRoleAllowed(any(SysRole.class));
        verify(mockRoleService).checkRoleDataScope(0L);
    }

    @Test
    void testRemove() {
        // Setup
        when(mockRoleService.deleteRoleByIds(any(Long[].class))).thenReturn(0);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(delete("/system/role/{roleIds}", 0)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testOptionselect() {
        // Setup
        when(mockRoleService.selectRoleAll()).thenReturn(Arrays.asList(new SysRole(0L)));

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(get("/system/role/optionselect")
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testOptionselect_ISysRoleServiceReturnsNoItems() {
        // Setup
        when(mockRoleService.selectRoleAll()).thenReturn(Collections.emptyList());

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(get("/system/role/optionselect")
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testAllocatedList() {
        // Setup
        when(mockUserService.selectAllocatedList(any(SysUser.class))).thenReturn(Arrays.asList(new SysUser(0L)));

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(get("/system/role/authUser/allocatedList")
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testAllocatedList_ISysUserServiceReturnsNoItems() {
        // Setup
        when(mockUserService.selectAllocatedList(any(SysUser.class))).thenReturn(Collections.emptyList());

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(get("/system/role/authUser/allocatedList")
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testUnallocatedList() {
        // Setup
        when(mockUserService.selectUnallocatedList(any(SysUser.class))).thenReturn(Arrays.asList(new SysUser(0L)));

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(get("/system/role/authUser/unallocatedList")
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testUnallocatedList_ISysUserServiceReturnsNoItems() {
        // Setup
        when(mockUserService.selectUnallocatedList(any(SysUser.class))).thenReturn(Collections.emptyList());

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(get("/system/role/authUser/unallocatedList")
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testCancelAuthUser() {
        // Setup
        when(mockRoleService.deleteAuthUser(any(SysUserRole.class))).thenReturn(0);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(put("/system/role/authUser/cancel")
                        .content("content").contentType(MediaType.APPLICATION_JSON)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testCancelAuthUserAll() {
        // Setup
        when(mockRoleService.deleteAuthUsers(eq(0L), any(Long[].class))).thenReturn(0);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(put("/system/role/authUser/cancelAll")
                        .param("roleId", "0")
                        .content("content").contentType(MediaType.APPLICATION_JSON)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testSelectAuthUserAll() {
        // Setup
        when(mockRoleService.insertAuthUsers(eq(0L), any(Long[].class))).thenReturn(0);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(put("/system/role/authUser/selectAll")
                        .param("roleId", "0")
                        .content("content").contentType(MediaType.APPLICATION_JSON)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
        verify(mockRoleService).checkRoleDataScope(0L);
    }

    @Test
    void testDeptTree() {
        // Setup
        when(mockDeptService.selectDeptListByRoleId(0L)).thenReturn(Arrays.asList(0L));

        // Configure ISysDeptService.selectDeptTreeList(...).
        final SysDept sysDept = new SysDept();
        sysDept.setCreateBy("createBy");
        sysDept.setUpdateBy("updateBy");
        sysDept.setDeptId(0L);
        sysDept.setParentId(0L);
        sysDept.setAncestors("ancestors");
        final List<TreeSelect> treeSelects = Arrays.asList(new TreeSelect(sysDept));
        when(mockDeptService.selectDeptTreeList(any(SysDept.class))).thenReturn(treeSelects);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(get("/system/role/deptTree/{roleId}", 0)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testDeptTree_ISysDeptServiceSelectDeptListByRoleIdReturnsNoItems() {
        // Setup
        when(mockDeptService.selectDeptListByRoleId(0L)).thenReturn(Collections.emptyList());

        // Configure ISysDeptService.selectDeptTreeList(...).
        final SysDept sysDept = new SysDept();
        sysDept.setCreateBy("createBy");
        sysDept.setUpdateBy("updateBy");
        sysDept.setDeptId(0L);
        sysDept.setParentId(0L);
        sysDept.setAncestors("ancestors");
        final List<TreeSelect> treeSelects = Arrays.asList(new TreeSelect(sysDept));
        when(mockDeptService.selectDeptTreeList(any(SysDept.class))).thenReturn(treeSelects);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(get("/system/role/deptTree/{roleId}", 0)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testDeptTree_ISysDeptServiceSelectDeptTreeListReturnsNoItems() {
        // Setup
        when(mockDeptService.selectDeptListByRoleId(0L)).thenReturn(Arrays.asList(0L));
        when(mockDeptService.selectDeptTreeList(any(SysDept.class))).thenReturn(Collections.emptyList());

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(get("/system/role/deptTree/{roleId}", 0)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }
}
