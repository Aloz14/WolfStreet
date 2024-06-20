package com.ruoyi.system.service.impl;

import com.ruoyi.common.core.domain.entity.SysDictData;
import com.ruoyi.common.core.domain.entity.SysDictType;
import com.ruoyi.system.mapper.SysDictDataMapper;
import com.ruoyi.system.mapper.SysDictTypeMapper;
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

class SysDictTypeServiceImplTest {

    @Mock
    private SysDictTypeMapper mockDictTypeMapper;
    @Mock
    private SysDictDataMapper mockDictDataMapper;

    @InjectMocks
    private SysDictTypeServiceImpl sysDictTypeServiceImplUnderTest;

    @BeforeEach
    void setUp() {
        initMocks(this);
    }

    @Test
    void testInit() {
        // Setup
        when(mockDictDataMapper.selectDictDataList(any(SysDictData.class))).thenReturn(Arrays.asList());

        // Run the test
        sysDictTypeServiceImplUnderTest.init();

        // Verify the results
    }

    @Test
    void testInit_SysDictDataMapperReturnsNoItems() {
        // Setup
        when(mockDictDataMapper.selectDictDataList(any(SysDictData.class))).thenReturn(Collections.emptyList());

        // Run the test
        sysDictTypeServiceImplUnderTest.init();

        // Verify the results
    }

    @Test
    void testSelectDictTypeList() {
        // Setup
        final SysDictType dictType = null;
        when(mockDictTypeMapper.selectDictTypeList(any(SysDictType.class))).thenReturn(Arrays.asList());

        // Run the test
        final List<SysDictType> result = sysDictTypeServiceImplUnderTest.selectDictTypeList(dictType);

        // Verify the results
    }

    @Test
    void testSelectDictTypeList_SysDictTypeMapperReturnsNoItems() {
        // Setup
        final SysDictType dictType = null;
        when(mockDictTypeMapper.selectDictTypeList(any(SysDictType.class))).thenReturn(Collections.emptyList());

        // Run the test
        final List<SysDictType> result = sysDictTypeServiceImplUnderTest.selectDictTypeList(dictType);

        // Verify the results
        assertThat(result).isEqualTo(Collections.emptyList());
    }

    @Test
    void testSelectDictTypeAll() {
        // Setup
        when(mockDictTypeMapper.selectDictTypeAll()).thenReturn(Arrays.asList());

        // Run the test
        final List<SysDictType> result = sysDictTypeServiceImplUnderTest.selectDictTypeAll();

        // Verify the results
    }

    @Test
    void testSelectDictTypeAll_SysDictTypeMapperReturnsNoItems() {
        // Setup
        when(mockDictTypeMapper.selectDictTypeAll()).thenReturn(Collections.emptyList());

        // Run the test
        final List<SysDictType> result = sysDictTypeServiceImplUnderTest.selectDictTypeAll();

        // Verify the results
        assertThat(result).isEqualTo(Collections.emptyList());
    }

    @Test
    void testSelectDictDataByType() {
        // Setup
        when(mockDictDataMapper.selectDictDataByType("dictType")).thenReturn(Arrays.asList());

        // Run the test
        final List<SysDictData> result = sysDictTypeServiceImplUnderTest.selectDictDataByType("dictType");

        // Verify the results
    }

    @Test
    void testSelectDictDataByType_SysDictDataMapperReturnsNoItems() {
        // Setup
        when(mockDictDataMapper.selectDictDataByType("dictType")).thenReturn(Collections.emptyList());

        // Run the test
        final List<SysDictData> result = sysDictTypeServiceImplUnderTest.selectDictDataByType("dictType");

        // Verify the results
        assertThat(result).isEqualTo(Collections.emptyList());
    }

    @Test
    void testSelectDictTypeById() {
        // Setup
        when(mockDictTypeMapper.selectDictTypeById(0L)).thenReturn(null);

        // Run the test
        final SysDictType result = sysDictTypeServiceImplUnderTest.selectDictTypeById(0L);

        // Verify the results
    }

    @Test
    void testSelectDictTypeByType() {
        // Setup
        when(mockDictTypeMapper.selectDictTypeByType("dictType")).thenReturn(null);

        // Run the test
        final SysDictType result = sysDictTypeServiceImplUnderTest.selectDictTypeByType("dictType");

        // Verify the results
    }

