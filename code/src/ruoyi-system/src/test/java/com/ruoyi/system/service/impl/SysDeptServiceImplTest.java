package com.ruoyi.system.service.impl;

import com.ruoyi.common.core.domain.TreeSelect;
import com.ruoyi.common.core.domain.entity.SysDept;
import com.ruoyi.system.mapper.SysDeptMapper;
import com.ruoyi.system.mapper.SysRoleMapper;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import static org.mockito.MockitoAnnotations.initMocks;

class SysDeptServiceImplTest {

    @Mock
    private SysDeptMapper mockDeptMapper;
    @Mock
    private SysRoleMapper mockRoleMapper;

    @InjectMocks
    private SysDeptServiceImpl sysDeptServiceImplUnderTest;

    @BeforeEach
    void setUp() {
        initMocks(this);
    }

    @Test
    void testSelectDeptList() {
        // Setup
        final SysDept dept = null;
        when(mockDeptMapper.selectDeptList(any(SysDept.class))).thenReturn(Arrays.asList());

        // Run the test
        final List<SysDept> result = sysDeptServiceImplUnderTest.selectDeptList(dept);

        // Verify the results
    }

    @Test
    void testSelectDeptList_SysDeptMapperReturnsNoItems() {
        // Setup
        final SysDept dept = null;
        when(mockDeptMapper.selectDeptList(any(SysDept.class))).thenReturn(Collections.emptyList());

        // Run the test
        final List<SysDept> result = sysDeptServiceImplUnderTest.selectDeptList(dept);

        // Verify the results
        assertThat(result).isEqualTo(Collections.emptyList());
    }

    @Test
    void testSelectDeptTreeList() {
        // Setup
        final SysDept dept = null;

        // Run the test
        final List<TreeSelect> result = sysDeptServiceImplUnderTest.selectDeptTreeList(dept);

        // Verify the results
    }

    @Test
    void testBuildDeptTree() {
        // Setup
        final List<SysDept> depts = Arrays.asList();

        // Run the test
        final List<SysDept> result = sysDeptServiceImplUnderTest.buildDeptTree(depts);

        // Verify the results
    }

    @Test
    void testBuildDeptTreeSelect() {
        // Setup
        final List<SysDept> depts = Arrays.asList();

        // Run the test
        final List<TreeSelect> result = sysDeptServiceImplUnderTest.buildDeptTreeSelect(depts);

        // Verify the results
    }

    @Test
    void testSelectDeptListByRoleId() {
        // Setup
        when(mockRoleMapper.selectRoleById(0L)).thenReturn(null);
        when(mockDeptMapper.selectDeptListByRoleId(0L, false)).thenReturn(Arrays.asList(0L));

        // Run the test
        final List<Long> result = sysDeptServiceImplUnderTest.selectDeptListByRoleId(0L);

        // Verify the results
        assertThat(result).isEqualTo(Arrays.asList(0L));
    }

    @Test
    void testSelectDeptListByRoleId_SysDeptMapperReturnsNoItems() {
        // Setup
        when(mockRoleMapper.selectRoleById(0L)).thenReturn(null);
        when(mockDeptMapper.selectDeptListByRoleId(0L, false)).thenReturn(Collections.emptyList());

        // Run the test
        final List<Long> result = sysDeptServiceImplUnderTest.selectDeptListByRoleId(0L);

        // Verify the results
        assertThat(result).isEqualTo(Collections.emptyList());
    }

    @Test
    void testSelectDeptById() {
        // Setup
        when(mockDeptMapper.selectDeptById(0L)).thenReturn(null);

        // Run the test
        final SysDept result = sysDeptServiceImplUnderTest.selectDeptById(0L);

        // Verify the results
    }

    @Test
    void testSelectNormalChildrenDeptById() {
        // Setup
        when(mockDeptMapper.selectNormalChildrenDeptById(0L)).thenReturn(0);

        // Run the test
        final int result = sysDeptServiceImplUnderTest.selectNormalChildrenDeptById(0L);

        // Verify the results
        assertThat(result).isEqualTo(0);
    }

