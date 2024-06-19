package com.ruoyi.trans.service.impl;

import com.ruoyi.trans.domain.TransactionInfo;
import com.ruoyi.trans.mapper.TransactionInfoMapper;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;

import java.util.*;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.when;
import static org.mockito.MockitoAnnotations.initMocks;

class TransactionInfoServiceImplTest {

    @Mock
    private TransactionInfoMapper mockTransactionInfoMapper;

    @InjectMocks
    private TransactionInfoServiceImpl transactionInfoServiceImplUnderTest;

    @BeforeEach
    void setUp() {
        initMocks(this);
    }

    @Test
    void testSelectTransactionInfoByFStreamId() {
        // Setup
        // Configure TransactionInfoMapper.selectTransactionInfoByFStreamId(...).
        final TransactionInfo transactionInfo = new TransactionInfo();
        transactionInfo.setfStreamId(0L);
        transactionInfo.setUserId(0L);
        transactionInfo.setCardId("cardId");
        transactionInfo.setfId("fId");
        transactionInfo.setfDealTime(new GregorianCalendar(2020, Calendar.JANUARY, 1).getTime());
        when(mockTransactionInfoMapper.selectTransactionInfoByFStreamId(0L)).thenReturn(transactionInfo);

        // Run the test
        final TransactionInfo result = transactionInfoServiceImplUnderTest.selectTransactionInfoByFStreamId(0L);

        // Verify the results
    }

    @Test
    void testSelectTransactionInfoList() {
        // Setup
        final TransactionInfo transactionInfo = new TransactionInfo();
        transactionInfo.setfStreamId(0L);
        transactionInfo.setUserId(0L);
        transactionInfo.setCardId("cardId");
        transactionInfo.setfId("fId");
        transactionInfo.setfDealTime(new GregorianCalendar(2020, Calendar.JANUARY, 1).getTime());

        // Configure TransactionInfoMapper.selectTransactionInfoList(...).
        final TransactionInfo transactionInfo1 = new TransactionInfo();
        transactionInfo1.setfStreamId(0L);
        transactionInfo1.setUserId(0L);
        transactionInfo1.setCardId("cardId");
        transactionInfo1.setfId("fId");
        transactionInfo1.setfDealTime(new GregorianCalendar(2020, Calendar.JANUARY, 1).getTime());
        final List<TransactionInfo> transactionInfos = Arrays.asList(transactionInfo1);
        when(mockTransactionInfoMapper.selectTransactionInfoList(any(TransactionInfo.class))).thenReturn(
                transactionInfos);

        // Run the test
        final List<TransactionInfo> result = transactionInfoServiceImplUnderTest.selectTransactionInfoList(
                transactionInfo);

        // Verify the results
    }

    @Test
    void testSelectTransactionInfoList_TransactionInfoMapperReturnsNoItems() {
        // Setup
        final TransactionInfo transactionInfo = new TransactionInfo();
        transactionInfo.setfStreamId(0L);
        transactionInfo.setUserId(0L);
        transactionInfo.setCardId("cardId");
        transactionInfo.setfId("fId");
        transactionInfo.setfDealTime(new GregorianCalendar(2020, Calendar.JANUARY, 1).getTime());

        when(mockTransactionInfoMapper.selectTransactionInfoList(any(TransactionInfo.class))).thenReturn(
                Collections.emptyList());

        // Run the test
        final List<TransactionInfo> result = transactionInfoServiceImplUnderTest.selectTransactionInfoList(
                transactionInfo);

        // Verify the results
        assertThat(result).isEqualTo(Collections.emptyList());
    }

    @Test
    void testInsertTransactionInfo() {
        // Setup
        final TransactionInfo transactionInfo = new TransactionInfo();
        transactionInfo.setfStreamId(0L);
        transactionInfo.setUserId(0L);
        transactionInfo.setCardId("cardId");
        transactionInfo.setfId("fId");
        transactionInfo.setfDealTime(new GregorianCalendar(2020, Calendar.JANUARY, 1).getTime());

        when(mockTransactionInfoMapper.insertTransactionInfo(any(TransactionInfo.class))).thenReturn(0);

        // Run the test
        final int result = transactionInfoServiceImplUnderTest.insertTransactionInfo(transactionInfo);

        // Verify the results
        assertThat(result).isEqualTo(0);
    }

    @Test
    void testUpdateTransactionInfo() {
        // Setup
        final TransactionInfo transactionInfo = new TransactionInfo();
        transactionInfo.setfStreamId(0L);
        transactionInfo.setUserId(0L);
        transactionInfo.setCardId("cardId");
        transactionInfo.setfId("fId");
        transactionInfo.setfDealTime(new GregorianCalendar(2020, Calendar.JANUARY, 1).getTime());

        when(mockTransactionInfoMapper.updateTransactionInfo(any(TransactionInfo.class))).thenReturn(0);

        // Run the test
        final int result = transactionInfoServiceImplUnderTest.updateTransactionInfo(transactionInfo);

        // Verify the results
        assertThat(result).isEqualTo(0);
    }

    @Test
    void testDeleteTransactionInfoByFStreamIds() {
        // Setup
        when(mockTransactionInfoMapper.deleteTransactionInfoByFStreamIds(any(Long[].class))).thenReturn(0);

        // Run the test
        final int result = transactionInfoServiceImplUnderTest.deleteTransactionInfoByFStreamIds(new Long[]{0L});

        // Verify the results
        assertThat(result).isEqualTo(0);
    }

    @Test
    void testDeleteTransactionInfoByFStreamId() {
        // Setup
        when(mockTransactionInfoMapper.deleteTransactionInfoByFStreamId(0L)).thenReturn(0);

        // Run the test
        final int result = transactionInfoServiceImplUnderTest.deleteTransactionInfoByFStreamId(0L);

        // Verify the results
        assertThat(result).isEqualTo(0);
    }
}
