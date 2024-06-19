package com.ruoyi.system.service.impl;

import com.ruoyi.system.domain.vo.RouterVo;
import com.ruoyi.system.mapper.SysMenuMapper;
import com.ruoyi.system.mapper.SysRoleMapper;
import com.ruoyi.system.mapper.SysRoleMenuMapper;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;

import java.util.*;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.when;
import static org.mockito.MockitoAnnotations.initMocks;

class SysMenuServiceImplTest {

    @Mock
    private SysMenuMapper mockMenuMapper;
    @Mock
    private SysRoleMapper mockRoleMapper;
    @Mock
    private SysRoleMenuMapper mockRoleMenuMapper;

    @InjectMocks
    private SysMenuServiceImpl sysMenuServiceImplUnderTest;

    @BeforeEach
    void setUp() {
        initMocks(this);
    }

    @Test
    void testSelectMenuList1() {
        // Setup
        when(mockMenuMapper.selectMenuList(any(SysMenu.class))).thenReturn(Arrays.asList());
        when(mockMenuMapper.selectMenuListByUserId(any(SysMenu.class))).thenReturn(Arrays.asList());

        // Run the test
        final List<SysMenu> result = sysMenuServiceImplUnderTest.selectMenuList(0L);

        // Verify the results
    }

    @Test
    void testSelectMenuList1_SysMenuMapperSelectMenuListReturnsNoItems() {
        // Setup
        when(mockMenuMapper.selectMenuList(any(SysMenu.class))).thenReturn(Collections.emptyList());

        // Run the test
        final List<SysMenu> result = sysMenuServiceImplUnderTest.selectMenuList(0L);

        // Verify the results
        assertThat(result).isEqualTo(Collections.emptyList());
    }

    @Test
    void testSelectMenuList1_SysMenuMapperSelectMenuListByUserIdReturnsNoItems() {
        // Setup
        when(mockMenuMapper.selectMenuListByUserId(any(SysMenu.class))).thenReturn(Collections.emptyList());

        // Run the test
        final List<SysMenu> result = sysMenuServiceImplUnderTest.selectMenuList(0L);

        // Verify the results
        assertThat(result).isEqualTo(Collections.emptyList());
    }

    @Test
    void testSelectMenuList2() {
        // Setup
        final SysMenu menu = null;
        when(mockMenuMapper.selectMenuList(any(SysMenu.class))).thenReturn(Arrays.asList());
        when(mockMenuMapper.selectMenuListByUserId(any(SysMenu.class))).thenReturn(Arrays.asList());

        // Run the test
        final List<SysMenu> result = sysMenuServiceImplUnderTest.selectMenuList(menu, 0L);

        // Verify the results
    }

    @Test
    void testSelectMenuList2_SysMenuMapperSelectMenuListReturnsNoItems() {
        // Setup
        final SysMenu menu = null;
        when(mockMenuMapper.selectMenuList(any(SysMenu.class))).thenReturn(Collections.emptyList());

        // Run the test
        final List<SysMenu> result = sysMenuServiceImplUnderTest.selectMenuList(menu, 0L);

        // Verify the results
        assertThat(result).isEqualTo(Collections.emptyList());
    }

    @Test
    void testSelectMenuList2_SysMenuMapperSelectMenuListByUserIdReturnsNoItems() {
        // Setup
        final SysMenu menu = null;
        when(mockMenuMapper.selectMenuListByUserId(any(SysMenu.class))).thenReturn(Collections.emptyList());

        // Run the test
        final List<SysMenu> result = sysMenuServiceImplUnderTest.selectMenuList(menu, 0L);

        // Verify the results
        assertThat(result).isEqualTo(Collections.emptyList());
    }

    @Test
    void testSelectMenuPermsByUserId() {
        // Setup
        when(mockMenuMapper.selectMenuPermsByUserId(0L)).thenReturn(Arrays.asList("value"));

        // Run the test
        final Set<String> result = sysMenuServiceImplUnderTest.selectMenuPermsByUserId(0L);

        // Verify the results
        assertThat(result).isEqualTo(new HashSet<>(Arrays.asList("value")));
    }

    @Test
    void testSelectMenuPermsByUserId_SysMenuMapperReturnsNoItems() {
        // Setup
        when(mockMenuMapper.selectMenuPermsByUserId(0L)).thenReturn(Collections.emptyList());

        // Run the test
        final Set<String> result = sysMenuServiceImplUnderTest.selectMenuPermsByUserId(0L);

        // Verify the results
        assertThat(result).isEqualTo(Collections.emptySet());
    }

