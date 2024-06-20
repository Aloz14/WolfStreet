package com.ruoyi.card.domain;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;

class UserCardTest {

    private UserCard userCardUnderTest;

    @BeforeEach
    void setUp() {
        userCardUnderTest = new UserCard();
    }

    @Test
    void testCardIdGetterAndSetter() {
        final String cardId = "cardId";
        userCardUnderTest.setCardId(cardId);
        assertThat(userCardUnderTest.getCardId()).isEqualTo(cardId);
    }

    @Test
    void testUserIdGetterAndSetter() {
        final Long userId = 0L;
        userCardUnderTest.setUserId(userId);
        assertThat(userCardUnderTest.getUserId()).isEqualTo(userId);
    }

    @Test
    void testCardAmountGetterAndSetter() {
        final Long cardAmount = 0L;
        userCardUnderTest.setCardAmount(cardAmount);
        assertThat(userCardUnderTest.getCardAmount()).isEqualTo(cardAmount);
    }

    @Test
    void testCardStatusGetterAndSetter() {
        final String cardStatus = "cardStatus";
        userCardUnderTest.setCardStatus(cardStatus);
        assertThat(userCardUnderTest.getCardStatus()).isEqualTo(cardStatus);
    }

    @Test
    void testToString() {
        assertThat(userCardUnderTest.toString()).isEqualTo("result");
    }
}
