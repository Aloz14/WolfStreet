package com.ruoyi.quartz.service.impl;

import com.ruoyi.common.exception.job.TaskException;
import com.ruoyi.quartz.domain.SysJob;
import com.ruoyi.quartz.mapper.SysJobMapper;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.when;
import static org.mockito.MockitoAnnotations.initMocks;

class SysJobServiceImplTest {

    @Mock
    private Scheduler mockScheduler;
    @Mock
    private SysJobMapper mockJobMapper;

    @InjectMocks
    private SysJobServiceImpl sysJobServiceImplUnderTest;

    @BeforeEach
    void setUp() {
        initMocks(this);
    }

    @Test
    void testInit() throws SchedulerException, TaskException {
        // Setup
        // Configure SysJobMapper.selectJobAll(...).
        final SysJob sysJob = new SysJob();
        sysJob.setJobId(0L);
        sysJob.setJobGroup("jobGroup");
        sysJob.setCronExpression("cronExpression");
        sysJob.setMisfirePolicy("misfirePolicy");
        sysJob.setConcurrent("concurrent");
        sysJob.setStatus("status");
        final List<SysJob> sysJobs = Arrays.asList(sysJob);
        when(mockJobMapper.selectJobAll()).thenReturn(sysJobs);

        // Run the test
        sysJobServiceImplUnderTest.init();

        // Verify the results
    }

    @Test
    void testInit_SysJobMapperReturnsNoItems() throws SchedulerException, TaskException {
        // Setup
        when(mockJobMapper.selectJobAll()).thenReturn(Collections.emptyList());

        // Run the test
        sysJobServiceImplUnderTest.init();

        // Verify the results
    }

    @Test
    void testSelectJobList() {
        // Setup
        final SysJob job = new SysJob();
        job.setJobId(0L);
        job.setJobGroup("jobGroup");
        job.setCronExpression("cronExpression");
        job.setMisfirePolicy("misfirePolicy");
        job.setConcurrent("concurrent");
        job.setStatus("status");

        // Configure SysJobMapper.selectJobList(...).
        final SysJob sysJob = new SysJob();
        sysJob.setJobId(0L);
        sysJob.setJobGroup("jobGroup");
        sysJob.setCronExpression("cronExpression");
        sysJob.setMisfirePolicy("misfirePolicy");
        sysJob.setConcurrent("concurrent");
        sysJob.setStatus("status");
        final List<SysJob> sysJobs = Arrays.asList(sysJob);
        when(mockJobMapper.selectJobList(any(SysJob.class))).thenReturn(sysJobs);

        // Run the test
        final List<SysJob> result = sysJobServiceImplUnderTest.selectJobList(job);

        // Verify the results
    }

    @Test
    void testSelectJobList_SysJobMapperReturnsNoItems() {
        // Setup
        final SysJob job = new SysJob();
        job.setJobId(0L);
        job.setJobGroup("jobGroup");
        job.setCronExpression("cronExpression");
        job.setMisfirePolicy("misfirePolicy");
        job.setConcurrent("concurrent");
        job.setStatus("status");

        when(mockJobMapper.selectJobList(any(SysJob.class))).thenReturn(Collections.emptyList());

        // Run the test
        final List<SysJob> result = sysJobServiceImplUnderTest.selectJobList(job);

        // Verify the results
        assertThat(result).isEqualTo(Collections.emptyList());
    }

    @Test
    void testSelectJobById() {
        // Setup
        // Configure SysJobMapper.selectJobById(...).
        final SysJob sysJob = new SysJob();
        sysJob.setJobId(0L);
        sysJob.setJobGroup("jobGroup");
        sysJob.setCronExpression("cronExpression");
        sysJob.setMisfirePolicy("misfirePolicy");
        sysJob.setConcurrent("concurrent");
        sysJob.setStatus("status");
        when(mockJobMapper.selectJobById(0L)).thenReturn(sysJob);

        // Run the test
        final SysJob result = sysJobServiceImplUnderTest.selectJobById(0L);

        // Verify the results
    }

    @Test
    void testPauseJob() throws SchedulerException {
        // Setup
        final SysJob job = new SysJob();
        job.setJobId(0L);
        job.setJobGroup("jobGroup");
        job.setCronExpression("cronExpression");
        job.setMisfirePolicy("misfirePolicy");
        job.setConcurrent("concurrent");
        job.setStatus("status");

        when(mockJobMapper.updateJob(any(SysJob.class))).thenReturn(0);

        // Run the test
        final int result = sysJobServiceImplUnderTest.pauseJob(job);

        // Verify the results
        assertThat(result).isEqualTo(0);
    }

    @Test
    void testResumeJob() throws SchedulerException {
        // Setup
        final SysJob job = new SysJob();
        job.setJobId(0L);
        job.setJobGroup("jobGroup");
        job.setCronExpression("cronExpression");
        job.setMisfirePolicy("misfirePolicy");
        job.setConcurrent("concurrent");
        job.setStatus("status");

        when(mockJobMapper.updateJob(any(SysJob.class))).thenReturn(0);

        // Run the test
        final int result = sysJobServiceImplUnderTest.resumeJob(job);

        // Verify the results
        assertThat(result).isEqualTo(0);
    }

    @Test
    void testDeleteJob() throws SchedulerException {
        // Setup
        final SysJob job = new SysJob();
        job.setJobId(0L);
        job.setJobGroup("jobGroup");
        job.setCronExpression("cronExpression");
        job.setMisfirePolicy("misfirePolicy");
        job.setConcurrent("concurrent");
        job.setStatus("status");

        when(mockJobMapper.deleteJobById(0L)).thenReturn(0);

        // Run the test
        final int result = sysJobServiceImplUnderTest.deleteJob(job);

        // Verify the results
        assertThat(result).isEqualTo(0);
    }

