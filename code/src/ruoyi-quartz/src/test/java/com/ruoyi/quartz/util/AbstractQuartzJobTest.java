package com.ruoyi.quartz.util;

import com.ruoyi.quartz.domain.SysJob;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThatThrownBy;

class AbstractQuartzJobTest {

    private AbstractQuartzJob abstractQuartzJobUnderTest;

    @BeforeEach
    void setUp() {
        abstractQuartzJobUnderTest = new AbstractQuartzJob() {
            @Override
            protected void doExecute(JobExecutionContext context, SysJob sysJob) throws Exception {

            }
        };
    }

    @Test
    void testExecute() {
        // Setup
        final JobExecutionContext context = null;

        // Run the test
        abstractQuartzJobUnderTest.execute(context);

        // Verify the results
    }

    @Test
    void testExecute_ThrowsJobExecutionException() {
        // Setup
        final JobExecutionContext context = null;

        // Run the test
        assertThatThrownBy(() -> abstractQuartzJobUnderTest.execute(context)).isInstanceOf(JobExecutionException.class);
    }

    @Test
    void testBefore() {
        // Setup
        final SysJob sysJob = new SysJob();
        sysJob.setJobId(0L);
        sysJob.setJobName("jobName");
        sysJob.setJobGroup("jobGroup");
        sysJob.setInvokeTarget("invokeTarget");
        sysJob.setCronExpression("cronExpression");

        // Run the test
        abstractQuartzJobUnderTest.before(null, sysJob);

        // Verify the results
    }

    @Test
    void testAfter() {
        // Setup
        final SysJob sysJob = new SysJob();
        sysJob.setJobId(0L);
        sysJob.setJobName("jobName");
        sysJob.setJobGroup("jobGroup");
        sysJob.setInvokeTarget("invokeTarget");
        sysJob.setCronExpression("cronExpression");

        // Run the test
        abstractQuartzJobUnderTest.after(null, sysJob, new Exception("message"));

        // Verify the results
    }
}
