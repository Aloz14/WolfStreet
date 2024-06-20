package com.ruoyi.quartz.util;

import com.ruoyi.quartz.domain.SysJob;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThatThrownBy;

class QuartzJobExecutionTest {

    private QuartzJobExecution quartzJobExecutionUnderTest;

    @BeforeEach
    void setUp() {
        quartzJobExecutionUnderTest = new QuartzJobExecution();
    }

    @Test
    void testDoExecute() throws Exception {
        // Setup
        final SysJob sysJob = new SysJob();
        sysJob.setJobId(0L);
        sysJob.setJobName("jobName");
        sysJob.setJobGroup("jobGroup");
        sysJob.setInvokeTarget("invokeTarget");
        sysJob.setCronExpression("cronExpression");

        // Run the test
        quartzJobExecutionUnderTest.doExecute(null, sysJob);

        // Verify the results
    }

    @Test
    void testDoExecute_ThrowsException() {
        // Setup
        final SysJob sysJob = new SysJob();
        sysJob.setJobId(0L);
        sysJob.setJobName("jobName");
        sysJob.setJobGroup("jobGroup");
        sysJob.setInvokeTarget("invokeTarget");
        sysJob.setCronExpression("cronExpression");

        // Run the test
        assertThatThrownBy(() -> quartzJobExecutionUnderTest.doExecute(null, sysJob)).isInstanceOf(Exception.class);
    }
}
