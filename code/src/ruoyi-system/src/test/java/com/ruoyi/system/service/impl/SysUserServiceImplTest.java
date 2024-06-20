package com.ruoyi.system.service.impl;

import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.system.domain.SysPost;
import com.ruoyi.system.domain.SysUserPost;
import com.ruoyi.system.domain.SysUserRole;
import com.ruoyi.system.mapper.*;
import com.ruoyi.system.service.ISysConfigService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;

import javax.validation.Validator;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import static org.mockito.MockitoAnnotations.initMocks;

class SysUserServiceImplTest {

    @Mock
    private SysUserMapper mockUserMapper;
    @Mock
    private SysRoleMapper mockRoleMapper;
    @Mock
    private SysPostMapper mockPostMapper;
    @Mock
    private SysUserRoleMapper mockUserRoleMapper;
    @Mock
    private SysUserPostMapper mockUserPostMapper;
    @Mock
    private ISysConfigService mockConfigService;
    @Mock
    private Validator mockValidator;

    @InjectMocks
    private SysUserServiceImpl sysUserServiceImplUnderTest;

    @BeforeEach
    void setUp() throws Exception {
        initMocks(this);
        sysUserServiceImplUnderTest.validator = mockValidator;
    }

    @Test
    void testSelectUserList() {
        // Setup
        final SysUser user = null;
        when(mockUserMapper.selectUserList(any(SysUser.class))).thenReturn(Arrays.asList());

        // Run the test
        final List<SysUser> result = sysUserServiceImplUnderTest.selectUserList(user);

        // Verify the results
    }

    @Test
    void testSelectUserList_SysUserMapperReturnsNoItems() {
        // Setup
        final SysUser user = null;
        when(mockUserMapper.selectUserList(any(SysUser.class))).thenReturn(Collections.emptyList());

        // Run the test
        final List<SysUser> result = sysUserServiceImplUnderTest.selectUserList(user);

        // Verify the results
        assertThat(result).isEqualTo(Collections.emptyList());
    }

    @Test
    void testSelectAllocatedList() {
        // Setup
        final SysUser user = null;
        when(mockUserMapper.selectAllocatedList(any(SysUser.class))).thenReturn(Arrays.asList());

        // Run the test
        final List<SysUser> result = sysUserServiceImplUnderTest.selectAllocatedList(user);

        // Verify the results
    }

    @Test
    void testSelectAllocatedList_SysUserMapperReturnsNoItems() {
        // Setup
        final SysUser user = null;
        when(mockUserMapper.selectAllocatedList(any(SysUser.class))).thenReturn(Collections.emptyList());

        // Run the test
        final List<SysUser> result = sysUserServiceImplUnderTest.selectAllocatedList(user);

        // Verify the results
        assertThat(result).isEqualTo(Collections.emptyList());
    }

    @Test
    void testSelectUnallocatedList() {
        // Setup
        final SysUser user = null;
        when(mockUserMapper.selectUnallocatedList(any(SysUser.class))).thenReturn(Arrays.asList());

        // Run the test
        final List<SysUser> result = sysUserServiceImplUnderTest.selectUnallocatedList(user);

        // Verify the results
    }

    @Test
    void testSelectUnallocatedList_SysUserMapperReturnsNoItems() {
        // Setup
        final SysUser user = null;
        when(mockUserMapper.selectUnallocatedList(any(SysUser.class))).thenReturn(Collections.emptyList());

        // Run the test
        final List<SysUser> result = sysUserServiceImplUnderTest.selectUnallocatedList(user);

        // Verify the results
        assertThat(result).isEqualTo(Collections.emptyList());
    }

    @Test
    void testSelectUserByUserName() {
        // Setup
        when(mockUserMapper.selectUserByUserName("userName")).thenReturn(null);

        // Run the test
        final SysUser result = sysUserServiceImplUnderTest.selectUserByUserName("userName");

        // Verify the results
    }

