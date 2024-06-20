package com.ruoyi.fund.domain;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

import static org.assertj.core.api.Assertions.assertThat;

class FundInfoTest {

    private FundInfo fundInfoUnderTest;

    @BeforeEach
    void setUp() {
        fundInfoUnderTest = new FundInfo();
    }

    @Test
    void testFIdGetterAndSetter() {
        final String fId = "fId";
        fundInfoUnderTest.setfId(fId);
        assertThat(fundInfoUnderTest.getfId()).isEqualTo(fId);
    }

    @Test
    void testFNameGetterAndSetter() {
        final String fName = "fName";
        fundInfoUnderTest.setfName(fName);
        assertThat(fundInfoUnderTest.getfName()).isEqualTo(fName);
    }

    @Test
    void testFTypeGetterAndSetter() {
        final Long fType = 0L;
        fundInfoUnderTest.setfType(fType);
        assertThat(fundInfoUnderTest.getfType()).isEqualTo(fType);
    }

    @Test
    void testFSizeGetterAndSetter() {
        final Long fSize = 0L;
        fundInfoUnderTest.setfSize(fSize);
        assertThat(fundInfoUnderTest.getfSize()).isEqualTo(fSize);
    }

    @Test
    void testFMonitorGetterAndSetter() {
        final String fMonitor = "fMonitor";
        fundInfoUnderTest.setfMonitor(fMonitor);
        assertThat(fundInfoUnderTest.getfMonitor()).isEqualTo(fMonitor);
    }

    @Test
    void testFStartTimeGetterAndSetter() {
        final Date fStartTime = new GregorianCalendar(2020, Calendar.JANUARY, 1).getTime();
        fundInfoUnderTest.setfStartTime(fStartTime);
        assertThat(fundInfoUnderTest.getfStartTime()).isEqualTo(fStartTime);
    }

    @Test
    void testFCompanyGetterAndSetter() {
        final String fCompany = "fCompany";
        fundInfoUnderTest.setfCompany(fCompany);
        assertThat(fundInfoUnderTest.getfCompany()).isEqualTo(fCompany);
    }

    @Test
    void testFLevelGetterAndSetter() {
        final Long fLevel = 0L;
        fundInfoUnderTest.setfLevel(fLevel);
        assertThat(fundInfoUnderTest.getfLevel()).isEqualTo(fLevel);
    }

    @Test
    void testFRiskLevelGetterAndSetter() {
        final Long fRiskLevel = 0L;
        fundInfoUnderTest.setfRiskLevel(fRiskLevel);
        assertThat(fundInfoUnderTest.getfRiskLevel()).isEqualTo(fRiskLevel);
    }

    @Test
    void testFOverviewGetterAndSetter() {
        final String fOverview = "fOverview";
        fundInfoUnderTest.setfOverview(fOverview);
        assertThat(fundInfoUnderTest.getfOverview()).isEqualTo(fOverview);
    }

    @Test
    void testFStatusGetterAndSetter() {
        final Long fStatus = 0L;
        fundInfoUnderTest.setfStatus(fStatus);
        assertThat(fundInfoUnderTest.getfStatus()).isEqualTo(fStatus);
    }

    @Test
    void testToString() {
        assertThat(fundInfoUnderTest.toString()).isEqualTo("result");
    }
}
