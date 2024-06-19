package com.ruoyi.quartz.controller;

import com.ruoyi.quartz.domain.SysJobLog;
import com.ruoyi.quartz.service.ISysJobLogService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import static org.mockito.MockitoAnnotations.initMocks;

class SysJobLogControllerTest {

    @Mock
    private ISysJobLogService mockJobLogService;

    @InjectMocks
    private SysJobLogController sysJobLogControllerUnderTest;

    @BeforeEach
    void setUp() {
        initMocks(this);
    }

    @Test
    void testList() {
        // Setup
        final SysJobLog sysJobLog = new SysJobLog();
        sysJobLog.setJobLogId(0L);
        sysJobLog.setJobName("jobName");
        sysJobLog.setJobGroup("jobGroup");
        sysJobLog.setInvokeTarget("invokeTarget");
        sysJobLog.setJobMessage("jobMessage");

        // Configure ISysJobLogService.selectJobLogList(...).
        final SysJobLog sysJobLog1 = new SysJobLog();
        sysJobLog1.setJobLogId(0L);
        sysJobLog1.setJobName("jobName");
        sysJobLog1.setJobGroup("jobGroup");
        sysJobLog1.setInvokeTarget("invokeTarget");
        sysJobLog1.setJobMessage("jobMessage");
        final List<SysJobLog> sysJobLogs = Arrays.asList(sysJobLog1);
        when(mockJobLogService.selectJobLogList(any(SysJobLog.class))).thenReturn(sysJobLogs);

        // Run the test
        final TableDataInfo result = sysJobLogControllerUnderTest.list(sysJobLog);

        // Verify the results
    }

    @Test
    void testList_ISysJobLogServiceReturnsNoItems() {
        // Setup
        final SysJobLog sysJobLog = new SysJobLog();
        sysJobLog.setJobLogId(0L);
        sysJobLog.setJobName("jobName");
        sysJobLog.setJobGroup("jobGroup");
        sysJobLog.setInvokeTarget("invokeTarget");
        sysJobLog.setJobMessage("jobMessage");

        when(mockJobLogService.selectJobLogList(any(SysJobLog.class))).thenReturn(Collections.emptyList());

        // Run the test
        final TableDataInfo result = sysJobLogControllerUnderTest.list(sysJobLog);

        // Verify the results
    }

    @Test
    void testExport() {
        // Setup
        final HttpServletResponse response = null;
        final SysJobLog sysJobLog = new SysJobLog();
        sysJobLog.setJobLogId(0L);
        sysJobLog.setJobName("jobName");
        sysJobLog.setJobGroup("jobGroup");
        sysJobLog.setInvokeTarget("invokeTarget");
        sysJobLog.setJobMessage("jobMessage");

        // Configure ISysJobLogService.selectJobLogList(...).
        final SysJobLog sysJobLog1 = new SysJobLog();
        sysJobLog1.setJobLogId(0L);
        sysJobLog1.setJobName("jobName");
        sysJobLog1.setJobGroup("jobGroup");
        sysJobLog1.setInvokeTarget("invokeTarget");
        sysJobLog1.setJobMessage("jobMessage");
        final List<SysJobLog> sysJobLogs = Arrays.asList(sysJobLog1);
        when(mockJobLogService.selectJobLogList(any(SysJobLog.class))).thenReturn(sysJobLogs);

        // Run the test
        sysJobLogControllerUnderTest.export(response, sysJobLog);

        // Verify the results
    }

    @Test
    void testExport_ISysJobLogServiceReturnsNoItems() {
        // Setup
        final HttpServletResponse response = null;
        final SysJobLog sysJobLog = new SysJobLog();
        sysJobLog.setJobLogId(0L);
        sysJobLog.setJobName("jobName");
        sysJobLog.setJobGroup("jobGroup");
        sysJobLog.setInvokeTarget("invokeTarget");
        sysJobLog.setJobMessage("jobMessage");

        when(mockJobLogService.selectJobLogList(any(SysJobLog.class))).thenReturn(Collections.emptyList());

        // Run the test
        sysJobLogControllerUnderTest.export(response, sysJobLog);

        // Verify the results
    }

    @Test
    void testGetInfo() {
        // Setup
        // Configure ISysJobLogService.selectJobLogById(...).
        final SysJobLog sysJobLog = new SysJobLog();
        sysJobLog.setJobLogId(0L);
        sysJobLog.setJobName("jobName");
        sysJobLog.setJobGroup("jobGroup");
        sysJobLog.setInvokeTarget("invokeTarget");
        sysJobLog.setJobMessage("jobMessage");
        when(mockJobLogService.selectJobLogById(0L)).thenReturn(sysJobLog);

        // Run the test
        final AjaxResult result = sysJobLogControllerUnderTest.getInfo(0L);

        // Verify the results
    }

    @Test
    void testRemove() {
        // Setup
        when(mockJobLogService.deleteJobLogByIds(any(Long[].class))).thenReturn(0);

        // Run the test
        final AjaxResult result = sysJobLogControllerUnderTest.remove(new Long[]{0L});

        // Verify the results
    }

    @Test
    void testClean() {
        // Setup
        // Run the test
        final AjaxResult result = sysJobLogControllerUnderTest.clean();

        // Verify the results
        verify(mockJobLogService).cleanJobLog();
    }
}