    @Test
    void testSelectUserById() {
        // Setup
        when(mockUserMapper.selectUserById(0L)).thenReturn(null);

        // Run the test
        final SysUser result = sysUserServiceImplUnderTest.selectUserById(0L);

        // Verify the results
    }

    @Test
    void testSelectUserByRiskLevel() {
        // Setup
        when(mockUserMapper.selectUserByRiskLevel("riskLevel")).thenReturn(null);

        // Run the test
        final SysUser result = sysUserServiceImplUnderTest.selectUserByRiskLevel("riskLevel");

        // Verify the results
    }

    @Test
    void testSelectUserRoleGroup() {
        // Setup
        when(mockRoleMapper.selectRolesByUserName("userName")).thenReturn(Arrays.asList());

        // Run the test
        final String result = sysUserServiceImplUnderTest.selectUserRoleGroup("userName");

        // Verify the results
        assertThat(result).isEqualTo("result");
    }

    @Test
    void testSelectUserRoleGroup_SysRoleMapperReturnsNoItems() {
        // Setup
        when(mockRoleMapper.selectRolesByUserName("userName")).thenReturn(Collections.emptyList());

        // Run the test
        final String result = sysUserServiceImplUnderTest.selectUserRoleGroup("userName");

        // Verify the results
        assertThat(result).isEqualTo("result");
    }

    @Test
    void testSelectUserPostGroup() {
        // Setup
        // Configure SysPostMapper.selectPostsByUserName(...).
        final SysPost sysPost = new SysPost();
        sysPost.setPostId(0L);
        sysPost.setPostCode("postCode");
        sysPost.setPostName("postName");
        sysPost.setPostSort(0);
        sysPost.setStatus("status");
        final List<SysPost> sysPosts = Arrays.asList(sysPost);
        when(mockPostMapper.selectPostsByUserName("userName")).thenReturn(sysPosts);

        // Run the test
        final String result = sysUserServiceImplUnderTest.selectUserPostGroup("userName");

        // Verify the results
        assertThat(result).isEqualTo("result");
    }

    @Test
    void testSelectUserPostGroup_SysPostMapperReturnsNoItems() {
        // Setup
        when(mockPostMapper.selectPostsByUserName("userName")).thenReturn(Collections.emptyList());

        // Run the test
        final String result = sysUserServiceImplUnderTest.selectUserPostGroup("userName");

        // Verify the results
        assertThat(result).isEqualTo("result");
    }

    @Test
    void testCheckUserNameUnique() {
        // Setup
        final SysUser user = null;
        when(mockUserMapper.checkUserNameUnique("userName")).thenReturn(null);

        // Run the test
        final boolean result = sysUserServiceImplUnderTest.checkUserNameUnique(user);

        // Verify the results
        assertThat(result).isFalse();
    }

    @Test
    void testCheckPhoneUnique() {
        // Setup
        final SysUser user = null;
        when(mockUserMapper.checkPhoneUnique("phonenumber")).thenReturn(null);

        // Run the test
        final boolean result = sysUserServiceImplUnderTest.checkPhoneUnique(user);

        // Verify the results
        assertThat(result).isFalse();
    }

    @Test
    void testCheckEmailUnique() {
        // Setup
        final SysUser user = null;
        when(mockUserMapper.checkEmailUnique("email")).thenReturn(null);

        // Run the test
        final boolean result = sysUserServiceImplUnderTest.checkEmailUnique(user);

        // Verify the results
        assertThat(result).isFalse();
    }

    @Test
    void testCheckUserAllowed() {
        // Setup
        final SysUser user = null;

        // Run the test
        sysUserServiceImplUnderTest.checkUserAllowed(user);

        // Verify the results
    }

    @Test
    void testCheckUserDataScope() {
        // Setup
        // Run the test
        sysUserServiceImplUnderTest.checkUserDataScope(0L);

        // Verify the results
    }

