package com.ruoyi.card.controller;

import com.ruoyi.card.domain.UserCard;
import com.ruoyi.card.service.IUserCardService;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.test.web.servlet.MockMvc;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.when;
import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.user;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;

@ExtendWith(SpringExtension.class)
@WebMvcTest(UserCardController.class)
class UserCardControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private IUserCardService mockUserCardService;

    @Test
    void testList() {
        // Setup
        // Configure IUserCardService.selectUserCardList(...).
        final UserCard userCard = new UserCard();
        userCard.setCardId("cardId");
        userCard.setUserId(0L);
        userCard.setCardAmount(0L);
        userCard.setCardStatus("cardStatus");
        final List<UserCard> userCards = Arrays.asList(userCard);
        when(mockUserCardService.selectUserCardList(any(UserCard.class))).thenReturn(userCards);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(get("/card/CardManagement/list")
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testList_IUserCardServiceReturnsNoItems() {
        // Setup
        when(mockUserCardService.selectUserCardList(any(UserCard.class))).thenReturn(Collections.emptyList());

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(get("/card/CardManagement/list")
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testExport() {
        // Setup
        // Configure IUserCardService.selectUserCardList(...).
        final UserCard userCard = new UserCard();
        userCard.setCardId("cardId");
        userCard.setUserId(0L);
        userCard.setCardAmount(0L);
        userCard.setCardStatus("cardStatus");
        final List<UserCard> userCards = Arrays.asList(userCard);
        when(mockUserCardService.selectUserCardList(any(UserCard.class))).thenReturn(userCards);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(post("/card/CardManagement/export")
                        .content("content").contentType(MediaType.APPLICATION_JSON)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testExport_IUserCardServiceReturnsNoItems() {
        // Setup
        when(mockUserCardService.selectUserCardList(any(UserCard.class))).thenReturn(Collections.emptyList());

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(post("/card/CardManagement/export")
                        .content("content").contentType(MediaType.APPLICATION_JSON)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testGetInfo() {
        // Setup
        // Configure IUserCardService.selectUserCardByCardId(...).
        final UserCard userCard = new UserCard();
        userCard.setCardId("cardId");
        userCard.setUserId(0L);
        userCard.setCardAmount(0L);
        userCard.setCardStatus("cardStatus");
        when(mockUserCardService.selectUserCardByCardId("cardId")).thenReturn(userCard);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(get("/card/CardManagement/{cardId}", "cardId")
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testAdd() {
        // Setup
        when(mockUserCardService.insertUserCard(any(UserCard.class))).thenReturn(0);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(post("/card/CardManagement")
                        .content("content").contentType(MediaType.APPLICATION_JSON)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testEdit() {
        // Setup
        when(mockUserCardService.updateUserCard(any(UserCard.class))).thenReturn(0);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(put("/card/CardManagement")
                        .content("content").contentType(MediaType.APPLICATION_JSON)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testRemove() {
        // Setup
        when(mockUserCardService.deleteUserCardByCardIds(any(String[].class))).thenReturn(0);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(delete("/card/CardManagement/{cardIds}", "cardIds")
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }
}