    @Test
    void testSelectMenuPermsByRoleId() {
        // Setup
        when(mockMenuMapper.selectMenuPermsByRoleId(0L)).thenReturn(Arrays.asList("value"));

        // Run the test
        final Set<String> result = sysMenuServiceImplUnderTest.selectMenuPermsByRoleId(0L);

        // Verify the results
        assertThat(result).isEqualTo(new HashSet<>(Arrays.asList("value")));
    }

    @Test
    void testSelectMenuPermsByRoleId_SysMenuMapperReturnsNoItems() {
        // Setup
        when(mockMenuMapper.selectMenuPermsByRoleId(0L)).thenReturn(Collections.emptyList());

        // Run the test
        final Set<String> result = sysMenuServiceImplUnderTest.selectMenuPermsByRoleId(0L);

        // Verify the results
        assertThat(result).isEqualTo(Collections.emptySet());
    }

    @Test
    void testSelectMenuTreeByUserId() {
        // Setup
        when(mockMenuMapper.selectMenuTreeAll()).thenReturn(Arrays.asList());
        when(mockMenuMapper.selectMenuTreeByUserId(0L)).thenReturn(Arrays.asList());

        // Run the test
        final List<SysMenu> result = sysMenuServiceImplUnderTest.selectMenuTreeByUserId(0L);

        // Verify the results
    }

    @Test
    void testSelectMenuTreeByUserId_SysMenuMapperSelectMenuTreeAllReturnsNoItems() {
        // Setup
        when(mockMenuMapper.selectMenuTreeAll()).thenReturn(Collections.emptyList());

        // Run the test
        final List<SysMenu> result = sysMenuServiceImplUnderTest.selectMenuTreeByUserId(0L);

        // Verify the results
        assertThat(result).isEqualTo(Collections.emptyList());
    }

    @Test
    void testSelectMenuTreeByUserId_SysMenuMapperSelectMenuTreeByUserIdReturnsNoItems() {
        // Setup
        when(mockMenuMapper.selectMenuTreeByUserId(0L)).thenReturn(Collections.emptyList());

        // Run the test
        final List<SysMenu> result = sysMenuServiceImplUnderTest.selectMenuTreeByUserId(0L);

        // Verify the results
        assertThat(result).isEqualTo(Collections.emptyList());
    }

    @Test
    void testSelectMenuListByRoleId() {
        // Setup
        when(mockRoleMapper.selectRoleById(0L)).thenReturn(null);
        when(mockMenuMapper.selectMenuListByRoleId(0L, false)).thenReturn(Arrays.asList(0L));

        // Run the test
        final List<Long> result = sysMenuServiceImplUnderTest.selectMenuListByRoleId(0L);

        // Verify the results
        assertThat(result).isEqualTo(Arrays.asList(0L));
    }

    @Test
    void testSelectMenuListByRoleId_SysMenuMapperReturnsNoItems() {
        // Setup
        when(mockRoleMapper.selectRoleById(0L)).thenReturn(null);
        when(mockMenuMapper.selectMenuListByRoleId(0L, false)).thenReturn(Collections.emptyList());

        // Run the test
        final List<Long> result = sysMenuServiceImplUnderTest.selectMenuListByRoleId(0L);

        // Verify the results
        assertThat(result).isEqualTo(Collections.emptyList());
    }

    @Test
    void testBuildMenus() {
        // Setup
        final List<SysMenu> menus = Arrays.asList();

        // Run the test
        final List<RouterVo> result = sysMenuServiceImplUnderTest.buildMenus(menus);

        // Verify the results
    }

    @Test
    void testBuildMenuTree() {
        // Setup
        final List<SysMenu> menus = Arrays.asList();

        // Run the test
        final List<SysMenu> result = sysMenuServiceImplUnderTest.buildMenuTree(menus);

        // Verify the results
    }

    @Test
    void testBuildMenuTreeSelect() {
        // Setup
        final List<SysMenu> menus = Arrays.asList();

        // Run the test
        final List<TreeSelect> result = sysMenuServiceImplUnderTest.buildMenuTreeSelect(menus);

        // Verify the results
    }

