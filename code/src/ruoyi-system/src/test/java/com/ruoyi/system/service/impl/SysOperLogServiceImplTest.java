package com.ruoyi.system.service.impl;

import com.ruoyi.system.domain.SysOperLog;
import com.ruoyi.system.mapper.SysOperLogMapper;
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

class SysOperLogServiceImplTest {

    @Mock
    private SysOperLogMapper mockOperLogMapper;

    @InjectMocks
    private SysOperLogServiceImpl sysOperLogServiceImplUnderTest;

    @BeforeEach
    void setUp() {
        initMocks(this);
    }

    @Test
    void testInsertOperlog() {
        // Setup
        final SysOperLog operLog = new SysOperLog();
        operLog.setOperId(0L);
        operLog.setTitle("title");
        operLog.setBusinessType(0);
        operLog.setBusinessTypes(new Integer[]{0});
        operLog.setMethod("method");

        // Run the test
        sysOperLogServiceImplUnderTest.insertOperlog(operLog);

        // Verify the results
        verify(mockOperLogMapper).insertOperlog(any(SysOperLog.class));
    }

    @Test
    void testSelectOperLogList() {
        // Setup
        final SysOperLog operLog = new SysOperLog();
        operLog.setOperId(0L);
        operLog.setTitle("title");
        operLog.setBusinessType(0);
        operLog.setBusinessTypes(new Integer[]{0});
        operLog.setMethod("method");

        // Configure SysOperLogMapper.selectOperLogList(...).
        final SysOperLog sysOperLog = new SysOperLog();
        sysOperLog.setOperId(0L);
        sysOperLog.setTitle("title");
        sysOperLog.setBusinessType(0);
        sysOperLog.setBusinessTypes(new Integer[]{0});
        sysOperLog.setMethod("method");
        final List<SysOperLog> sysOperLogs = Arrays.asList(sysOperLog);
        when(mockOperLogMapper.selectOperLogList(any(SysOperLog.class))).thenReturn(sysOperLogs);

        // Run the test
        final List<SysOperLog> result = sysOperLogServiceImplUnderTest.selectOperLogList(operLog);

        // Verify the results
    }

    @Test
    void testSelectOperLogList_SysOperLogMapperReturnsNoItems() {
        // Setup
        final SysOperLog operLog = new SysOperLog();
        operLog.setOperId(0L);
        operLog.setTitle("title");
        operLog.setBusinessType(0);
        operLog.setBusinessTypes(new Integer[]{0});
        operLog.setMethod("method");

        when(mockOperLogMapper.selectOperLogList(any(SysOperLog.class))).thenReturn(Collections.emptyList());

        // Run the test
        final List<SysOperLog> result = sysOperLogServiceImplUnderTest.selectOperLogList(operLog);

        // Verify the results
        assertThat(result).isEqualTo(Collections.emptyList());
    }

    @Test
    void testDeleteOperLogByIds() {
        // Setup
        when(mockOperLogMapper.deleteOperLogByIds(any(Long[].class))).thenReturn(0);

        // Run the test
        final int result = sysOperLogServiceImplUnderTest.deleteOperLogByIds(new Long[]{0L});

        // Verify the results
        assertThat(result).isEqualTo(0);
    }

    @Test
    void testSelectOperLogById() {
        // Setup
        // Configure SysOperLogMapper.selectOperLogById(...).
        final SysOperLog sysOperLog = new SysOperLog();
        sysOperLog.setOperId(0L);
        sysOperLog.setTitle("title");
        sysOperLog.setBusinessType(0);
        sysOperLog.setBusinessTypes(new Integer[]{0});
        sysOperLog.setMethod("method");
        when(mockOperLogMapper.selectOperLogById(0L)).thenReturn(sysOperLog);

        // Run the test
        final SysOperLog result = sysOperLogServiceImplUnderTest.selectOperLogById(0L);

        // Verify the results
    }

    @Test
    void testCleanOperLog() {
        // Setup
        // Run the test
        sysOperLogServiceImplUnderTest.cleanOperLog();

        // Verify the results
        verify(mockOperLogMapper).cleanOperLog();
    }
}
