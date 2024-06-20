package com.ruoyi.quartz.controller;

import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.exception.job.TaskException;
import com.ruoyi.quartz.domain.SysJob;
import com.ruoyi.quartz.service.ISysJobService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.quartz.SchedulerException;

import javax.servlet.http.HttpServletResponse;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;
import static org.mockito.MockitoAnnotations.initMocks;

class SysJobControllerTest {

    @Mock
    private ISysJobService mockJobService;

    @InjectMocks
    private SysJobController sysJobControllerUnderTest;

    @BeforeEach
    void setUp() {
        initMocks(this);
    }

    @Test
    void testList() {
        // Setup
        final SysJob sysJob = new SysJob();
        sysJob.setJobId(0L);
        sysJob.setJobName("jobName");
        sysJob.setInvokeTarget("invokeTarget");
        sysJob.setCronExpression("cronExpression");
        sysJob.setStatus("status");

        // Configure ISysJobService.selectJobList(...).
        final SysJob sysJob1 = new SysJob();
        sysJob1.setJobId(0L);
        sysJob1.setJobName("jobName");
        sysJob1.setInvokeTarget("invokeTarget");
        sysJob1.setCronExpression("cronExpression");
        sysJob1.setStatus("status");
        final List<SysJob> sysJobs = Arrays.asList(sysJob1);
        when(mockJobService.selectJobList(any(SysJob.class))).thenReturn(sysJobs);

        // Run the test
        final TableDataInfo result = sysJobControllerUnderTest.list(sysJob);

        // Verify the results
    }

    @Test
    void testList_ISysJobServiceReturnsNoItems() {
        // Setup
        final SysJob sysJob = new SysJob();
        sysJob.setJobId(0L);
        sysJob.setJobName("jobName");
        sysJob.setInvokeTarget("invokeTarget");
        sysJob.setCronExpression("cronExpression");
        sysJob.setStatus("status");

        when(mockJobService.selectJobList(any(SysJob.class))).thenReturn(Collections.emptyList());

        // Run the test
        final TableDataInfo result = sysJobControllerUnderTest.list(sysJob);

        // Verify the results
    }

    @Test
    void testExport() {
        // Setup
        final HttpServletResponse response = null;
        final SysJob sysJob = new SysJob();
        sysJob.setJobId(0L);
        sysJob.setJobName("jobName");
        sysJob.setInvokeTarget("invokeTarget");
        sysJob.setCronExpression("cronExpression");
        sysJob.setStatus("status");

        // Configure ISysJobService.selectJobList(...).
        final SysJob sysJob1 = new SysJob();
        sysJob1.setJobId(0L);
        sysJob1.setJobName("jobName");
        sysJob1.setInvokeTarget("invokeTarget");
        sysJob1.setCronExpression("cronExpression");
        sysJob1.setStatus("status");
        final List<SysJob> sysJobs = Arrays.asList(sysJob1);
        when(mockJobService.selectJobList(any(SysJob.class))).thenReturn(sysJobs);

        // Run the test
        sysJobControllerUnderTest.export(response, sysJob);

        // Verify the results
    }

    @Test
    void testExport_ISysJobServiceReturnsNoItems() {
        // Setup
        final HttpServletResponse response = null;
        final SysJob sysJob = new SysJob();
        sysJob.setJobId(0L);
        sysJob.setJobName("jobName");
        sysJob.setInvokeTarget("invokeTarget");
        sysJob.setCronExpression("cronExpression");
        sysJob.setStatus("status");

        when(mockJobService.selectJobList(any(SysJob.class))).thenReturn(Collections.emptyList());

        // Run the test
        sysJobControllerUnderTest.export(response, sysJob);

        // Verify the results
    }

    @Test
    void testGetInfo() {
        // Setup
        // Configure ISysJobService.selectJobById(...).
        final SysJob sysJob = new SysJob();
        sysJob.setJobId(0L);
        sysJob.setJobName("jobName");
        sysJob.setInvokeTarget("invokeTarget");
        sysJob.setCronExpression("cronExpression");
        sysJob.setStatus("status");
        when(mockJobService.selectJobById(0L)).thenReturn(sysJob);

        // Run the test
        final AjaxResult result = sysJobControllerUnderTest.getInfo(0L);

        // Verify the results
    }

    @Test
    void testAdd() throws SchedulerException, TaskException {
        // Setup
        final SysJob job = new SysJob();
        job.setJobId(0L);
        job.setJobName("jobName");
        job.setInvokeTarget("invokeTarget");
        job.setCronExpression("cronExpression");
        job.setStatus("status");

        when(mockJobService.insertJob(any(SysJob.class))).thenReturn(0);

        // Run the test
        final AjaxResult result = sysJobControllerUnderTest.add(job);

        // Verify the results
    }

