package com.ruoyi.web.controller.system;

import com.ruoyi.common.core.domain.TreeSelect;
import com.ruoyi.common.core.domain.entity.SysDept;
import com.ruoyi.common.core.domain.entity.SysMenu;
import com.ruoyi.system.service.ISysMenuService;
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
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.when;
import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.user;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;

@ExtendWith(SpringExtension.class)
@WebMvcTest(SysMenuController.class)
class SysMenuControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private ISysMenuService mockMenuService;

    @Test
    void testList() {
        // Setup
        // Configure ISysMenuService.selectMenuList(...).
        final SysMenu sysMenu = new SysMenu();
        sysMenu.setCreateBy("createBy");
        sysMenu.setUpdateBy("updateBy");
        sysMenu.setMenuId(0L);
        sysMenu.setMenuName("menuName");
        sysMenu.setParentId(0L);
        sysMenu.setPath("path");
        sysMenu.setIsFrame("isFrame");
        final List<SysMenu> sysMenus = Arrays.asList(sysMenu);
        when(mockMenuService.selectMenuList(any(SysMenu.class), eq(0L))).thenReturn(sysMenus);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(get("/system/menu/list")
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testList_ISysMenuServiceReturnsNoItems() {
        // Setup
        when(mockMenuService.selectMenuList(any(SysMenu.class), eq(0L))).thenReturn(Collections.emptyList());

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(get("/system/menu/list")
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
        // Configure ISysMenuService.selectMenuById(...).
        final SysMenu sysMenu = new SysMenu();
        sysMenu.setCreateBy("createBy");
        sysMenu.setUpdateBy("updateBy");
        sysMenu.setMenuId(0L);
        sysMenu.setMenuName("menuName");
        sysMenu.setParentId(0L);
        sysMenu.setPath("path");
        sysMenu.setIsFrame("isFrame");
        when(mockMenuService.selectMenuById(0L)).thenReturn(sysMenu);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(get("/system/menu/{menuId}", 0)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testTreeselect() {
        // Setup
        // Configure ISysMenuService.selectMenuList(...).
        final SysMenu sysMenu = new SysMenu();
        sysMenu.setCreateBy("createBy");
        sysMenu.setUpdateBy("updateBy");
        sysMenu.setMenuId(0L);
        sysMenu.setMenuName("menuName");
        sysMenu.setParentId(0L);
        sysMenu.setPath("path");
        sysMenu.setIsFrame("isFrame");
        final List<SysMenu> sysMenus = Arrays.asList(sysMenu);
        when(mockMenuService.selectMenuList(any(SysMenu.class), eq(0L))).thenReturn(sysMenus);

        // Configure ISysMenuService.buildMenuTreeSelect(...).
        final SysDept sysDept = new SysDept();
        sysDept.setCreateBy("createBy");
        sysDept.setUpdateBy("updateBy");
        sysDept.setDeptId(0L);
        sysDept.setParentId(0L);
        sysDept.setAncestors("ancestors");
        final List<TreeSelect> treeSelects = Arrays.asList(new TreeSelect(sysDept));
        final SysMenu sysMenu1 = new SysMenu();
        sysMenu1.setCreateBy("createBy");
        sysMenu1.setUpdateBy("updateBy");
        sysMenu1.setMenuId(0L);
        sysMenu1.setMenuName("menuName");
        sysMenu1.setParentId(0L);
        sysMenu1.setPath("path");
        sysMenu1.setIsFrame("isFrame");
        final List<SysMenu> menus = Arrays.asList(sysMenu1);
        when(mockMenuService.buildMenuTreeSelect(menus)).thenReturn(treeSelects);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(get("/system/menu/treeselect")
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testTreeselect_ISysMenuServiceSelectMenuListReturnsNoItems() {
        // Setup
        when(mockMenuService.selectMenuList(any(SysMenu.class), eq(0L))).thenReturn(Collections.emptyList());

        // Configure ISysMenuService.buildMenuTreeSelect(...).
        final SysDept sysDept = new SysDept();
        sysDept.setCreateBy("createBy");
        sysDept.setUpdateBy("updateBy");
        sysDept.setDeptId(0L);
        sysDept.setParentId(0L);
        sysDept.setAncestors("ancestors");
        final List<TreeSelect> treeSelects = Arrays.asList(new TreeSelect(sysDept));
        final SysMenu sysMenu = new SysMenu();
        sysMenu.setCreateBy("createBy");
        sysMenu.setUpdateBy("updateBy");
        sysMenu.setMenuId(0L);
        sysMenu.setMenuName("menuName");
        sysMenu.setParentId(0L);
        sysMenu.setPath("path");
        sysMenu.setIsFrame("isFrame");
        final List<SysMenu> menus = Arrays.asList(sysMenu);
        when(mockMenuService.buildMenuTreeSelect(menus)).thenReturn(treeSelects);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(get("/system/menu/treeselect")
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testTreeselect_ISysMenuServiceBuildMenuTreeSelectReturnsNoItems() {
        // Setup
        // Configure ISysMenuService.selectMenuList(...).
        final SysMenu sysMenu = new SysMenu();
        sysMenu.setCreateBy("createBy");
        sysMenu.setUpdateBy("updateBy");
        sysMenu.setMenuId(0L);
        sysMenu.setMenuName("menuName");
        sysMenu.setParentId(0L);
        sysMenu.setPath("path");
        sysMenu.setIsFrame("isFrame");
        final List<SysMenu> sysMenus = Arrays.asList(sysMenu);
        when(mockMenuService.selectMenuList(any(SysMenu.class), eq(0L))).thenReturn(sysMenus);

        // Configure ISysMenuService.buildMenuTreeSelect(...).
        final SysMenu sysMenu1 = new SysMenu();
        sysMenu1.setCreateBy("createBy");
        sysMenu1.setUpdateBy("updateBy");
        sysMenu1.setMenuId(0L);
        sysMenu1.setMenuName("menuName");
        sysMenu1.setParentId(0L);
        sysMenu1.setPath("path");
        sysMenu1.setIsFrame("isFrame");
        final List<SysMenu> menus = Arrays.asList(sysMenu1);
        when(mockMenuService.buildMenuTreeSelect(menus)).thenReturn(Collections.emptyList());

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(get("/system/menu/treeselect")
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testRoleMenuTreeselect() {
        // Setup
        // Configure ISysMenuService.selectMenuList(...).
        final SysMenu sysMenu = new SysMenu();
        sysMenu.setCreateBy("createBy");
        sysMenu.setUpdateBy("updateBy");
        sysMenu.setMenuId(0L);
        sysMenu.setMenuName("menuName");
        sysMenu.setParentId(0L);
        sysMenu.setPath("path");
        sysMenu.setIsFrame("isFrame");
        final List<SysMenu> sysMenus = Arrays.asList(sysMenu);
        when(mockMenuService.selectMenuList(0L)).thenReturn(sysMenus);

        when(mockMenuService.selectMenuListByRoleId(0L)).thenReturn(Arrays.asList(0L));

        // Configure ISysMenuService.buildMenuTreeSelect(...).
        final SysDept sysDept = new SysDept();
        sysDept.setCreateBy("createBy");
        sysDept.setUpdateBy("updateBy");
        sysDept.setDeptId(0L);
        sysDept.setParentId(0L);
        sysDept.setAncestors("ancestors");
        final List<TreeSelect> treeSelects = Arrays.asList(new TreeSelect(sysDept));
        final SysMenu sysMenu1 = new SysMenu();
        sysMenu1.setCreateBy("createBy");
        sysMenu1.setUpdateBy("updateBy");
        sysMenu1.setMenuId(0L);
        sysMenu1.setMenuName("menuName");
        sysMenu1.setParentId(0L);
        sysMenu1.setPath("path");
        sysMenu1.setIsFrame("isFrame");
        final List<SysMenu> menus = Arrays.asList(sysMenu1);
        when(mockMenuService.buildMenuTreeSelect(menus)).thenReturn(treeSelects);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(get("/system/menu/roleMenuTreeselect/{roleId}", 0)
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testRoleMenuTreeselect_ISysMenuServiceSelectMenuListReturnsNoItems() {
        // Setup
        when(mockMenuService.selectMenuList(0L)).thenReturn(Collections.emptyList());
        when(mockMenuService.selectMenuListByRoleId(0L)).thenReturn(Arrays.asList(0L));

        // Configure ISysMenuService.buildMenuTreeSelect(...).
        final SysDept sysDept = new SysDept();
        sysDept.setCreateBy("createBy");
        sysDept.setUpdateBy("updateBy");
        sysDept.setDeptId(0L);
        sysDept.setParentId(0L);
        sysDept.setAncestors("ancestors");
        final List<TreeSelect> treeSelects = Arrays.asList(new TreeSelect(sysDept));
        final SysMenu sysMenu = new SysMenu();
        sysMenu.setCreateBy("createBy");
        sysMenu.setUpdateBy("updateBy");
        sysMenu.setMenuId(0L);
        sysMenu.setMenuName("menuName");
        sysMenu.setParentId(0L);
        sysMenu.setPath("path");
        sysMenu.setIsFrame("isFrame");
        final List<SysMenu> menus = Arrays.asList(sysMenu);
        when(mockMenuService.buildMenuTreeSelect(menus)).thenReturn(treeSelects);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(get("/system/menu/roleMenuTreeselect/{roleId}", 0)
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testRoleMenuTreeselect_ISysMenuServiceSelectMenuListByRoleIdReturnsNoItems() {
        // Setup
        // Configure ISysMenuService.selectMenuList(...).
        final SysMenu sysMenu = new SysMenu();
        sysMenu.setCreateBy("createBy");
        sysMenu.setUpdateBy("updateBy");
        sysMenu.setMenuId(0L);
        sysMenu.setMenuName("menuName");
        sysMenu.setParentId(0L);
        sysMenu.setPath("path");
        sysMenu.setIsFrame("isFrame");
        final List<SysMenu> sysMenus = Arrays.asList(sysMenu);
        when(mockMenuService.selectMenuList(0L)).thenReturn(sysMenus);

        when(mockMenuService.selectMenuListByRoleId(0L)).thenReturn(Collections.emptyList());

        // Configure ISysMenuService.buildMenuTreeSelect(...).
        final SysDept sysDept = new SysDept();
        sysDept.setCreateBy("createBy");
        sysDept.setUpdateBy("updateBy");
        sysDept.setDeptId(0L);
        sysDept.setParentId(0L);
        sysDept.setAncestors("ancestors");
        final List<TreeSelect> treeSelects = Arrays.asList(new TreeSelect(sysDept));
        final SysMenu sysMenu1 = new SysMenu();
        sysMenu1.setCreateBy("createBy");
        sysMenu1.setUpdateBy("updateBy");
        sysMenu1.setMenuId(0L);
        sysMenu1.setMenuName("menuName");
        sysMenu1.setParentId(0L);
        sysMenu1.setPath("path");
        sysMenu1.setIsFrame("isFrame");
        final List<SysMenu> menus = Arrays.asList(sysMenu1);
        when(mockMenuService.buildMenuTreeSelect(menus)).thenReturn(treeSelects);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(get("/system/menu/roleMenuTreeselect/{roleId}", 0)
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testRoleMenuTreeselect_ISysMenuServiceBuildMenuTreeSelectReturnsNoItems() {
        // Setup
        // Configure ISysMenuService.selectMenuList(...).
        final SysMenu sysMenu = new SysMenu();
        sysMenu.setCreateBy("createBy");
        sysMenu.setUpdateBy("updateBy");
        sysMenu.setMenuId(0L);
        sysMenu.setMenuName("menuName");
        sysMenu.setParentId(0L);
        sysMenu.setPath("path");
        sysMenu.setIsFrame("isFrame");
        final List<SysMenu> sysMenus = Arrays.asList(sysMenu);
        when(mockMenuService.selectMenuList(0L)).thenReturn(sysMenus);

        when(mockMenuService.selectMenuListByRoleId(0L)).thenReturn(Arrays.asList(0L));

        // Configure ISysMenuService.buildMenuTreeSelect(...).
        final SysMenu sysMenu1 = new SysMenu();
        sysMenu1.setCreateBy("createBy");
        sysMenu1.setUpdateBy("updateBy");
        sysMenu1.setMenuId(0L);
        sysMenu1.setMenuName("menuName");
        sysMenu1.setParentId(0L);
        sysMenu1.setPath("path");
        sysMenu1.setIsFrame("isFrame");
        final List<SysMenu> menus = Arrays.asList(sysMenu1);
        when(mockMenuService.buildMenuTreeSelect(menus)).thenReturn(Collections.emptyList());

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(get("/system/menu/roleMenuTreeselect/{roleId}", 0)
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testAdd() {
        // Setup
        when(mockMenuService.checkMenuNameUnique(any(SysMenu.class))).thenReturn(false);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(post("/system/menu")
                        .content("content").contentType(MediaType.APPLICATION_JSON)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testAdd_ISysMenuServiceCheckMenuNameUniqueReturnsTrue() {
        // Setup
        when(mockMenuService.checkMenuNameUnique(any(SysMenu.class))).thenReturn(true);
        when(mockMenuService.insertMenu(any(SysMenu.class))).thenReturn(0);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(post("/system/menu")
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
        when(mockMenuService.checkMenuNameUnique(any(SysMenu.class))).thenReturn(false);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(put("/system/menu")
                        .content("content").contentType(MediaType.APPLICATION_JSON)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testEdit_ISysMenuServiceCheckMenuNameUniqueReturnsTrue() {
        // Setup
        when(mockMenuService.checkMenuNameUnique(any(SysMenu.class))).thenReturn(true);
        when(mockMenuService.updateMenu(any(SysMenu.class))).thenReturn(0);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(put("/system/menu")
                        .content("content").contentType(MediaType.APPLICATION_JSON)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testRemove() {
        // Setup
        when(mockMenuService.hasChildByMenuId(0L)).thenReturn(false);
        when(mockMenuService.checkMenuExistRole(0L)).thenReturn(false);
        when(mockMenuService.deleteMenuById(0L)).thenReturn(0);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(delete("/system/menu/{menuId}", 0)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testRemove_ISysMenuServiceHasChildByMenuIdReturnsTrue() {
        // Setup
        when(mockMenuService.hasChildByMenuId(0L)).thenReturn(true);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(delete("/system/menu/{menuId}", 0)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testRemove_ISysMenuServiceCheckMenuExistRoleReturnsTrue() {
        // Setup
        when(mockMenuService.hasChildByMenuId(0L)).thenReturn(false);
        when(mockMenuService.checkMenuExistRole(0L)).thenReturn(true);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(delete("/system/menu/{menuId}", 0)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }
}