    @Test
    void testDeleteDictTypeByIds() {
        // Setup
        when(mockDictTypeMapper.selectDictTypeById(0L)).thenReturn(null);
        when(mockDictDataMapper.countDictDataByType("dictType")).thenReturn(0);

        // Run the test
        sysDictTypeServiceImplUnderTest.deleteDictTypeByIds(new Long[]{0L});

        // Verify the results
        verify(mockDictTypeMapper).deleteDictTypeById(0L);
    }

    @Test
    void testLoadingDictCache() {
        // Setup
        when(mockDictDataMapper.selectDictDataList(any(SysDictData.class))).thenReturn(Arrays.asList());

        // Run the test
        sysDictTypeServiceImplUnderTest.loadingDictCache();

        // Verify the results
    }

    @Test
    void testLoadingDictCache_SysDictDataMapperReturnsNoItems() {
        // Setup
        when(mockDictDataMapper.selectDictDataList(any(SysDictData.class))).thenReturn(Collections.emptyList());

        // Run the test
        sysDictTypeServiceImplUnderTest.loadingDictCache();

        // Verify the results
    }

    @Test
    void testClearDictCache() {
        // Setup
        // Run the test
        sysDictTypeServiceImplUnderTest.clearDictCache();

        // Verify the results
    }

    @Test
    void testResetDictCache() {
        // Setup
        when(mockDictDataMapper.selectDictDataList(any(SysDictData.class))).thenReturn(Arrays.asList());

        // Run the test
        sysDictTypeServiceImplUnderTest.resetDictCache();

        // Verify the results
    }

    @Test
    void testResetDictCache_SysDictDataMapperReturnsNoItems() {
        // Setup
        when(mockDictDataMapper.selectDictDataList(any(SysDictData.class))).thenReturn(Collections.emptyList());

        // Run the test
        sysDictTypeServiceImplUnderTest.resetDictCache();

        // Verify the results
    }

    @Test
    void testInsertDictType() {
        // Setup
        final SysDictType dict = null;
        when(mockDictTypeMapper.insertDictType(any(SysDictType.class))).thenReturn(0);

        // Run the test
        final int result = sysDictTypeServiceImplUnderTest.insertDictType(dict);

        // Verify the results
        assertThat(result).isEqualTo(0);
    }

    @Test
    void testUpdateDictType() {
        // Setup
        final SysDictType dict = null;
        when(mockDictTypeMapper.selectDictTypeById(0L)).thenReturn(null);
        when(mockDictTypeMapper.updateDictType(any(SysDictType.class))).thenReturn(0);
        when(mockDictDataMapper.selectDictDataByType("dictType")).thenReturn(Arrays.asList());

        // Run the test
        final int result = sysDictTypeServiceImplUnderTest.updateDictType(dict);

        // Verify the results
        assertThat(result).isEqualTo(0);
        verify(mockDictDataMapper).updateDictDataType("oldDictType", "newDictType");
    }

    @Test
    void testUpdateDictType_SysDictDataMapperSelectDictDataByTypeReturnsNoItems() {
        // Setup
        final SysDictType dict = null;
        when(mockDictTypeMapper.selectDictTypeById(0L)).thenReturn(null);
        when(mockDictTypeMapper.updateDictType(any(SysDictType.class))).thenReturn(0);
        when(mockDictDataMapper.selectDictDataByType("dictType")).thenReturn(Collections.emptyList());

        // Run the test
        final int result = sysDictTypeServiceImplUnderTest.updateDictType(dict);

        // Verify the results
        assertThat(result).isEqualTo(0);
        verify(mockDictDataMapper).updateDictDataType("oldDictType", "newDictType");
    }

    @Test
    void testCheckDictTypeUnique() {
        // Setup
        final SysDictType dict = null;
        when(mockDictTypeMapper.checkDictTypeUnique("dictType")).thenReturn(null);

        // Run the test
        final boolean result = sysDictTypeServiceImplUnderTest.checkDictTypeUnique(dict);

        // Verify the results
        assertThat(result).isFalse();
    }
}
