package com.ruoyi.web.controller.monitor;

import com.ruoyi.framework.web.service.SysPasswordService;
import com.ruoyi.system.domain.SysLogininfor;
import com.ruoyi.system.service.ISysLogininforService;
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
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.user;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;

@ExtendWith(SpringExtension.class)
@WebMvcTest(SysLogininforController.class)
class SysLogininforControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private ISysLogininforService mockLogininforService;
    @MockBean
    private SysPasswordService mockPasswordService;

    @Test
    void testList() {
        // Setup
        // Configure ISysLogininforService.selectLogininforList(...).
        final SysLogininfor sysLogininfor = new SysLogininfor();
        sysLogininfor.setInfoId(0L);
        sysLogininfor.setUserName("userName");
        sysLogininfor.setStatus("status");
        sysLogininfor.setIpaddr("ipaddr");
        sysLogininfor.setLoginLocation("loginLocation");
        final List<SysLogininfor> sysLogininfors = Arrays.asList(sysLogininfor);
        when(mockLogininforService.selectLogininforList(any(SysLogininfor.class))).thenReturn(sysLogininfors);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(get("/monitor/logininfor/list")
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testList_ISysLogininforServiceReturnsNoItems() {
        // Setup
        when(mockLogininforService.selectLogininforList(any(SysLogininfor.class))).thenReturn(Collections.emptyList());

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(get("/monitor/logininfor/list")
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
        // Configure ISysLogininforService.selectLogininforList(...).
        final SysLogininfor sysLogininfor = new SysLogininfor();
        sysLogininfor.setInfoId(0L);
        sysLogininfor.setUserName("userName");
        sysLogininfor.setStatus("status");
        sysLogininfor.setIpaddr("ipaddr");
        sysLogininfor.setLoginLocation("loginLocation");
        final List<SysLogininfor> sysLogininfors = Arrays.asList(sysLogininfor);
        when(mockLogininforService.selectLogininforList(any(SysLogininfor.class))).thenReturn(sysLogininfors);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(post("/monitor/logininfor/export")
                        .content("content").contentType(MediaType.APPLICATION_JSON)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testExport_ISysLogininforServiceReturnsNoItems() {
        // Setup
        when(mockLogininforService.selectLogininforList(any(SysLogininfor.class))).thenReturn(Collections.emptyList());

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(post("/monitor/logininfor/export")
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
        when(mockLogininforService.deleteLogininforByIds(any(Long[].class))).thenReturn(0);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(delete("/monitor/logininfor/{infoIds}", 0)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testClean() {
        // Setup
        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(delete("/monitor/logininfor/clean")
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
        verify(mockLogininforService).cleanLogininfor();
    }

    @Test
    void testUnlock() {
        // Setup
        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(
                        get("/monitor/logininfor/unlock/{userName}", "userName")
                                .with(user("username"))
                                .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
        verify(mockPasswordService).clearLoginRecordCache("userName");
    }
}
