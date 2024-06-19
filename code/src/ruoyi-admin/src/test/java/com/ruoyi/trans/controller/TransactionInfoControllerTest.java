package com.ruoyi.trans.controller;

import com.ruoyi.trans.domain.TransactionInfo;
import com.ruoyi.trans.service.ITransactionInfoService;
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

import java.util.*;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.when;
import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.user;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;

@ExtendWith(SpringExtension.class)
@WebMvcTest(TransactionInfoController.class)
class TransactionInfoControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private ITransactionInfoService mockTransactionInfoService;

    @Test
    void testList() {
        // Setup
        // Configure ITransactionInfoService.selectTransactionInfoList(...).
        final TransactionInfo transactionInfo = new TransactionInfo();
        transactionInfo.setfStreamId(0L);
        transactionInfo.setUserId(0L);
        transactionInfo.setCardId("cardId");
        transactionInfo.setfId("fId");
        transactionInfo.setfDealTime(new GregorianCalendar(2020, Calendar.JANUARY, 1).getTime());
        final List<TransactionInfo> transactionInfos = Arrays.asList(transactionInfo);
        when(mockTransactionInfoService.selectTransactionInfoList(any(TransactionInfo.class))).thenReturn(
                transactionInfos);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(get("/transaction_manage/trans/list")
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testList_ITransactionInfoServiceReturnsNoItems() {
        // Setup
        when(mockTransactionInfoService.selectTransactionInfoList(any(TransactionInfo.class))).thenReturn(
                Collections.emptyList());

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(get("/transaction_manage/trans/list")
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
        // Configure ITransactionInfoService.selectTransactionInfoList(...).
        final TransactionInfo transactionInfo = new TransactionInfo();
        transactionInfo.setfStreamId(0L);
        transactionInfo.setUserId(0L);
        transactionInfo.setCardId("cardId");
        transactionInfo.setfId("fId");
        transactionInfo.setfDealTime(new GregorianCalendar(2020, Calendar.JANUARY, 1).getTime());
        final List<TransactionInfo> transactionInfos = Arrays.asList(transactionInfo);
        when(mockTransactionInfoService.selectTransactionInfoList(any(TransactionInfo.class))).thenReturn(
                transactionInfos);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(post("/transaction_manage/trans/export")
                        .content("content").contentType(MediaType.APPLICATION_JSON)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testExport_ITransactionInfoServiceReturnsNoItems() {
        // Setup
        when(mockTransactionInfoService.selectTransactionInfoList(any(TransactionInfo.class))).thenReturn(
                Collections.emptyList());

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(post("/transaction_manage/trans/export")
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
        // Configure ITransactionInfoService.selectTransactionInfoByFStreamId(...).
        final TransactionInfo transactionInfo = new TransactionInfo();
        transactionInfo.setfStreamId(0L);
        transactionInfo.setUserId(0L);
        transactionInfo.setCardId("cardId");
        transactionInfo.setfId("fId");
        transactionInfo.setfDealTime(new GregorianCalendar(2020, Calendar.JANUARY, 1).getTime());
        when(mockTransactionInfoService.selectTransactionInfoByFStreamId(0L)).thenReturn(transactionInfo);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(get("/transaction_manage/trans/{fStreamId}", 0)
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
        when(mockTransactionInfoService.insertTransactionInfo(any(TransactionInfo.class))).thenReturn(0);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(post("/transaction_manage/trans")
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
        when(mockTransactionInfoService.updateTransactionInfo(any(TransactionInfo.class))).thenReturn(0);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(put("/transaction_manage/trans")
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
        when(mockTransactionInfoService.deleteTransactionInfoByFStreamIds(any(Long[].class))).thenReturn(0);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(delete("/transaction_manage/trans/{fStreamIds}", 0)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }
}
