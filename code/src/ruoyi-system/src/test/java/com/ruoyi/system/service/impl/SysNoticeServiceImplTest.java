package com.ruoyi.system.service.impl;

import com.ruoyi.system.domain.SysNotice;
import com.ruoyi.system.mapper.SysNoticeMapper;
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

class SysNoticeServiceImplTest {

    @Mock
    private SysNoticeMapper mockNoticeMapper;

    @InjectMocks
    private SysNoticeServiceImpl sysNoticeServiceImplUnderTest;

    @BeforeEach
    void setUp() {
        initMocks(this);
    }

    @Test
    void testSelectNoticeById() {
        // Setup
        // Configure SysNoticeMapper.selectNoticeById(...).
        final SysNotice sysNotice = new SysNotice();
        sysNotice.setNoticeId(0L);
        sysNotice.setNoticeTitle("noticeTitle");
        sysNotice.setNoticeType("noticeType");
        sysNotice.setNoticeContent("noticeContent");
        sysNotice.setStatus("status");
        when(mockNoticeMapper.selectNoticeById(0L)).thenReturn(sysNotice);

        // Run the test
        final SysNotice result = sysNoticeServiceImplUnderTest.selectNoticeById(0L);

        // Verify the results
    }

    @Test
    void testSelectNoticeList() {
        // Setup
        final SysNotice notice = new SysNotice();
        notice.setNoticeId(0L);
        notice.setNoticeTitle("noticeTitle");
        notice.setNoticeType("noticeType");
        notice.setNoticeContent("noticeContent");
        notice.setStatus("status");

        // Configure SysNoticeMapper.selectNoticeList(...).
        final SysNotice sysNotice = new SysNotice();
        sysNotice.setNoticeId(0L);
        sysNotice.setNoticeTitle("noticeTitle");
        sysNotice.setNoticeType("noticeType");
        sysNotice.setNoticeContent("noticeContent");
        sysNotice.setStatus("status");
        final List<SysNotice> sysNotices = Arrays.asList(sysNotice);
        when(mockNoticeMapper.selectNoticeList(any(SysNotice.class))).thenReturn(sysNotices);

        // Run the test
        final List<SysNotice> result = sysNoticeServiceImplUnderTest.selectNoticeList(notice);

        // Verify the results
    }

    @Test
    void testSelectNoticeList_SysNoticeMapperReturnsNoItems() {
        // Setup
        final SysNotice notice = new SysNotice();
        notice.setNoticeId(0L);
        notice.setNoticeTitle("noticeTitle");
        notice.setNoticeType("noticeType");
        notice.setNoticeContent("noticeContent");
        notice.setStatus("status");

        when(mockNoticeMapper.selectNoticeList(any(SysNotice.class))).thenReturn(Collections.emptyList());

        // Run the test
        final List<SysNotice> result = sysNoticeServiceImplUnderTest.selectNoticeList(notice);

        // Verify the results
        assertThat(result).isEqualTo(Collections.emptyList());
    }

    @Test
    void testInsertNotice() {
        // Setup
        final SysNotice notice = new SysNotice();
        notice.setNoticeId(0L);
        notice.setNoticeTitle("noticeTitle");
        notice.setNoticeType("noticeType");
        notice.setNoticeContent("noticeContent");
        notice.setStatus("status");

        when(mockNoticeMapper.insertNotice(any(SysNotice.class))).thenReturn(0);

        // Run the test
        final int result = sysNoticeServiceImplUnderTest.insertNotice(notice);

        // Verify the results
        assertThat(result).isEqualTo(0);
    }

    @Test
    void testUpdateNotice() {
        // Setup
        final SysNotice notice = new SysNotice();
        notice.setNoticeId(0L);
        notice.setNoticeTitle("noticeTitle");
        notice.setNoticeType("noticeType");
        notice.setNoticeContent("noticeContent");
        notice.setStatus("status");

        when(mockNoticeMapper.updateNotice(any(SysNotice.class))).thenReturn(0);

        // Run the test
        final int result = sysNoticeServiceImplUnderTest.updateNotice(notice);

        // Verify the results
        assertThat(result).isEqualTo(0);
    }

    @Test
    void testDeleteNoticeById() {
        // Setup
        when(mockNoticeMapper.deleteNoticeById(0L)).thenReturn(0);

        // Run the test
        final int result = sysNoticeServiceImplUnderTest.deleteNoticeById(0L);

        // Verify the results
        assertThat(result).isEqualTo(0);
    }

    @Test
    void testDeleteNoticeByIds() {
        // Setup
        when(mockNoticeMapper.deleteNoticeByIds(any(Long[].class))).thenReturn(0);

        // Run the test
        final int result = sysNoticeServiceImplUnderTest.deleteNoticeByIds(new Long[]{0L});

        // Verify the results
        assertThat(result).isEqualTo(0);
    }
}
