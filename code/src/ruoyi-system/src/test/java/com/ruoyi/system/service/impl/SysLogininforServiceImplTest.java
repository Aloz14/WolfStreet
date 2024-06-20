package com.ruoyi.system.service.impl;

import com.ruoyi.system.domain.SysLogininfor;
import com.ruoyi.system.mapper.SysLogininforMapper;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import static org.mockito.MockitoAnnotations.initMocks;

class SysLogininforServiceImplTest {

    @Mock
    private SysLogininforMapper mockLogininforMapper;

    @InjectMocks
    private SysLogininforServiceImpl sysLogininforServiceImplUnderTest;

    @BeforeEach
    void setUp() {
        initMocks(this);
    }

    @Test
    void testInsertLogininfor() {
        // Setup
        final SysLogininfor logininfor = new SysLogininfor();
        logininfor.setInfoId(0L);
        logininfor.setUserName("userName");
        logininfor.setStatus("status");
        logininfor.setIpaddr("ipaddr");
        logininfor.setLoginLocation("loginLocation");

        // Run the test
        sysLogininforServiceImplUnderTest.insertLogininfor(logininfor);

        // Verify the results
        verify(mockLogininforMapper).insertLogininfor(any(SysLogininfor.class));
    }

    @Test
    void testSelectLogininforList() {
        // Setup
        final SysLogininfor logininfor = new SysLogininfor();
        logininfor.setInfoId(0L);
        logininfor.setUserName("userName");
        logininfor.setStatus("status");
        logininfor.setIpaddr("ipaddr");
        logininfor.setLoginLocation("loginLocation");

        // Configure SysLogininforMapper.selectLogininforList(...).
        final SysLogininfor sysLogininfor = new SysLogininfor();
        sysLogininfor.setInfoId(0L);
        sysLogininfor.setUserName("userName");
        sysLogininfor.setStatus("status");
        sysLogininfor.setIpaddr("ipaddr");
        sysLogininfor.setLoginLocation("loginLocation");
        final List<SysLogininfor> sysLogininfors = Arrays.asList(sysLogininfor);
        when(mockLogininforMapper.selectLogininforList(any(SysLogininfor.class))).thenReturn(sysLogininfors);

        // Run the test
        final List<SysLogininfor> result = sysLogininforServiceImplUnderTest.selectLogininforList(logininfor);

        // Verify the results
    }

    @Test
    void testSelectLogininforList_SysLogininforMapperReturnsNoItems() {
        // Setup
        final SysLogininfor logininfor = new SysLogininfor();
        logininfor.setInfoId(0L);
        logininfor.setUserName("userName");
        logininfor.setStatus("status");
        logininfor.setIpaddr("ipaddr");
        logininfor.setLoginLocation("loginLocation");

        when(mockLogininforMapper.selectLogininforList(any(SysLogininfor.class))).thenReturn(Collections.emptyList());

        // Run the test
        final List<SysLogininfor> result = sysLogininforServiceImplUnderTest.selectLogininforList(logininfor);

        // Verify the results
        assertThat(result).isEqualTo(Collections.emptyList());
    }

    @Test
    void testDeleteLogininforByIds() {
        // Setup
        when(mockLogininforMapper.deleteLogininforByIds(any(Long[].class))).thenReturn(0);

        // Run the test
        final int result = sysLogininforServiceImplUnderTest.deleteLogininforByIds(new Long[]{0L});

        // Verify the results
        assertThat(result).isEqualTo(0);
    }

    @Test
    void testCleanLogininfor() {
        // Setup
        // Run the test
        sysLogininforServiceImplUnderTest.cleanLogininfor();

        // Verify the results
        verify(mockLogininforMapper).cleanLogininfor();
    }
}