    @Test
    void testInsertUser() {
        // Setup
        final SysUser user = null;
        when(mockUserMapper.insertUser(any(SysUser.class))).thenReturn(0);

        // Run the test
        final int result = sysUserServiceImplUnderTest.insertUser(user);

        // Verify the results
        assertThat(result).isEqualTo(0);

        // Confirm SysUserPostMapper.batchUserPost(...).
        final SysUserPost sysUserPost = new SysUserPost();
        sysUserPost.setUserId(0L);
        sysUserPost.setPostId(0L);
        final List<SysUserPost> userPostList = Arrays.asList(sysUserPost);
        verify(mockUserPostMapper).batchUserPost(userPostList);

        // Confirm SysUserRoleMapper.batchUserRole(...).
        final SysUserRole sysUserRole = new SysUserRole();
        sysUserRole.setUserId(0L);
        sysUserRole.setRoleId(0L);
        final List<SysUserRole> userRoleList = Arrays.asList(sysUserRole);
        verify(mockUserRoleMapper).batchUserRole(userRoleList);
    }

    @Test
    void testRegisterUser() {
        // Setup
        final SysUser user = null;
        when(mockUserMapper.insertUser(any(SysUser.class))).thenReturn(0);

        // Run the test
        final boolean result = sysUserServiceImplUnderTest.registerUser(user);

        // Verify the results
        assertThat(result).isFalse();
    }

    @Test
    void testUpdateUser() {
        // Setup
        final SysUser user = null;
        when(mockUserMapper.updateUser(any(SysUser.class))).thenReturn(0);

        // Run the test
        final int result = sysUserServiceImplUnderTest.updateUser(user);

        // Verify the results
        assertThat(result).isEqualTo(0);
        verify(mockUserRoleMapper).deleteUserRoleByUserId(0L);

        // Confirm SysUserRoleMapper.batchUserRole(...).
        final SysUserRole sysUserRole = new SysUserRole();
        sysUserRole.setUserId(0L);
        sysUserRole.setRoleId(0L);
        final List<SysUserRole> userRoleList = Arrays.asList(sysUserRole);
        verify(mockUserRoleMapper).batchUserRole(userRoleList);
        verify(mockUserPostMapper).deleteUserPostByUserId(0L);

        // Confirm SysUserPostMapper.batchUserPost(...).
        final SysUserPost sysUserPost = new SysUserPost();
        sysUserPost.setUserId(0L);
        sysUserPost.setPostId(0L);
        final List<SysUserPost> userPostList = Arrays.asList(sysUserPost);
        verify(mockUserPostMapper).batchUserPost(userPostList);
    }

    @Test
    void testInsertUserAuth() {
        // Setup
        // Run the test
        sysUserServiceImplUnderTest.insertUserAuth(0L, new Long[]{0L});

        // Verify the results
        verify(mockUserRoleMapper).deleteUserRoleByUserId(0L);

        // Confirm SysUserRoleMapper.batchUserRole(...).
        final SysUserRole sysUserRole = new SysUserRole();
        sysUserRole.setUserId(0L);
        sysUserRole.setRoleId(0L);
        final List<SysUserRole> userRoleList = Arrays.asList(sysUserRole);
        verify(mockUserRoleMapper).batchUserRole(userRoleList);
    }

    @Test
    void testUpdateUserStatus() {
        // Setup
        final SysUser user = null;
        when(mockUserMapper.updateUser(any(SysUser.class))).thenReturn(0);

        // Run the test
        final int result = sysUserServiceImplUnderTest.updateUserStatus(user);

        // Verify the results
        assertThat(result).isEqualTo(0);
    }

    @Test
    void testUpdateUserProfile() {
        // Setup
        final SysUser user = null;
        when(mockUserMapper.updateUser(any(SysUser.class))).thenReturn(0);

        // Run the test
        final int result = sysUserServiceImplUnderTest.updateUserProfile(user);

        // Verify the results
        assertThat(result).isEqualTo(0);
    }

    @Test
    void testUpdateUserAvatar() {
        // Setup
        when(mockUserMapper.updateUserAvatar("userName", "avatar")).thenReturn(0);

        // Run the test
        final boolean result = sysUserServiceImplUnderTest.updateUserAvatar("userName", "avatar");

        // Verify the results
        assertThat(result).isFalse();
    }

