package com.ruoyi.fund.controller;

import com.ruoyi.fund.domain.FundInfo;
import com.ruoyi.fund.service.IFundInfoService;
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
@WebMvcTest(FundInfoController.class)
class FundInfoControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private IFundInfoService mockFundInfoService;

    @Test
    void testList() {
        // Setup
        // Configure IFundInfoService.selectFundInfoList(...).
        final FundInfo fundInfo = new FundInfo();
        fundInfo.setfId("fId");
        fundInfo.setfName("fName");
        fundInfo.setfType(0L);
        fundInfo.setfSize(0L);
        fundInfo.setfMonitor("fMonitor");
        final List<FundInfo> fundInfos = Arrays.asList(fundInfo);
        when(mockFundInfoService.selectFundInfoList(any(FundInfo.class))).thenReturn(fundInfos);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(get("/fund_manage/FundManagement/list")
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testList_IFundInfoServiceReturnsNoItems() {
        // Setup
        when(mockFundInfoService.selectFundInfoList(any(FundInfo.class))).thenReturn(Collections.emptyList());

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(get("/fund_manage/FundManagement/list")
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
        // Configure IFundInfoService.selectFundInfoList(...).
        final FundInfo fundInfo = new FundInfo();
        fundInfo.setfId("fId");
        fundInfo.setfName("fName");
        fundInfo.setfType(0L);
        fundInfo.setfSize(0L);
        fundInfo.setfMonitor("fMonitor");
        final List<FundInfo> fundInfos = Arrays.asList(fundInfo);
        when(mockFundInfoService.selectFundInfoList(any(FundInfo.class))).thenReturn(fundInfos);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(post("/fund_manage/FundManagement/export")
                        .content("content").contentType(MediaType.APPLICATION_JSON)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testExport_IFundInfoServiceReturnsNoItems() {
        // Setup
        when(mockFundInfoService.selectFundInfoList(any(FundInfo.class))).thenReturn(Collections.emptyList());

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(post("/fund_manage/FundManagement/export")
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
        // Configure IFundInfoService.selectFundInfoByFId(...).
        final FundInfo fundInfo = new FundInfo();
        fundInfo.setfId("fId");
        fundInfo.setfName("fName");
        fundInfo.setfType(0L);
        fundInfo.setfSize(0L);
        fundInfo.setfMonitor("fMonitor");
        when(mockFundInfoService.selectFundInfoByFId("fId")).thenReturn(fundInfo);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(get("/fund_manage/FundManagement/{fId}", "fId")
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
        when(mockFundInfoService.insertFundInfo(any(FundInfo.class))).thenReturn(0);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(post("/fund_manage/FundManagement")
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
        when(mockFundInfoService.updateFundInfo(any(FundInfo.class))).thenReturn(0);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(put("/fund_manage/FundManagement")
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
        when(mockFundInfoService.deleteFundInfoByFIds(any(String[].class))).thenReturn(0);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(delete("/fund_manage/FundManagement/{fIds}", "fIds")
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }
}
