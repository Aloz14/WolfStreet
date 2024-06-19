package com.ruoyi.fund.service.impl;

import com.ruoyi.fund.domain.FundInfo;
import com.ruoyi.fund.mapper.FundInfoMapper;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.when;
import static org.mockito.MockitoAnnotations.initMocks;

class FundInfoServiceImplTest {

    @Mock
    private FundInfoMapper mockFundInfoMapper;

    @InjectMocks
    private FundInfoServiceImpl fundInfoServiceImplUnderTest;

    @BeforeEach
    void setUp() {
        initMocks(this);
    }

    @Test
    void testSelectFundInfoByFId() {
        // Setup
        // Configure FundInfoMapper.selectFundInfoByFId(...).
        final FundInfo fundInfo = new FundInfo();
        fundInfo.setfId("fId");
        fundInfo.setfName("fName");
        fundInfo.setfType(0L);
        fundInfo.setfSize(0L);
        fundInfo.setfMonitor("fMonitor");
        when(mockFundInfoMapper.selectFundInfoByFId("fId")).thenReturn(fundInfo);

        // Run the test
        final FundInfo result = fundInfoServiceImplUnderTest.selectFundInfoByFId("fId");

        // Verify the results
    }

    @Test
    void testSelectFundInfoList() {
        // Setup
        final FundInfo fundInfo = new FundInfo();
        fundInfo.setfId("fId");
        fundInfo.setfName("fName");
        fundInfo.setfType(0L);
        fundInfo.setfSize(0L);
        fundInfo.setfMonitor("fMonitor");

        // Configure FundInfoMapper.selectFundInfoList(...).
        final FundInfo fundInfo1 = new FundInfo();
        fundInfo1.setfId("fId");
        fundInfo1.setfName("fName");
        fundInfo1.setfType(0L);
        fundInfo1.setfSize(0L);
        fundInfo1.setfMonitor("fMonitor");
        final List<FundInfo> fundInfos = Arrays.asList(fundInfo1);
        when(mockFundInfoMapper.selectFundInfoList(any(FundInfo.class))).thenReturn(fundInfos);

        // Run the test
        final List<FundInfo> result = fundInfoServiceImplUnderTest.selectFundInfoList(fundInfo);

        // Verify the results
    }

    @Test
    void testSelectFundInfoList_FundInfoMapperReturnsNoItems() {
        // Setup
        final FundInfo fundInfo = new FundInfo();
        fundInfo.setfId("fId");
        fundInfo.setfName("fName");
        fundInfo.setfType(0L);
        fundInfo.setfSize(0L);
        fundInfo.setfMonitor("fMonitor");

        when(mockFundInfoMapper.selectFundInfoList(any(FundInfo.class))).thenReturn(Collections.emptyList());

        // Run the test
        final List<FundInfo> result = fundInfoServiceImplUnderTest.selectFundInfoList(fundInfo);

        // Verify the results
        assertThat(result).isEqualTo(Collections.emptyList());
    }

    @Test
    void testInsertFundInfo() {
        // Setup
        final FundInfo fundInfo = new FundInfo();
        fundInfo.setfId("fId");
        fundInfo.setfName("fName");
        fundInfo.setfType(0L);
        fundInfo.setfSize(0L);
        fundInfo.setfMonitor("fMonitor");

        when(mockFundInfoMapper.insertFundInfo(any(FundInfo.class))).thenReturn(0);

        // Run the test
        final int result = fundInfoServiceImplUnderTest.insertFundInfo(fundInfo);

        // Verify the results
        assertThat(result).isEqualTo(0);
    }

    @Test
    void testUpdateFundInfo() {
        // Setup
        final FundInfo fundInfo = new FundInfo();
        fundInfo.setfId("fId");
        fundInfo.setfName("fName");
        fundInfo.setfType(0L);
        fundInfo.setfSize(0L);
        fundInfo.setfMonitor("fMonitor");

        when(mockFundInfoMapper.updateFundInfo(any(FundInfo.class))).thenReturn(0);

        // Run the test
        final int result = fundInfoServiceImplUnderTest.updateFundInfo(fundInfo);

        // Verify the results
        assertThat(result).isEqualTo(0);
    }

    @Test
    void testDeleteFundInfoByFIds() {
        // Setup
        when(mockFundInfoMapper.deleteFundInfoByFIds(any(String[].class))).thenReturn(0);

        // Run the test
        final int result = fundInfoServiceImplUnderTest.deleteFundInfoByFIds(new String[]{"fIds"});

        // Verify the results
        assertThat(result).isEqualTo(0);
    }

    @Test
    void testDeleteFundInfoByFId() {
        // Setup
        when(mockFundInfoMapper.deleteFundInfoByFId("fId")).thenReturn(0);

        // Run the test
        final int result = fundInfoServiceImplUnderTest.deleteFundInfoByFId("fId");

        // Verify the results
        assertThat(result).isEqualTo(0);
    }
}
