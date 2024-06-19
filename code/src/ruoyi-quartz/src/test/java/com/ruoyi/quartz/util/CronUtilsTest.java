package com.ruoyi.quartz.util;

import org.junit.jupiter.api.Test;

import java.util.Calendar;
import java.util.GregorianCalendar;

import static org.assertj.core.api.Assertions.assertThat;

class CronUtilsTest {

    @Test
    void testIsValid() {
        assertThat(CronUtils.isValid("cronExpression")).isFalse();
    }

    @Test
    void testGetInvalidMessage() {
        assertThat(CronUtils.getInvalidMessage("cronExpression")).isEqualTo("message");
    }

    @Test
    void testGetNextExecution() {
        assertThat(CronUtils.getNextExecution("cronExpression")).isEqualTo(
                new GregorianCalendar(2020, Calendar.JANUARY, 1).getTime());
    }
}
