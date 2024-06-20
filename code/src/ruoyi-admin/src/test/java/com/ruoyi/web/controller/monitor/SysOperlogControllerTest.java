package com.ruoyi.web.controller.monitor;

import com.ruoyi.system.domain.SysOperLog;
import com.ruoyi.system.service.ISysOperLogService;
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
@WebMvcTest(SysOperlogController.class)
class SysOperlogControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private ISysOperLogService mockOperLogService;

    @Test
    void testList() {
        // Setup
        // Configure ISysOperLogService.selectOperLogList(...).
        final SysOperLog sysOperLog = new SysOperLog();
        sysOperLog.setOperId(0L);
        sysOperLog.setTitle("title");
        sysOperLog.setBusinessType(0);
        sysOperLog.setBusinessTypes(new Integer[]{0});
        sysOperLog.setMethod("method");
        final List<SysOperLog> sysOperLogs = Arrays.asList(sysOperLog);
        when(mockOperLogService.selectOperLogList(any(SysOperLog.class))).thenReturn(sysOperLogs);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(get("/monitor/operlog/list")
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testList_ISysOperLogServiceReturnsNoItems() {
        // Setup
        when(mockOperLogService.selectOperLogList(any(SysOperLog.class))).thenReturn(Collections.emptyList());

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(get("/monitor/operlog/list")
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
        // Configure ISysOperLogService.selectOperLogList(...).
        final SysOperLog sysOperLog = new SysOperLog();
        sysOperLog.setOperId(0L);
        sysOperLog.setTitle("title");
        sysOperLog.setBusinessType(0);
        sysOperLog.setBusinessTypes(new Integer[]{0});
        sysOperLog.setMethod("method");
        final List<SysOperLog> sysOperLogs = Arrays.asList(sysOperLog);
        when(mockOperLogService.selectOperLogList(any(SysOperLog.class))).thenReturn(sysOperLogs);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(post("/monitor/operlog/export")
                        .content("content").contentType(MediaType.APPLICATION_JSON)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testExport_ISysOperLogServiceReturnsNoItems() {
        // Setup
        when(mockOperLogService.selectOperLogList(any(SysOperLog.class))).thenReturn(Collections.emptyList());

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(post("/monitor/operlog/export")
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
        when(mockOperLogService.deleteOperLogByIds(any(Long[].class))).thenReturn(0);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(delete("/monitor/operlog/{operIds}", 0)
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
        final MockHttpServletResponse response = mockMvc.perform(delete("/monitor/operlog/clean")
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
        verify(mockOperLogService).cleanOperLog();
    }
}