    @Test
    void testHasChildByDeptId() {
        // Setup
        when(mockDeptMapper.hasChildByDeptId(0L)).thenReturn(0);

        // Run the test
        final boolean result = sysDeptServiceImplUnderTest.hasChildByDeptId(0L);

        // Verify the results
        assertThat(result).isFalse();
    }

    @Test
    void testCheckDeptExistUser() {
        // Setup
        when(mockDeptMapper.checkDeptExistUser(0L)).thenReturn(0);

        // Run the test
        final boolean result = sysDeptServiceImplUnderTest.checkDeptExistUser(0L);

        // Verify the results
        assertThat(result).isFalse();
    }

    @Test
    void testCheckDeptNameUnique() {
        // Setup
        final SysDept dept = null;
        when(mockDeptMapper.checkDeptNameUnique("deptName", 0L)).thenReturn(null);

        // Run the test
        final boolean result = sysDeptServiceImplUnderTest.checkDeptNameUnique(dept);

        // Verify the results
        assertThat(result).isFalse();
    }

    @Test
    void testCheckDeptDataScope() {
        // Setup
        // Run the test
        sysDeptServiceImplUnderTest.checkDeptDataScope(0L);

        // Verify the results
    }

    @Test
    void testInsertDept() {
        // Setup
        final SysDept dept = null;
        when(mockDeptMapper.selectDeptById(0L)).thenReturn(null);
        when(mockDeptMapper.insertDept(any(SysDept.class))).thenReturn(0);

        // Run the test
        final int result = sysDeptServiceImplUnderTest.insertDept(dept);

        // Verify the results
        assertThat(result).isEqualTo(0);
    }

    @Test
    void testUpdateDept() {
        // Setup
        final SysDept dept = null;
        when(mockDeptMapper.selectDeptById(0L)).thenReturn(null);
        when(mockDeptMapper.selectChildrenDeptById(0L)).thenReturn(Arrays.asList());
        when(mockDeptMapper.updateDept(any(SysDept.class))).thenReturn(0);

        // Run the test
        final int result = sysDeptServiceImplUnderTest.updateDept(dept);

        // Verify the results
        assertThat(result).isEqualTo(0);
        verify(mockDeptMapper).updateDeptChildren(Arrays.asList());
        verify(mockDeptMapper).updateDeptStatusNormal(any(Long[].class));
    }

    @Test
    void testUpdateDept_SysDeptMapperSelectChildrenDeptByIdReturnsNoItems() {
        // Setup
        final SysDept dept = null;
        when(mockDeptMapper.selectDeptById(0L)).thenReturn(null);
        when(mockDeptMapper.selectChildrenDeptById(0L)).thenReturn(Collections.emptyList());
        when(mockDeptMapper.updateDept(any(SysDept.class))).thenReturn(0);

        // Run the test
        final int result = sysDeptServiceImplUnderTest.updateDept(dept);

        // Verify the results
        assertThat(result).isEqualTo(0);
        verify(mockDeptMapper).updateDeptChildren(Arrays.asList());
        verify(mockDeptMapper).updateDeptStatusNormal(any(Long[].class));
    }

    @Test
    void testUpdateDeptChildren() {
        // Setup
        when(mockDeptMapper.selectChildrenDeptById(0L)).thenReturn(Arrays.asList());

        // Run the test
        sysDeptServiceImplUnderTest.updateDeptChildren(0L, "newAncestors", "oldAncestors");

        // Verify the results
        verify(mockDeptMapper).updateDeptChildren(Arrays.asList());
    }

    @Test
    void testUpdateDeptChildren_SysDeptMapperSelectChildrenDeptByIdReturnsNoItems() {
        // Setup
        when(mockDeptMapper.selectChildrenDeptById(0L)).thenReturn(Collections.emptyList());

        // Run the test
        sysDeptServiceImplUnderTest.updateDeptChildren(0L, "newAncestors", "oldAncestors");

        // Verify the results
        verify(mockDeptMapper).updateDeptChildren(Arrays.asList());
    }

    @Test
    void testDeleteDeptById() {
        // Setup
        when(mockDeptMapper.deleteDeptById(0L)).thenReturn(0);

        // Run the test
        final int result = sysDeptServiceImplUnderTest.deleteDeptById(0L);

        // Verify the results
        assertThat(result).isEqualTo(0);
    }
}
