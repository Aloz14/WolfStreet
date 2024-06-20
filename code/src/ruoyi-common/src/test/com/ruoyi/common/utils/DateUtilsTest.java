package com.ruoyi.common.utils;

import org.junit.jupiter.api.Test;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Calendar;
import java.util.GregorianCalendar;

import static org.assertj.core.api.Assertions.assertThat;

class DateUtilsTest {

    @Test
    void testGetNowDate() {
        assertThat(DateUtils.getNowDate()).isEqualTo(new GregorianCalendar(2020, Calendar.JANUARY, 1).getTime());
    }

    @Test
    void testGetDate() {
        assertThat(DateUtils.getDate()).isEqualTo("result");
    }

    @Test
    void testGetTime() {
        assertThat(DateUtils.getTime()).isEqualTo("result");
    }

    @Test
    void testDateTimeNow1() {
        assertThat(DateUtils.dateTimeNow()).isEqualTo("result");
    }

    @Test
    void testDateTimeNow2() {
        assertThat(DateUtils.dateTimeNow("format")).isEqualTo("result");
    }

    @Test
    void testDateTime1() {
        assertThat(DateUtils.dateTime(new GregorianCalendar(2020, Calendar.JANUARY, 1).getTime())).isEqualTo("result");
    }

    @Test
    void testParseDateToStr() {
        assertThat(DateUtils.parseDateToStr("format",
                new GregorianCalendar(2020, Calendar.JANUARY, 1).getTime())).isEqualTo("result");
    }

    @Test
    void testDateTime2() {
        assertThat(DateUtils.dateTime("format", "ts")).isEqualTo(
                new GregorianCalendar(2020, Calendar.JANUARY, 1).getTime());
    }

    @Test
    void testDatePath() {
        assertThat(DateUtils.datePath()).isEqualTo("result");
    }

    @Test
    void testDateTime3() {
        assertThat(DateUtils.dateTime()).isEqualTo("result");
    }

    @Test
    void testParseDate() {
        assertThat(DateUtils.parseDate("str")).isEqualTo(new GregorianCalendar(2020, Calendar.JANUARY, 1).getTime());
    }

    @Test
    void testGetServerStartDate() {
        assertThat(DateUtils.getServerStartDate()).isEqualTo(
                new GregorianCalendar(2020, Calendar.JANUARY, 1).getTime());
    }

    @Test
    void testDifferentDaysByMillisecond() {
        assertThat(DateUtils.differentDaysByMillisecond(new GregorianCalendar(2020, Calendar.JANUARY, 1).getTime(),
                new GregorianCalendar(2020, Calendar.JANUARY, 1).getTime())).isEqualTo(0);
    }

    @Test
    void testTimeDistance() {
        assertThat(DateUtils.timeDistance(new GregorianCalendar(2020, Calendar.JANUARY, 1).getTime(),
                new GregorianCalendar(2020, Calendar.JANUARY, 1).getTime())).isEqualTo("result");
    }

    @Test
    void testToDate1() {
        assertThat(DateUtils.toDate(LocalDateTime.of(2020, 1, 1, 0, 0, 0))).isEqualTo(
                new GregorianCalendar(2020, Calendar.JANUARY, 1).getTime());
    }

    @Test
    void testToDate2() {
        assertThat(DateUtils.toDate(LocalDate.of(2020, 1, 1))).isEqualTo(
                new GregorianCalendar(2020, Calendar.JANUARY, 1).getTime());
    }
}
