package com.ruoyi.web.controller.system;

import com.ruoyi.system.domain.SysNotice;
import com.ruoyi.system.service.ISysNoticeService;
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
@WebMvcTest(SysNoticeController.class)
class SysNoticeControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private ISysNoticeService mockNoticeService;

    @Test
    void testList() {
        // Setup
        // Configure ISysNoticeService.selectNoticeList(...).
        final SysNotice sysNotice = new SysNotice();
        sysNotice.setCreateBy("createBy");
        sysNotice.setUpdateBy("updateBy");
        sysNotice.setNoticeId(0L);
        sysNotice.setNoticeTitle("noticeTitle");
        sysNotice.setNoticeType("noticeType");
        final List<SysNotice> sysNotices = Arrays.asList(sysNotice);
        when(mockNoticeService.selectNoticeList(any(SysNotice.class))).thenReturn(sysNotices);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(get("/system/notice/list")
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testList_ISysNoticeServiceReturnsNoItems() {
        // Setup
        when(mockNoticeService.selectNoticeList(any(SysNotice.class))).thenReturn(Collections.emptyList());

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(get("/system/notice/list")
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
        // Configure ISysNoticeService.selectNoticeById(...).
        final SysNotice sysNotice = new SysNotice();
        sysNotice.setCreateBy("createBy");
        sysNotice.setUpdateBy("updateBy");
        sysNotice.setNoticeId(0L);
        sysNotice.setNoticeTitle("noticeTitle");
        sysNotice.setNoticeType("noticeType");
        when(mockNoticeService.selectNoticeById(0L)).thenReturn(sysNotice);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(get("/system/notice/{noticeId}", 0)
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
        when(mockNoticeService.insertNotice(any(SysNotice.class))).thenReturn(0);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(post("/system/notice")
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
        when(mockNoticeService.updateNotice(any(SysNotice.class))).thenReturn(0);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(put("/system/notice")
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
        when(mockNoticeService.deleteNoticeByIds(any(Long[].class))).thenReturn(0);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(delete("/system/notice/{noticeIds}", 0)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }
}
