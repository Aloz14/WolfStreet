package com.ruoyi.web.controller.system;

import com.ruoyi.common.core.domain.TreeSelect;
import com.ruoyi.common.core.domain.entity.SysDept;
import com.ruoyi.common.core.domain.entity.SysRole;
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.system.domain.SysPost;
import com.ruoyi.system.service.ISysDeptService;
import com.ruoyi.system.service.ISysPostService;
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
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.test.web.servlet.MockMvc;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.user;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;

@ExtendWith(SpringExtension.class)
@WebMvcTest(SysUserController.class)
class SysUserControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private ISysUserService mockUserService;
    @MockBean
    private ISysRoleService mockRoleService;
    @MockBean
    private ISysDeptService mockDeptService;
    @MockBean
    private ISysPostService mockPostService;

    @Test
    void testList() {
        // Setup
        when(mockUserService.selectUserList(any(SysUser.class))).thenReturn(Arrays.asList(new SysUser(0L)));

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(get("/system/user/list")
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testList_ISysUserServiceReturnsNoItems() {
        // Setup
        when(mockUserService.selectUserList(any(SysUser.class))).thenReturn(Collections.emptyList());

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(get("/system/user/list")
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
        when(mockUserService.selectUserList(any(SysUser.class))).thenReturn(Arrays.asList(new SysUser(0L)));

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(post("/system/user/export")
                        .content("content").contentType(MediaType.APPLICATION_JSON)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testExport_ISysUserServiceReturnsNoItems() {
        // Setup
        when(mockUserService.selectUserList(any(SysUser.class))).thenReturn(Collections.emptyList());

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(post("/system/user/export")
                        .content("content").contentType(MediaType.APPLICATION_JSON)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testImportData() {
        // Setup
        when(mockUserService.importUser(Arrays.asList(new SysUser(0L)), false, "operName")).thenReturn("result");

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(multipart("/system/user/importData")
                        .file(new MockMultipartFile("file", "originalFilename", MediaType.APPLICATION_JSON_VALUE,
                                "content".getBytes()))
                        .param("updateSupport", "false")
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testImportTemplate() {
        // Setup
        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(post("/system/user/importTemplate")
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testGetInfo() {
        // Setup
        when(mockRoleService.selectRoleAll()).thenReturn(Arrays.asList(new SysRole(0L)));

        // Configure ISysPostService.selectPostAll(...).
        final SysPost sysPost = new SysPost();
        sysPost.setCreateBy("createBy");
        sysPost.setUpdateBy("updateBy");
        sysPost.setPostId(0L);
        sysPost.setPostCode("postCode");
        sysPost.setPostName("postName");
        final List<SysPost> sysPosts = Arrays.asList(sysPost);
        when(mockPostService.selectPostAll()).thenReturn(sysPosts);

        when(mockUserService.selectUserById(0L)).thenReturn(new SysUser(0L));
        when(mockPostService.selectPostListByUserId(0L)).thenReturn(Arrays.asList(0L));

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(get("/system/user/", 0)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
        verify(mockUserService).checkUserDataScope(0L);
    }

    @Test
    void testGetInfo_ISysRoleServiceReturnsNoItems() {
        // Setup
        when(mockRoleService.selectRoleAll()).thenReturn(Collections.emptyList());

        // Configure ISysPostService.selectPostAll(...).
        final SysPost sysPost = new SysPost();
        sysPost.setCreateBy("createBy");
        sysPost.setUpdateBy("updateBy");
        sysPost.setPostId(0L);
        sysPost.setPostCode("postCode");
        sysPost.setPostName("postName");
        final List<SysPost> sysPosts = Arrays.asList(sysPost);
        when(mockPostService.selectPostAll()).thenReturn(sysPosts);

        when(mockUserService.selectUserById(0L)).thenReturn(new SysUser(0L));
        when(mockPostService.selectPostListByUserId(0L)).thenReturn(Arrays.asList(0L));

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(get("/system/user/", 0)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
        verify(mockUserService).checkUserDataScope(0L);
    }

    @Test
    void testGetInfo_ISysPostServiceSelectPostAllReturnsNoItems() {
        // Setup
        when(mockRoleService.selectRoleAll()).thenReturn(Arrays.asList(new SysRole(0L)));
        when(mockPostService.selectPostAll()).thenReturn(Collections.emptyList());
        when(mockUserService.selectUserById(0L)).thenReturn(new SysUser(0L));
        when(mockPostService.selectPostListByUserId(0L)).thenReturn(Arrays.asList(0L));

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(get("/system/user/", 0)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
        verify(mockUserService).checkUserDataScope(0L);
    }

    @Test
    void testGetInfo_ISysUserServiceSelectUserByIdReturnsNull() {
        // Setup
        when(mockRoleService.selectRoleAll()).thenReturn(Arrays.asList(new SysRole(0L)));

        // Configure ISysPostService.selectPostAll(...).
        final SysPost sysPost = new SysPost();
        sysPost.setCreateBy("createBy");
        sysPost.setUpdateBy("updateBy");
        sysPost.setPostId(0L);
        sysPost.setPostCode("postCode");
        sysPost.setPostName("postName");
        final List<SysPost> sysPosts = Arrays.asList(sysPost);
        when(mockPostService.selectPostAll()).thenReturn(sysPosts);

        when(mockUserService.selectUserById(0L)).thenReturn(null);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(get("/system/user/", 0)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
        verify(mockUserService).checkUserDataScope(0L);
    }

    @Test
    void testGetInfo_ISysPostServiceSelectPostListByUserIdReturnsNoItems() {
        // Setup
        when(mockRoleService.selectRoleAll()).thenReturn(Arrays.asList(new SysRole(0L)));

        // Configure ISysPostService.selectPostAll(...).
        final SysPost sysPost = new SysPost();
        sysPost.setCreateBy("createBy");
        sysPost.setUpdateBy("updateBy");
        sysPost.setPostId(0L);
        sysPost.setPostCode("postCode");
        sysPost.setPostName("postName");
        final List<SysPost> sysPosts = Arrays.asList(sysPost);
        when(mockPostService.selectPostAll()).thenReturn(sysPosts);

        when(mockUserService.selectUserById(0L)).thenReturn(new SysUser(0L));
        when(mockPostService.selectPostListByUserId(0L)).thenReturn(Collections.emptyList());

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(get("/system/user/", 0)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
        verify(mockUserService).checkUserDataScope(0L);
    }

    @Test
    void testAdd() {
        // Setup
        when(mockUserService.checkUserNameUnique(any(SysUser.class))).thenReturn(false);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(post("/system/user")
                        .content("content").contentType(MediaType.APPLICATION_JSON)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testAdd_ISysUserServiceCheckUserNameUniqueReturnsTrue() {
        // Setup
        when(mockUserService.checkUserNameUnique(any(SysUser.class))).thenReturn(true);
        when(mockUserService.checkPhoneUnique(any(SysUser.class))).thenReturn(false);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(post("/system/user")
                        .content("content").contentType(MediaType.APPLICATION_JSON)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testAdd_ISysUserServiceCheckPhoneUniqueReturnsTrue() {
        // Setup
        when(mockUserService.checkUserNameUnique(any(SysUser.class))).thenReturn(true);
        when(mockUserService.checkPhoneUnique(any(SysUser.class))).thenReturn(true);
        when(mockUserService.checkEmailUnique(any(SysUser.class))).thenReturn(false);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(post("/system/user")
                        .content("content").contentType(MediaType.APPLICATION_JSON)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testAdd_ISysUserServiceCheckEmailUniqueReturnsTrue() {
        // Setup
        when(mockUserService.checkUserNameUnique(any(SysUser.class))).thenReturn(true);
        when(mockUserService.checkPhoneUnique(any(SysUser.class))).thenReturn(true);
        when(mockUserService.checkEmailUnique(any(SysUser.class))).thenReturn(true);
        when(mockUserService.insertUser(any(SysUser.class))).thenReturn(0);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(post("/system/user")
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
        when(mockUserService.checkUserNameUnique(any(SysUser.class))).thenReturn(false);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(put("/system/user")
                        .content("content").contentType(MediaType.APPLICATION_JSON)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
        verify(mockUserService).checkUserAllowed(any(SysUser.class));
        verify(mockUserService).checkUserDataScope(0L);
    }

    @Test
    void testEdit_ISysUserServiceCheckUserNameUniqueReturnsTrue() {
        // Setup
        when(mockUserService.checkUserNameUnique(any(SysUser.class))).thenReturn(true);
        when(mockUserService.checkPhoneUnique(any(SysUser.class))).thenReturn(false);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(put("/system/user")
                        .content("content").contentType(MediaType.APPLICATION_JSON)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
        verify(mockUserService).checkUserAllowed(any(SysUser.class));
        verify(mockUserService).checkUserDataScope(0L);
    }

    @Test
    void testEdit_ISysUserServiceCheckPhoneUniqueReturnsTrue() {
        // Setup
        when(mockUserService.checkUserNameUnique(any(SysUser.class))).thenReturn(true);
        when(mockUserService.checkPhoneUnique(any(SysUser.class))).thenReturn(true);
        when(mockUserService.checkEmailUnique(any(SysUser.class))).thenReturn(false);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(put("/system/user")
                        .content("content").contentType(MediaType.APPLICATION_JSON)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
        verify(mockUserService).checkUserAllowed(any(SysUser.class));
        verify(mockUserService).checkUserDataScope(0L);
    }

    @Test
    void testEdit_ISysUserServiceCheckEmailUniqueReturnsTrue() {
        // Setup
        when(mockUserService.checkUserNameUnique(any(SysUser.class))).thenReturn(true);
        when(mockUserService.checkPhoneUnique(any(SysUser.class))).thenReturn(true);
        when(mockUserService.checkEmailUnique(any(SysUser.class))).thenReturn(true);
        when(mockUserService.updateUser(any(SysUser.class))).thenReturn(0);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(put("/system/user")
                        .content("content").contentType(MediaType.APPLICATION_JSON)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
        verify(mockUserService).checkUserAllowed(any(SysUser.class));
        verify(mockUserService).checkUserDataScope(0L);
    }

    @Test
    void testRemove() {
        // Setup
        when(mockUserService.deleteUserByIds(any(Long[].class))).thenReturn(0);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(delete("/system/user/{userIds}", 0)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testResetPwd() {
        // Setup
        when(mockUserService.resetPwd(any(SysUser.class))).thenReturn(0);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(put("/system/user/resetPwd")
                        .content("content").contentType(MediaType.APPLICATION_JSON)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
        verify(mockUserService).checkUserAllowed(any(SysUser.class));
        verify(mockUserService).checkUserDataScope(0L);
    }

    @Test
    void testChangeStatus() {
        // Setup
        when(mockUserService.updateUserStatus(any(SysUser.class))).thenReturn(0);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(put("/system/user/changeStatus")
                        .content("content").contentType(MediaType.APPLICATION_JSON)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
        verify(mockUserService).checkUserAllowed(any(SysUser.class));
        verify(mockUserService).checkUserDataScope(0L);
    }

    @Test
    void testAuthRole() {
        // Setup
        when(mockUserService.selectUserById(0L)).thenReturn(new SysUser(0L));
        when(mockRoleService.selectRolesByUserId(0L)).thenReturn(Arrays.asList(new SysRole(0L)));

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(get("/system/user/authRole/{userId}", 0)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testAuthRole_ISysRoleServiceReturnsNoItems() {
        // Setup
        when(mockUserService.selectUserById(0L)).thenReturn(new SysUser(0L));
        when(mockRoleService.selectRolesByUserId(0L)).thenReturn(Collections.emptyList());

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(get("/system/user/authRole/{userId}", 0)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testInsertAuthRole() {
        // Setup
        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(put("/system/user/authRole")
                        .param("userId", "0")
                        .content("content").contentType(MediaType.APPLICATION_JSON)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
        verify(mockUserService).checkUserDataScope(0L);
        verify(mockUserService).insertUserAuth(eq(0L), any(Long[].class));
    }

    @Test
    void testDeptTree() {
        // Setup
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
        final MockHttpServletResponse response = mockMvc.perform(get("/system/user/deptTree")
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testDeptTree_ISysDeptServiceReturnsNoItems() {
        // Setup
        when(mockDeptService.selectDeptTreeList(any(SysDept.class))).thenReturn(Collections.emptyList());

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(get("/system/user/deptTree")
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }
}
