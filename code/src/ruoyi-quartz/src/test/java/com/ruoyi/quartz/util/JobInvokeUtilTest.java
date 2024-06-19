package com.ruoyi.quartz.util;

import com.ruoyi.quartz.domain.SysJob;
import org.junit.jupiter.api.Test;

import java.util.Arrays;
import java.util.Collections;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

class JobInvokeUtilTest {

    @Test
    void testInvokeMethod1() throws Exception {
        // Setup
        final SysJob sysJob = new SysJob();
        sysJob.setJobId(0L);
        sysJob.setJobName("jobName");
        sysJob.setJobGroup("jobGroup");
        sysJob.setInvokeTarget("invokeTarget");
        sysJob.setCronExpression("cronExpression");

        // Run the test
        JobInvokeUtil.invokeMethod(sysJob);

        // Verify the results
    }

    @Test
    void testInvokeMethod1_ThrowsException() {
        // Setup
        final SysJob sysJob = new SysJob();
        sysJob.setJobId(0L);
        sysJob.setJobName("jobName");
        sysJob.setJobGroup("jobGroup");
        sysJob.setInvokeTarget("invokeTarget");
        sysJob.setCronExpression("cronExpression");

        // Run the test
        assertThatThrownBy(() -> JobInvokeUtil.invokeMethod(sysJob)).isInstanceOf(Exception.class);
    }

    @Test
    void testIsValidClassName() {
        assertThat(JobInvokeUtil.isValidClassName("invokeTarget")).isFalse();
    }

    @Test
    void testGetBeanName() {
        assertThat(JobInvokeUtil.getBeanName("invokeTarget")).isEqualTo("result");
    }

    @Test
    void testGetMethodName() {
        assertThat(JobInvokeUtil.getMethodName("invokeTarget")).isEqualTo("result");
    }

    @Test
    void testGetMethodParams() {
        assertThat(JobInvokeUtil.getMethodParams("invokeTarget")).isEqualTo(Arrays.asList(new Object[]{"value"}));
        assertThat(JobInvokeUtil.getMethodParams("invokeTarget")).isEqualTo(Collections.emptyList());
    }

    @Test
    void testGetMethodParamsType() {
        assertThat(JobInvokeUtil.getMethodParamsType(Arrays.asList(new Object[]{"value"}))).isEqualTo(
                new Class<?>[]{String.class});
        assertThat(JobInvokeUtil.getMethodParamsType(Arrays.asList(new Object[]{"value"}))).isEqualTo(new Class<?>[]{});
    }

    @Test
    void testGetMethodParamsValue() {
        assertThat(JobInvokeUtil.getMethodParamsValue(Arrays.asList(new Object[]{"value"}))).isEqualTo(
                new Object[]{"result"});
        assertThat(JobInvokeUtil.getMethodParamsValue(Arrays.asList(new Object[]{"value"}))).isEqualTo(new Object[]{});
    }
}
