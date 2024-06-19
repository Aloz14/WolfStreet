package com.ruoyi.web.controller.system;

import com.ruoyi.common.core.domain.entity.SysMenu;
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.framework.web.service.SysLoginService;
import com.ruoyi.framework.web.service.SysPermissionService;
import com.ruoyi.system.domain.vo.RouterVo;
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
import java.util.HashSet;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;

@ExtendWith(SpringExtension.class)
@WebMvcTest(SysLoginController.class)
class SysLoginControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private SysLoginService mockLoginService;
    @MockBean
    private ISysMenuService mockMenuService;
    @MockBean
    private SysPermissionService mockPermissionService;

    @Test
    void testLogin() {
        // Setup
        when(mockLoginService.login("username", "password", "code", "uuid")).thenReturn("result");

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(post("/login")
                        .content("content").contentType(MediaType.APPLICATION_JSON)
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testGetInfo() {
        // Setup
        when(mockPermissionService.getRolePermission(any(SysUser.class))).thenReturn(
                new HashSet<>(Arrays.asList("value")));
        when(mockPermissionService.getMenuPermission(any(SysUser.class))).thenReturn(
                new HashSet<>(Arrays.asList("value")));

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(get("/getInfo")
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testGetInfo_SysPermissionServiceGetRolePermissionReturnsNoItems() {
        // Setup
        when(mockPermissionService.getRolePermission(any(SysUser.class))).thenReturn(Collections.emptySet());
        when(mockPermissionService.getMenuPermission(any(SysUser.class))).thenReturn(
                new HashSet<>(Arrays.asList("value")));

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(get("/getInfo")
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testGetInfo_SysPermissionServiceGetMenuPermissionReturnsNoItems() {
        // Setup
        when(mockPermissionService.getRolePermission(any(SysUser.class))).thenReturn(
                new HashSet<>(Arrays.asList("value")));
        when(mockPermissionService.getMenuPermission(any(SysUser.class))).thenReturn(Collections.emptySet());

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(get("/getInfo")
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testGetRouters() {
        // Setup
        // Configure ISysMenuService.selectMenuTreeByUserId(...).
        final SysMenu sysMenu = new SysMenu();
        sysMenu.setMenuId(0L);
        sysMenu.setMenuName("menuName");
        sysMenu.setParentName("parentName");
        sysMenu.setParentId(0L);
        sysMenu.setOrderNum(0);
        final List<SysMenu> sysMenus = Arrays.asList(sysMenu);
        when(mockMenuService.selectMenuTreeByUserId(0L)).thenReturn(sysMenus);

        // Configure ISysMenuService.buildMenus(...).
        final RouterVo routerVo = new RouterVo();
        routerVo.setName("name");
        routerVo.setPath("path");
        routerVo.setHidden(false);
        routerVo.setRedirect("redirect");
        routerVo.setComponent("component");
        final List<RouterVo> routerVos = Arrays.asList(routerVo);
        final SysMenu sysMenu1 = new SysMenu();
        sysMenu1.setMenuId(0L);
        sysMenu1.setMenuName("menuName");
        sysMenu1.setParentName("parentName");
        sysMenu1.setParentId(0L);
        sysMenu1.setOrderNum(0);
        final List<SysMenu> menus = Arrays.asList(sysMenu1);
        when(mockMenuService.buildMenus(menus)).thenReturn(routerVos);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(get("/getRouters")
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testGetRouters_ISysMenuServiceSelectMenuTreeByUserIdReturnsNoItems() {
        // Setup
        when(mockMenuService.selectMenuTreeByUserId(0L)).thenReturn(Collections.emptyList());

        // Configure ISysMenuService.buildMenus(...).
        final RouterVo routerVo = new RouterVo();
        routerVo.setName("name");
        routerVo.setPath("path");
        routerVo.setHidden(false);
        routerVo.setRedirect("redirect");
        routerVo.setComponent("component");
        final List<RouterVo> routerVos = Arrays.asList(routerVo);
        final SysMenu sysMenu = new SysMenu();
        sysMenu.setMenuId(0L);
        sysMenu.setMenuName("menuName");
        sysMenu.setParentName("parentName");
        sysMenu.setParentId(0L);
        sysMenu.setOrderNum(0);
        final List<SysMenu> menus = Arrays.asList(sysMenu);
        when(mockMenuService.buildMenus(menus)).thenReturn(routerVos);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(get("/getRouters")
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testGetRouters_ISysMenuServiceBuildMenusReturnsNoItems() {
        // Setup
        // Configure ISysMenuService.selectMenuTreeByUserId(...).
        final SysMenu sysMenu = new SysMenu();
        sysMenu.setMenuId(0L);
        sysMenu.setMenuName("menuName");
        sysMenu.setParentName("parentName");
        sysMenu.setParentId(0L);
        sysMenu.setOrderNum(0);
        final List<SysMenu> sysMenus = Arrays.asList(sysMenu);
        when(mockMenuService.selectMenuTreeByUserId(0L)).thenReturn(sysMenus);

        // Configure ISysMenuService.buildMenus(...).
        final SysMenu sysMenu1 = new SysMenu();
        sysMenu1.setMenuId(0L);
        sysMenu1.setMenuName("menuName");
        sysMenu1.setParentName("parentName");
        sysMenu1.setParentId(0L);
        sysMenu1.setOrderNum(0);
        final List<SysMenu> menus = Arrays.asList(sysMenu1);
        when(mockMenuService.buildMenus(menus)).thenReturn(Collections.emptyList());

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(get("/getRouters")
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }
}