    @Test
    void testDeleteJobByIds() throws SchedulerException {
        // Setup
        // Configure SysJobMapper.selectJobById(...).
        final SysJob sysJob = new SysJob();
        sysJob.setJobId(0L);
        sysJob.setJobGroup("jobGroup");
        sysJob.setCronExpression("cronExpression");
        sysJob.setMisfirePolicy("misfirePolicy");
        sysJob.setConcurrent("concurrent");
        sysJob.setStatus("status");
        when(mockJobMapper.selectJobById(0L)).thenReturn(sysJob);

        when(mockJobMapper.deleteJobById(0L)).thenReturn(0);

        // Run the test
        sysJobServiceImplUnderTest.deleteJobByIds(new Long[]{0L});

        // Verify the results
    }

    @Test
    void testChangeStatus() throws SchedulerException {
        // Setup
        final SysJob job = new SysJob();
        job.setJobId(0L);
        job.setJobGroup("jobGroup");
        job.setCronExpression("cronExpression");
        job.setMisfirePolicy("misfirePolicy");
        job.setConcurrent("concurrent");
        job.setStatus("status");

        when(mockJobMapper.updateJob(any(SysJob.class))).thenReturn(0);

        // Run the test
        final int result = sysJobServiceImplUnderTest.changeStatus(job);

        // Verify the results
        assertThat(result).isEqualTo(0);
    }

    @Test
    void testRun() throws SchedulerException {
        // Setup
        final SysJob job = new SysJob();
        job.setJobId(0L);
        job.setJobGroup("jobGroup");
        job.setCronExpression("cronExpression");
        job.setMisfirePolicy("misfirePolicy");
        job.setConcurrent("concurrent");
        job.setStatus("status");

        // Configure SysJobMapper.selectJobById(...).
        final SysJob sysJob = new SysJob();
        sysJob.setJobId(0L);
        sysJob.setJobGroup("jobGroup");
        sysJob.setCronExpression("cronExpression");
        sysJob.setMisfirePolicy("misfirePolicy");
        sysJob.setConcurrent("concurrent");
        sysJob.setStatus("status");
        when(mockJobMapper.selectJobById(0L)).thenReturn(sysJob);

        // Run the test
        final boolean result = sysJobServiceImplUnderTest.run(job);

        // Verify the results
        assertThat(result).isFalse();
    }

    @Test
    void testInsertJob() throws SchedulerException, TaskException {
        // Setup
        final SysJob job = new SysJob();
        job.setJobId(0L);
        job.setJobGroup("jobGroup");
        job.setCronExpression("cronExpression");
        job.setMisfirePolicy("misfirePolicy");
        job.setConcurrent("concurrent");
        job.setStatus("status");

        when(mockJobMapper.insertJob(any(SysJob.class))).thenReturn(0);

        // Run the test
        final int result = sysJobServiceImplUnderTest.insertJob(job);

        // Verify the results
        assertThat(result).isEqualTo(0);
    }

    @Test
    void testUpdateJob() throws SchedulerException, TaskException {
        // Setup
        final SysJob job = new SysJob();
        job.setJobId(0L);
        job.setJobGroup("jobGroup");
        job.setCronExpression("cronExpression");
        job.setMisfirePolicy("misfirePolicy");
        job.setConcurrent("concurrent");
        job.setStatus("status");

        // Configure SysJobMapper.selectJobById(...).
        final SysJob sysJob = new SysJob();
        sysJob.setJobId(0L);
        sysJob.setJobGroup("jobGroup");
        sysJob.setCronExpression("cronExpression");
        sysJob.setMisfirePolicy("misfirePolicy");
        sysJob.setConcurrent("concurrent");
        sysJob.setStatus("status");
        when(mockJobMapper.selectJobById(0L)).thenReturn(sysJob);

        when(mockJobMapper.updateJob(any(SysJob.class))).thenReturn(0);

        // Run the test
        final int result = sysJobServiceImplUnderTest.updateJob(job);

        // Verify the results
        assertThat(result).isEqualTo(0);
    }

    @Test
    void testUpdateSchedulerJob() throws SchedulerException, TaskException {
        // Setup
        final SysJob job = new SysJob();
        job.setJobId(0L);
        job.setJobGroup("jobGroup");
        job.setCronExpression("cronExpression");
        job.setMisfirePolicy("misfirePolicy");
        job.setConcurrent("concurrent");
        job.setStatus("status");

        // Run the test
        sysJobServiceImplUnderTest.updateSchedulerJob(job, "jobGroup");

        // Verify the results
    }

    @Test
    void testUpdateSchedulerJob_ThrowsSchedulerException() {
        // Setup
        final SysJob job = new SysJob();
        job.setJobId(0L);
        job.setJobGroup("jobGroup");
        job.setCronExpression("cronExpression");
        job.setMisfirePolicy("misfirePolicy");
        job.setConcurrent("concurrent");
        job.setStatus("status");

        // Run the test
        assertThatThrownBy(() -> sysJobServiceImplUnderTest.updateSchedulerJob(job, "jobGroup")).isInstanceOf(
                SchedulerException.class);
    }

    @Test
    void testCheckCronExpressionIsValid() {
        assertThat(sysJobServiceImplUnderTest.checkCronExpressionIsValid("cronExpression")).isFalse();
    }
}
