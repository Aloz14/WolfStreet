package com.ruoyi.card.service.impl;

import com.ruoyi.card.domain.UserCard;
import com.ruoyi.card.mapper.UserCardMapper;
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

class UserCardServiceImplTest {

    @Mock
    private UserCardMapper mockUserCardMapper;

    @InjectMocks
    private UserCardServiceImpl userCardServiceImplUnderTest;

    @BeforeEach
    void setUp() {
        initMocks(this);
    }

    @Test
    void testSelectUserCardByCardId() {
        // Setup
        // Configure UserCardMapper.selectUserCardByCardId(...).
        final UserCard userCard = new UserCard();
        userCard.setCardId("cardId");
        userCard.setUserId(0L);
        userCard.setCardAmount(0L);
        userCard.setCardStatus("cardStatus");
        when(mockUserCardMapper.selectUserCardByCardId("cardId")).thenReturn(userCard);

        // Run the test
        final UserCard result = userCardServiceImplUnderTest.selectUserCardByCardId("cardId");

        // Verify the results
    }

    @Test
    void testSelectUserCardList() {
        // Setup
        final UserCard userCard = new UserCard();
        userCard.setCardId("cardId");
        userCard.setUserId(0L);
        userCard.setCardAmount(0L);
        userCard.setCardStatus("cardStatus");

        // Configure UserCardMapper.selectUserCardList(...).
        final UserCard userCard1 = new UserCard();
        userCard1.setCardId("cardId");
        userCard1.setUserId(0L);
        userCard1.setCardAmount(0L);
        userCard1.setCardStatus("cardStatus");
        final List<UserCard> userCards = Arrays.asList(userCard1);
        when(mockUserCardMapper.selectUserCardList(any(UserCard.class))).thenReturn(userCards);

        // Run the test
        final List<UserCard> result = userCardServiceImplUnderTest.selectUserCardList(userCard);

        // Verify the results
    }

    @Test
    void testSelectUserCardList_UserCardMapperReturnsNoItems() {
        // Setup
        final UserCard userCard = new UserCard();
        userCard.setCardId("cardId");
        userCard.setUserId(0L);
        userCard.setCardAmount(0L);
        userCard.setCardStatus("cardStatus");

        when(mockUserCardMapper.selectUserCardList(any(UserCard.class))).thenReturn(Collections.emptyList());

        // Run the test
        final List<UserCard> result = userCardServiceImplUnderTest.selectUserCardList(userCard);

        // Verify the results
        assertThat(result).isEqualTo(Collections.emptyList());
    }

    @Test
    void testInsertUserCard() {
        // Setup
        final UserCard userCard = new UserCard();
        userCard.setCardId("cardId");
        userCard.setUserId(0L);
        userCard.setCardAmount(0L);
        userCard.setCardStatus("cardStatus");

        when(mockUserCardMapper.insertUserCard(any(UserCard.class))).thenReturn(0);

        // Run the test
        final int result = userCardServiceImplUnderTest.insertUserCard(userCard);

        // Verify the results
        assertThat(result).isEqualTo(0);
    }

    @Test
    void testUpdateUserCard() {
        // Setup
        final UserCard userCard = new UserCard();
        userCard.setCardId("cardId");
        userCard.setUserId(0L);
        userCard.setCardAmount(0L);
        userCard.setCardStatus("cardStatus");

        when(mockUserCardMapper.updateUserCard(any(UserCard.class))).thenReturn(0);

        // Run the test
        final int result = userCardServiceImplUnderTest.updateUserCard(userCard);

        // Verify the results
        assertThat(result).isEqualTo(0);
    }

    @Test
    void testDeleteUserCardByCardIds() {
        // Setup
        when(mockUserCardMapper.deleteUserCardByCardIds(any(String[].class))).thenReturn(0);

        // Run the test
        final int result = userCardServiceImplUnderTest.deleteUserCardByCardIds(new String[]{"cardIds"});

        // Verify the results
        assertThat(result).isEqualTo(0);
    }

    @Test
    void testDeleteUserCardByCardId() {
        // Setup
        when(mockUserCardMapper.deleteUserCardByCardId("cardId")).thenReturn(0);

        // Run the test
        final int result = userCardServiceImplUnderTest.deleteUserCardByCardId("cardId");

        // Verify the results
        assertThat(result).isEqualTo(0);
    }
}