    @Test
    void testAdd_ISysJobServiceThrowsSchedulerException() throws SchedulerException, TaskException {
        // Setup
        final SysJob job = new SysJob();
        job.setJobId(0L);
        job.setJobName("jobName");
        job.setInvokeTarget("invokeTarget");
        job.setCronExpression("cronExpression");
        job.setStatus("status");

        when(mockJobService.insertJob(any(SysJob.class))).thenThrow(SchedulerException.class);

        // Run the test
        final AjaxResult result = sysJobControllerUnderTest.add(job);

        // Verify the results
    }

    @Test
    void testEdit() throws SchedulerException, TaskException {
        // Setup
        final SysJob job = new SysJob();
        job.setJobId(0L);
        job.setJobName("jobName");
        job.setInvokeTarget("invokeTarget");
        job.setCronExpression("cronExpression");
        job.setStatus("status");

        when(mockJobService.updateJob(any(SysJob.class))).thenReturn(0);

        // Run the test
        final AjaxResult result = sysJobControllerUnderTest.edit(job);

        // Verify the results
    }

    @Test
    void testEdit_ISysJobServiceThrowsSchedulerException() throws SchedulerException, TaskException {
        // Setup
        final SysJob job = new SysJob();
        job.setJobId(0L);
        job.setJobName("jobName");
        job.setInvokeTarget("invokeTarget");
        job.setCronExpression("cronExpression");
        job.setStatus("status");

        when(mockJobService.updateJob(any(SysJob.class))).thenThrow(SchedulerException.class);

        // Run the test
        final AjaxResult result = sysJobControllerUnderTest.edit(job);

        // Verify the results
    }

    @Test
    void testChangeStatus() throws SchedulerException {
        // Setup
        final SysJob job = new SysJob();
        job.setJobId(0L);
        job.setJobName("jobName");
        job.setInvokeTarget("invokeTarget");
        job.setCronExpression("cronExpression");
        job.setStatus("status");

        // Configure ISysJobService.selectJobById(...).
        final SysJob sysJob = new SysJob();
        sysJob.setJobId(0L);
        sysJob.setJobName("jobName");
        sysJob.setInvokeTarget("invokeTarget");
        sysJob.setCronExpression("cronExpression");
        sysJob.setStatus("status");
        when(mockJobService.selectJobById(0L)).thenReturn(sysJob);

        when(mockJobService.changeStatus(any(SysJob.class))).thenReturn(0);

        // Run the test
        final AjaxResult result = sysJobControllerUnderTest.changeStatus(job);

        // Verify the results
    }

    @Test
    void testChangeStatus_ISysJobServiceChangeStatusThrowsSchedulerException() throws SchedulerException {
        // Setup
        final SysJob job = new SysJob();
        job.setJobId(0L);
        job.setJobName("jobName");
        job.setInvokeTarget("invokeTarget");
        job.setCronExpression("cronExpression");
        job.setStatus("status");

        // Configure ISysJobService.selectJobById(...).
        final SysJob sysJob = new SysJob();
        sysJob.setJobId(0L);
        sysJob.setJobName("jobName");
        sysJob.setInvokeTarget("invokeTarget");
        sysJob.setCronExpression("cronExpression");
        sysJob.setStatus("status");
        when(mockJobService.selectJobById(0L)).thenReturn(sysJob);

        when(mockJobService.changeStatus(any(SysJob.class))).thenThrow(SchedulerException.class);

        // Run the test
        final AjaxResult result = sysJobControllerUnderTest.changeStatus(job);

        // Verify the results
    }

    @Test
    void testRun() throws SchedulerException {
        // Setup
        final SysJob job = new SysJob();
        job.setJobId(0L);
        job.setJobName("jobName");
        job.setInvokeTarget("invokeTarget");
        job.setCronExpression("cronExpression");
        job.setStatus("status");

        when(mockJobService.run(any(SysJob.class))).thenReturn(false);

        // Run the test
        final AjaxResult result = sysJobControllerUnderTest.run(job);

        // Verify the results
    }

    @Test
    void testRun_ISysJobServiceThrowsSchedulerException() throws SchedulerException {
        // Setup
        final SysJob job = new SysJob();
        job.setJobId(0L);
        job.setJobName("jobName");
        job.setInvokeTarget("invokeTarget");
        job.setCronExpression("cronExpression");
        job.setStatus("status");

        when(mockJobService.run(any(SysJob.class))).thenThrow(SchedulerException.class);

        // Run the test
        final AjaxResult result = sysJobControllerUnderTest.run(job);

        // Verify the results
    }

    @Test
    void testRemove() throws SchedulerException, TaskException {
        // Setup
        // Run the test
        final AjaxResult result = sysJobControllerUnderTest.remove(new Long[]{0L});

        // Verify the results
        verify(mockJobService).deleteJobByIds(any(Long[].class));
    }

    @Test
    void testRemove_ISysJobServiceThrowsSchedulerException() throws SchedulerException, TaskException {
        // Setup
        doThrow(SchedulerException.class).when(mockJobService).deleteJobByIds(any(Long[].class));

        // Run the test
        final AjaxResult result = sysJobControllerUnderTest.remove(new Long[]{0L});

        // Verify the results
    }
}