    @Test
    void testSelectMenuById() {
        // Setup
        when(mockMenuMapper.selectMenuById(0L)).thenReturn(null);

        // Run the test
        final SysMenu result = sysMenuServiceImplUnderTest.selectMenuById(0L);

        // Verify the results
    }

    @Test
    void testHasChildByMenuId() {
        // Setup
        when(mockMenuMapper.hasChildByMenuId(0L)).thenReturn(0);

        // Run the test
        final boolean result = sysMenuServiceImplUnderTest.hasChildByMenuId(0L);

        // Verify the results
        assertThat(result).isFalse();
    }

    @Test
    void testCheckMenuExistRole() {
        // Setup
        when(mockRoleMenuMapper.checkMenuExistRole(0L)).thenReturn(0);

        // Run the test
        final boolean result = sysMenuServiceImplUnderTest.checkMenuExistRole(0L);

        // Verify the results
        assertThat(result).isFalse();
    }

    @Test
    void testInsertMenu() {
        // Setup
        final SysMenu menu = null;
        when(mockMenuMapper.insertMenu(any(SysMenu.class))).thenReturn(0);

        // Run the test
        final int result = sysMenuServiceImplUnderTest.insertMenu(menu);

        // Verify the results
        assertThat(result).isEqualTo(0);
    }

    @Test
    void testUpdateMenu() {
        // Setup
        final SysMenu menu = null;
        when(mockMenuMapper.updateMenu(any(SysMenu.class))).thenReturn(0);

        // Run the test
        final int result = sysMenuServiceImplUnderTest.updateMenu(menu);

        // Verify the results
        assertThat(result).isEqualTo(0);
    }

    @Test
    void testDeleteMenuById() {
        // Setup
        when(mockMenuMapper.deleteMenuById(0L)).thenReturn(0);

        // Run the test
        final int result = sysMenuServiceImplUnderTest.deleteMenuById(0L);

        // Verify the results
        assertThat(result).isEqualTo(0);
    }

    @Test
    void testCheckMenuNameUnique() {
        // Setup
        final SysMenu menu = null;
        when(mockMenuMapper.checkMenuNameUnique("menuName", 0L)).thenReturn(null);

        // Run the test
        final boolean result = sysMenuServiceImplUnderTest.checkMenuNameUnique(menu);

        // Verify the results
        assertThat(result).isFalse();
    }

    @Test
    void testGetRouteName() {
        // Setup
        final SysMenu menu = null;

        // Run the test
        final String result = sysMenuServiceImplUnderTest.getRouteName(menu);

        // Verify the results
        assertThat(result).isEqualTo("name");
    }

    @Test
    void testGetRouterPath() {
        // Setup
        final SysMenu menu = null;

        // Run the test
        final String result = sysMenuServiceImplUnderTest.getRouterPath(menu);

        // Verify the results
        assertThat(result).isEqualTo("path");
    }

    @Test
    void testGetComponent() {
        // Setup
        final SysMenu menu = null;

        // Run the test
        final String result = sysMenuServiceImplUnderTest.getComponent(menu);

        // Verify the results
        assertThat(result).isEqualTo("component");
    }

    @Test
    void testIsMenuFrame() {
        // Setup
        final SysMenu menu = null;

        // Run the test
        final boolean result = sysMenuServiceImplUnderTest.isMenuFrame(menu);

        // Verify the results
        assertThat(result).isFalse();
    }

    @Test
    void testIsInnerLink() {
        // Setup
        final SysMenu menu = null;

        // Run the test
        final boolean result = sysMenuServiceImplUnderTest.isInnerLink(menu);

        // Verify the results
        assertThat(result).isFalse();
    }

    @Test
    void testIsParentView() {
        // Setup
        final SysMenu menu = null;

        // Run the test
        final boolean result = sysMenuServiceImplUnderTest.isParentView(menu);

        // Verify the results
        assertThat(result).isFalse();
    }

    @Test
    void testGetChildPerms() {
        // Setup
        final List<SysMenu> list = Arrays.asList();

        // Run the test
        final List<SysMenu> result = sysMenuServiceImplUnderTest.getChildPerms(list, 0);

        // Verify the results
    }

    @Test
    void testInnerLinkReplaceEach() {
        assertThat(sysMenuServiceImplUnderTest.innerLinkReplaceEach("path")).isEqualTo("result");
    }
}
