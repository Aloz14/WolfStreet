package com.ruoyi.system.service.impl;

import com.ruoyi.common.core.domain.entity.SysDictData;
import com.ruoyi.system.mapper.SysDictDataMapper;
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

class SysDictDataServiceImplTest {

    @Mock
    private SysDictDataMapper mockDictDataMapper;

    @InjectMocks
    private SysDictDataServiceImpl sysDictDataServiceImplUnderTest;

    @BeforeEach
    void setUp() {
        initMocks(this);
    }

    @Test
    void testSelectDictDataList() {
        // Setup
        final SysDictData dictData = null;
        when(mockDictDataMapper.selectDictDataList(any(SysDictData.class))).thenReturn(Arrays.asList());

        // Run the test
        final List<SysDictData> result = sysDictDataServiceImplUnderTest.selectDictDataList(dictData);

        // Verify the results
    }

    @Test
    void testSelectDictDataList_SysDictDataMapperReturnsNoItems() {
        // Setup
        final SysDictData dictData = null;
        when(mockDictDataMapper.selectDictDataList(any(SysDictData.class))).thenReturn(Collections.emptyList());

        // Run the test
        final List<SysDictData> result = sysDictDataServiceImplUnderTest.selectDictDataList(dictData);

        // Verify the results
        assertThat(result).isEqualTo(Collections.emptyList());
    }

    @Test
    void testSelectDictLabel() {
        // Setup
        when(mockDictDataMapper.selectDictLabel("dictType", "dictValue")).thenReturn("result");

        // Run the test
        final String result = sysDictDataServiceImplUnderTest.selectDictLabel("dictType", "dictValue");

        // Verify the results
        assertThat(result).isEqualTo("result");
    }

    @Test
    void testSelectDictDataById() {
        // Setup
        when(mockDictDataMapper.selectDictDataById(0L)).thenReturn(null);

        // Run the test
        final SysDictData result = sysDictDataServiceImplUnderTest.selectDictDataById(0L);

        // Verify the results
    }

    @Test
    void testDeleteDictDataByIds() {
        // Setup
        when(mockDictDataMapper.selectDictDataById(0L)).thenReturn(null);
        when(mockDictDataMapper.selectDictDataByType("dictType")).thenReturn(Arrays.asList());

        // Run the test
        sysDictDataServiceImplUnderTest.deleteDictDataByIds(new Long[]{0L});

        // Verify the results
        verify(mockDictDataMapper).deleteDictDataById(0L);
    }

    @Test
    void testDeleteDictDataByIds_SysDictDataMapperSelectDictDataByTypeReturnsNoItems() {
        // Setup
        when(mockDictDataMapper.selectDictDataById(0L)).thenReturn(null);
        when(mockDictDataMapper.selectDictDataByType("dictType")).thenReturn(Collections.emptyList());

        // Run the test
        sysDictDataServiceImplUnderTest.deleteDictDataByIds(new Long[]{0L});

        // Verify the results
        verify(mockDictDataMapper).deleteDictDataById(0L);
    }

    @Test
    void testInsertDictData() {
        // Setup
        final SysDictData data = null;
        when(mockDictDataMapper.insertDictData(any(SysDictData.class))).thenReturn(0);
        when(mockDictDataMapper.selectDictDataByType("dictType")).thenReturn(Arrays.asList());

        // Run the test
        final int result = sysDictDataServiceImplUnderTest.insertDictData(data);

        // Verify the results
        assertThat(result).isEqualTo(0);
    }

    @Test
    void testInsertDictData_SysDictDataMapperSelectDictDataByTypeReturnsNoItems() {
        // Setup
        final SysDictData data = null;
        when(mockDictDataMapper.insertDictData(any(SysDictData.class))).thenReturn(0);
        when(mockDictDataMapper.selectDictDataByType("dictType")).thenReturn(Collections.emptyList());

        // Run the test
        final int result = sysDictDataServiceImplUnderTest.insertDictData(data);

        // Verify the results
        assertThat(result).isEqualTo(0);
    }

    @Test
    void testUpdateDictData() {
        // Setup
        final SysDictData data = null;
        when(mockDictDataMapper.updateDictData(any(SysDictData.class))).thenReturn(0);
        when(mockDictDataMapper.selectDictDataByType("dictType")).thenReturn(Arrays.asList());

        // Run the test
        final int result = sysDictDataServiceImplUnderTest.updateDictData(data);

        // Verify the results
        assertThat(result).isEqualTo(0);
    }

    @Test
    void testUpdateDictData_SysDictDataMapperSelectDictDataByTypeReturnsNoItems() {
        // Setup
        final SysDictData data = null;
        when(mockDictDataMapper.updateDictData(any(SysDictData.class))).thenReturn(0);
        when(mockDictDataMapper.selectDictDataByType("dictType")).thenReturn(Collections.emptyList());

        // Run the test
        final int result = sysDictDataServiceImplUnderTest.updateDictData(data);

        // Verify the results
        assertThat(result).isEqualTo(0);
    }
}
