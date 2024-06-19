package com.ruoyi.quartz.service.impl;

import com.ruoyi.quartz.domain.SysJobLog;
import com.ruoyi.quartz.mapper.SysJobLogMapper;
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

class SysJobLogServiceImplTest {

    @Mock
    private SysJobLogMapper mockJobLogMapper;

    @InjectMocks
    private SysJobLogServiceImpl sysJobLogServiceImplUnderTest;

    @BeforeEach
    void setUp() {
        initMocks(this);
    }

    @Test
    void testSelectJobLogList() {
        // Setup
        final SysJobLog jobLog = new SysJobLog();
        jobLog.setJobLogId(0L);
        jobLog.setJobName("jobName");
        jobLog.setJobGroup("jobGroup");
        jobLog.setInvokeTarget("invokeTarget");
        jobLog.setJobMessage("jobMessage");

        // Configure SysJobLogMapper.selectJobLogList(...).
        final SysJobLog sysJobLog = new SysJobLog();
        sysJobLog.setJobLogId(0L);
        sysJobLog.setJobName("jobName");
        sysJobLog.setJobGroup("jobGroup");
        sysJobLog.setInvokeTarget("invokeTarget");
        sysJobLog.setJobMessage("jobMessage");
        final List<SysJobLog> sysJobLogs = Arrays.asList(sysJobLog);
        when(mockJobLogMapper.selectJobLogList(any(SysJobLog.class))).thenReturn(sysJobLogs);

        // Run the test
        final List<SysJobLog> result = sysJobLogServiceImplUnderTest.selectJobLogList(jobLog);

        // Verify the results
    }

    @Test
    void testSelectJobLogList_SysJobLogMapperReturnsNoItems() {
        // Setup
        final SysJobLog jobLog = new SysJobLog();
        jobLog.setJobLogId(0L);
        jobLog.setJobName("jobName");
        jobLog.setJobGroup("jobGroup");
        jobLog.setInvokeTarget("invokeTarget");
        jobLog.setJobMessage("jobMessage");

        when(mockJobLogMapper.selectJobLogList(any(SysJobLog.class))).thenReturn(Collections.emptyList());

        // Run the test
        final List<SysJobLog> result = sysJobLogServiceImplUnderTest.selectJobLogList(jobLog);

        // Verify the results
        assertThat(result).isEqualTo(Collections.emptyList());
    }

    @Test
    void testSelectJobLogById() {
        // Setup
        // Configure SysJobLogMapper.selectJobLogById(...).
        final SysJobLog sysJobLog = new SysJobLog();
        sysJobLog.setJobLogId(0L);
        sysJobLog.setJobName("jobName");
        sysJobLog.setJobGroup("jobGroup");
        sysJobLog.setInvokeTarget("invokeTarget");
        sysJobLog.setJobMessage("jobMessage");
        when(mockJobLogMapper.selectJobLogById(0L)).thenReturn(sysJobLog);

        // Run the test
        final SysJobLog result = sysJobLogServiceImplUnderTest.selectJobLogById(0L);

        // Verify the results
    }

    @Test
    void testAddJobLog() {
        // Setup
        final SysJobLog jobLog = new SysJobLog();
        jobLog.setJobLogId(0L);
        jobLog.setJobName("jobName");
        jobLog.setJobGroup("jobGroup");
        jobLog.setInvokeTarget("invokeTarget");
        jobLog.setJobMessage("jobMessage");

        // Run the test
        sysJobLogServiceImplUnderTest.addJobLog(jobLog);

        // Verify the results
        verify(mockJobLogMapper).insertJobLog(any(SysJobLog.class));
    }

    @Test
    void testDeleteJobLogByIds() {
        // Setup
        when(mockJobLogMapper.deleteJobLogByIds(any(Long[].class))).thenReturn(0);

        // Run the test
        final int result = sysJobLogServiceImplUnderTest.deleteJobLogByIds(new Long[]{0L});

        // Verify the results
        assertThat(result).isEqualTo(0);
    }

    @Test
    void testDeleteJobLogById() {
        // Setup
        when(mockJobLogMapper.deleteJobLogById(0L)).thenReturn(0);

        // Run the test
        final int result = sysJobLogServiceImplUnderTest.deleteJobLogById(0L);

        // Verify the results
        assertThat(result).isEqualTo(0);
    }

    @Test
    void testCleanJobLog() {
        // Setup
        // Run the test
        sysJobLogServiceImplUnderTest.cleanJobLog();

        // Verify the results
        verify(mockJobLogMapper).cleanJobLog();
    }
}
