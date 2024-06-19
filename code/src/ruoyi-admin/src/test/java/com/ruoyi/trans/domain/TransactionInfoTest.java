package com.ruoyi.trans.domain;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

import static org.assertj.core.api.Assertions.assertThat;

class TransactionInfoTest {

    private TransactionInfo transactionInfoUnderTest;

    @BeforeEach
    void setUp() {
        transactionInfoUnderTest = new TransactionInfo();
    }

    @Test
    void testFStreamIdGetterAndSetter() {
        final Long fStreamId = 0L;
        transactionInfoUnderTest.setfStreamId(fStreamId);
        assertThat(transactionInfoUnderTest.getfStreamId()).isEqualTo(fStreamId);
    }

    @Test
    void testUserIdGetterAndSetter() {
        final Long userId = 0L;
        transactionInfoUnderTest.setUserId(userId);
        assertThat(transactionInfoUnderTest.getUserId()).isEqualTo(userId);
    }

    @Test
    void testCardIdGetterAndSetter() {
        final String cardId = "cardId";
        transactionInfoUnderTest.setCardId(cardId);
        assertThat(transactionInfoUnderTest.getCardId()).isEqualTo(cardId);
    }

    @Test
    void testFIdGetterAndSetter() {
        final String fId = "fId";
        transactionInfoUnderTest.setfId(fId);
        assertThat(transactionInfoUnderTest.getfId()).isEqualTo(fId);
    }

    @Test
    void testFDealTimeGetterAndSetter() {
        final Date fDealTime = new GregorianCalendar(2020, Calendar.JANUARY, 1).getTime();
        transactionInfoUnderTest.setfDealTime(fDealTime);
        assertThat(transactionInfoUnderTest.getfDealTime()).isEqualTo(fDealTime);
    }

    @Test
    void testFDealAmountGetterAndSetter() {
        final Long fDealAmount = 0L;
        transactionInfoUnderTest.setfDealAmount(fDealAmount);
        assertThat(transactionInfoUnderTest.getfDealAmount()).isEqualTo(fDealAmount);
    }

    @Test
    void testFDealStatusGetterAndSetter() {
        final Long fDealStatus = 0L;
        transactionInfoUnderTest.setfDealStatus(fDealStatus);
        assertThat(transactionInfoUnderTest.getfDealStatus()).isEqualTo(fDealStatus);
    }

    @Test
    void testFDealTypeGetterAndSetter() {
        final Long fDealType = 0L;
        transactionInfoUnderTest.setfDealType(fDealType);
        assertThat(transactionInfoUnderTest.getfDealType()).isEqualTo(fDealType);
    }

    @Test
    void testToString() {
        assertThat(transactionInfoUnderTest.toString()).isEqualTo("result");
    }
}
