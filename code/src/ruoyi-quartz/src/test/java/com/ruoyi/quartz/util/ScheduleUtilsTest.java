package com.ruoyi.quartz.util;

import com.ruoyi.common.exception.job.TaskException;
import com.ruoyi.quartz.domain.SysJob;
import org.junit.jupiter.api.Test;
import org.quartz.*;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

class ScheduleUtilsTest {

    @Test
    void testGetTriggerKey() {
        // Setup
        // Run the test
        final TriggerKey result = ScheduleUtils.getTriggerKey(0L, "jobGroup");

        // Verify the results
    }

    @Test
    void testGetJobKey() {
        // Setup
        // Run the test
        final JobKey result = ScheduleUtils.getJobKey(0L, "jobGroup");

        // Verify the results
    }

    @Test
    void testCreateScheduleJob() throws SchedulerException, TaskException {
        // Setup
        final Scheduler scheduler = null;
        final SysJob job = new SysJob();
        job.setJobId(0L);
        job.setJobGroup("jobGroup");
        job.setCronExpression("cronExpression");
        job.setMisfirePolicy("misfirePolicy");
        job.setConcurrent("concurrent");
        job.setStatus("status");

        // Run the test
        ScheduleUtils.createScheduleJob(scheduler, job);

        // Verify the results
    }

    @Test
    void testCreateScheduleJob_ThrowsSchedulerException() {
        // Setup
        final Scheduler scheduler = null;
        final SysJob job = new SysJob();
        job.setJobId(0L);
        job.setJobGroup("jobGroup");
        job.setCronExpression("cronExpression");
        job.setMisfirePolicy("misfirePolicy");
        job.setConcurrent("concurrent");
        job.setStatus("status");

        // Run the test
        assertThatThrownBy(() -> ScheduleUtils.createScheduleJob(scheduler, job)).isInstanceOf(
                SchedulerException.class);
    }

    @Test
    void testHandleCronScheduleMisfirePolicy() throws TaskException {
        // Setup
        final SysJob job = new SysJob();
        job.setJobId(0L);
        job.setJobGroup("jobGroup");
        job.setCronExpression("cronExpression");
        job.setMisfirePolicy("misfirePolicy");
        job.setConcurrent("concurrent");
        job.setStatus("status");

        final CronScheduleBuilder cb = null;

        // Run the test
        final CronScheduleBuilder result = ScheduleUtils.handleCronScheduleMisfirePolicy(job, cb);

        // Verify the results
    }

    @Test
    void testHandleCronScheduleMisfirePolicy_ThrowsTaskException() {
        // Setup
        final SysJob job = new SysJob();
        job.setJobId(0L);
        job.setJobGroup("jobGroup");
        job.setCronExpression("cronExpression");
        job.setMisfirePolicy("misfirePolicy");
        job.setConcurrent("concurrent");
        job.setStatus("status");

        final CronScheduleBuilder cb = null;

        // Run the test
        assertThatThrownBy(() -> ScheduleUtils.handleCronScheduleMisfirePolicy(job, cb)).isInstanceOf(
                TaskException.class);
    }

    @Test
    void testWhiteList() {
        assertThat(ScheduleUtils.whiteList("invokeTarget")).isFalse();
    }
}