    @Test
    void testResetPwd() {
        // Setup
        final SysUser user = null;
        when(mockUserMapper.updateUser(any(SysUser.class))).thenReturn(0);

        // Run the test
        final int result = sysUserServiceImplUnderTest.resetPwd(user);

        // Verify the results
        assertThat(result).isEqualTo(0);
    }

    @Test
    void testResetUserPwd() {
        // Setup
        when(mockUserMapper.resetUserPwd("userName", "password")).thenReturn(0);

        // Run the test
        final int result = sysUserServiceImplUnderTest.resetUserPwd("userName", "password");

        // Verify the results
        assertThat(result).isEqualTo(0);
    }

    @Test
    void testInsertUserRole1() {
        // Setup
        final SysUser user = null;

        // Run the test
        sysUserServiceImplUnderTest.insertUserRole(user);

        // Verify the results
        // Confirm SysUserRoleMapper.batchUserRole(...).
        final SysUserRole sysUserRole = new SysUserRole();
        sysUserRole.setUserId(0L);
        sysUserRole.setRoleId(0L);
        final List<SysUserRole> userRoleList = Arrays.asList(sysUserRole);
        verify(mockUserRoleMapper).batchUserRole(userRoleList);
    }

    @Test
    void testInsertUserPost() {
        // Setup
        final SysUser user = null;

        // Run the test
        sysUserServiceImplUnderTest.insertUserPost(user);

        // Verify the results
        // Confirm SysUserPostMapper.batchUserPost(...).
        final SysUserPost sysUserPost = new SysUserPost();
        sysUserPost.setUserId(0L);
        sysUserPost.setPostId(0L);
        final List<SysUserPost> userPostList = Arrays.asList(sysUserPost);
        verify(mockUserPostMapper).batchUserPost(userPostList);
    }

    @Test
    void testInsertUserRole2() {
        // Setup
        // Run the test
        sysUserServiceImplUnderTest.insertUserRole(0L, new Long[]{0L});

        // Verify the results
        // Confirm SysUserRoleMapper.batchUserRole(...).
        final SysUserRole sysUserRole = new SysUserRole();
        sysUserRole.setUserId(0L);
        sysUserRole.setRoleId(0L);
        final List<SysUserRole> userRoleList = Arrays.asList(sysUserRole);
        verify(mockUserRoleMapper).batchUserRole(userRoleList);
    }

    @Test
    void testDeleteUserById() {
        // Setup
        when(mockUserMapper.deleteUserById(0L)).thenReturn(0);

        // Run the test
        final int result = sysUserServiceImplUnderTest.deleteUserById(0L);

        // Verify the results
        assertThat(result).isEqualTo(0);
        verify(mockUserRoleMapper).deleteUserRoleByUserId(0L);
        verify(mockUserPostMapper).deleteUserPostByUserId(0L);
    }

    @Test
    void testDeleteUserByIds() {
        // Setup
        when(mockUserMapper.deleteUserByIds(any(Long[].class))).thenReturn(0);

        // Run the test
        final int result = sysUserServiceImplUnderTest.deleteUserByIds(new Long[]{0L});

        // Verify the results
        assertThat(result).isEqualTo(0);
        verify(mockUserRoleMapper).deleteUserRole(any(Long[].class));
        verify(mockUserPostMapper).deleteUserPost(any(Long[].class));
    }

    @Test
    void testImportUser() {
        // Setup
        final List<SysUser> userList = Arrays.asList();
        when(mockConfigService.selectConfigByKey("sys.user.initPassword")).thenReturn("result");
        when(mockUserMapper.selectUserByUserName("userName")).thenReturn(null);

        // Run the test
        final String result = sysUserServiceImplUnderTest.importUser(userList, false, "operName");

        // Verify the results
        assertThat(result).isEqualTo("result");
        verify(mockUserMapper).insertUser(any(SysUser.class));
        verify(mockUserMapper).updateUser(any(SysUser.class));
    }
}
