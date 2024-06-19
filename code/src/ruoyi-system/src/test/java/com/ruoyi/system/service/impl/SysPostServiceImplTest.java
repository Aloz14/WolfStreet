package com.ruoyi.system.service.impl;

import com.ruoyi.system.domain.SysPost;
import com.ruoyi.system.mapper.SysPostMapper;
import com.ruoyi.system.mapper.SysUserPostMapper;
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

class SysPostServiceImplTest {

    @Mock
    private SysPostMapper mockPostMapper;
    @Mock
    private SysUserPostMapper mockUserPostMapper;

    @InjectMocks
    private SysPostServiceImpl sysPostServiceImplUnderTest;

    @BeforeEach
    void setUp() {
        initMocks(this);
    }

    @Test
    void testSelectPostList() {
        // Setup
        final SysPost post = new SysPost();
        post.setPostId(0L);
        post.setPostCode("postCode");
        post.setPostName("postName");
        post.setPostSort(0);
        post.setStatus("status");

        // Configure SysPostMapper.selectPostList(...).
        final SysPost sysPost = new SysPost();
        sysPost.setPostId(0L);
        sysPost.setPostCode("postCode");
        sysPost.setPostName("postName");
        sysPost.setPostSort(0);
        sysPost.setStatus("status");
        final List<SysPost> sysPosts = Arrays.asList(sysPost);
        when(mockPostMapper.selectPostList(any(SysPost.class))).thenReturn(sysPosts);

        // Run the test
        final List<SysPost> result = sysPostServiceImplUnderTest.selectPostList(post);

        // Verify the results
    }

    @Test
    void testSelectPostList_SysPostMapperReturnsNoItems() {
        // Setup
        final SysPost post = new SysPost();
        post.setPostId(0L);
        post.setPostCode("postCode");
        post.setPostName("postName");
        post.setPostSort(0);
        post.setStatus("status");

        when(mockPostMapper.selectPostList(any(SysPost.class))).thenReturn(Collections.emptyList());

        // Run the test
        final List<SysPost> result = sysPostServiceImplUnderTest.selectPostList(post);

        // Verify the results
        assertThat(result).isEqualTo(Collections.emptyList());
    }

    @Test
    void testSelectPostAll() {
        // Setup
        // Configure SysPostMapper.selectPostAll(...).
        final SysPost sysPost = new SysPost();
        sysPost.setPostId(0L);
        sysPost.setPostCode("postCode");
        sysPost.setPostName("postName");
        sysPost.setPostSort(0);
        sysPost.setStatus("status");
        final List<SysPost> sysPosts = Arrays.asList(sysPost);
        when(mockPostMapper.selectPostAll()).thenReturn(sysPosts);

        // Run the test
        final List<SysPost> result = sysPostServiceImplUnderTest.selectPostAll();

        // Verify the results
    }

    @Test
    void testSelectPostAll_SysPostMapperReturnsNoItems() {
        // Setup
        when(mockPostMapper.selectPostAll()).thenReturn(Collections.emptyList());

        // Run the test
        final List<SysPost> result = sysPostServiceImplUnderTest.selectPostAll();

        // Verify the results
        assertThat(result).isEqualTo(Collections.emptyList());
    }

    @Test
    void testSelectPostById() {
        // Setup
        // Configure SysPostMapper.selectPostById(...).
        final SysPost sysPost = new SysPost();
        sysPost.setPostId(0L);
        sysPost.setPostCode("postCode");
        sysPost.setPostName("postName");
        sysPost.setPostSort(0);
        sysPost.setStatus("status");
        when(mockPostMapper.selectPostById(0L)).thenReturn(sysPost);

        // Run the test
        final SysPost result = sysPostServiceImplUnderTest.selectPostById(0L);

        // Verify the results
    }

    @Test
    void testSelectPostListByUserId() {
        // Setup
        when(mockPostMapper.selectPostListByUserId(0L)).thenReturn(Arrays.asList(0L));

        // Run the test
        final List<Long> result = sysPostServiceImplUnderTest.selectPostListByUserId(0L);

        // Verify the results
        assertThat(result).isEqualTo(Arrays.asList(0L));
    }

    @Test
    void testSelectPostListByUserId_SysPostMapperReturnsNoItems() {
        // Setup
        when(mockPostMapper.selectPostListByUserId(0L)).thenReturn(Collections.emptyList());

        // Run the test
        final List<Long> result = sysPostServiceImplUnderTest.selectPostListByUserId(0L);

        // Verify the results
        assertThat(result).isEqualTo(Collections.emptyList());
    }

    @Test
    void testCheckPostNameUnique() {
        // Setup
        final SysPost post = new SysPost();
        post.setPostId(0L);
        post.setPostCode("postCode");
        post.setPostName("postName");
        post.setPostSort(0);
        post.setStatus("status");

        // Configure SysPostMapper.checkPostNameUnique(...).
        final SysPost sysPost = new SysPost();
        sysPost.setPostId(0L);
        sysPost.setPostCode("postCode");
        sysPost.setPostName("postName");
        sysPost.setPostSort(0);
        sysPost.setStatus("status");
        when(mockPostMapper.checkPostNameUnique("postName")).thenReturn(sysPost);

        // Run the test
        final boolean result = sysPostServiceImplUnderTest.checkPostNameUnique(post);

        // Verify the results
        assertThat(result).isFalse();
    }

    @Test
    void testCheckPostCodeUnique() {
        // Setup
        final SysPost post = new SysPost();
        post.setPostId(0L);
        post.setPostCode("postCode");
        post.setPostName("postName");
        post.setPostSort(0);
        post.setStatus("status");

        // Configure SysPostMapper.checkPostCodeUnique(...).
        final SysPost sysPost = new SysPost();
        sysPost.setPostId(0L);
        sysPost.setPostCode("postCode");
        sysPost.setPostName("postName");
        sysPost.setPostSort(0);
        sysPost.setStatus("status");
        when(mockPostMapper.checkPostCodeUnique("postCode")).thenReturn(sysPost);

        // Run the test
        final boolean result = sysPostServiceImplUnderTest.checkPostCodeUnique(post);

        // Verify the results
        assertThat(result).isFalse();
    }

    @Test
    void testCountUserPostById() {
        // Setup
        when(mockUserPostMapper.countUserPostById(0L)).thenReturn(0);

        // Run the test
        final int result = sysPostServiceImplUnderTest.countUserPostById(0L);

        // Verify the results
        assertThat(result).isEqualTo(0);
    }

    @Test
    void testDeletePostById() {
        // Setup
        when(mockPostMapper.deletePostById(0L)).thenReturn(0);

        // Run the test
        final int result = sysPostServiceImplUnderTest.deletePostById(0L);

        // Verify the results
        assertThat(result).isEqualTo(0);
    }

    @Test
    void testDeletePostByIds() {
        // Setup
        // Configure SysPostMapper.selectPostById(...).
        final SysPost sysPost = new SysPost();
        sysPost.setPostId(0L);
        sysPost.setPostCode("postCode");
        sysPost.setPostName("postName");
        sysPost.setPostSort(0);
        sysPost.setStatus("status");
        when(mockPostMapper.selectPostById(0L)).thenReturn(sysPost);

        when(mockUserPostMapper.countUserPostById(0L)).thenReturn(0);
        when(mockPostMapper.deletePostByIds(any(Long[].class))).thenReturn(0);

        // Run the test
        final int result = sysPostServiceImplUnderTest.deletePostByIds(new Long[]{0L});

        // Verify the results
        assertThat(result).isEqualTo(0);
    }

    @Test
    void testInsertPost() {
        // Setup
        final SysPost post = new SysPost();
        post.setPostId(0L);
        post.setPostCode("postCode");
        post.setPostName("postName");
        post.setPostSort(0);
        post.setStatus("status");

        when(mockPostMapper.insertPost(any(SysPost.class))).thenReturn(0);

        // Run the test
        final int result = sysPostServiceImplUnderTest.insertPost(post);

        // Verify the results
        assertThat(result).isEqualTo(0);
    }

    @Test
    void testUpdatePost() {
        // Setup
        final SysPost post = new SysPost();
        post.setPostId(0L);
        post.setPostCode("postCode");
        post.setPostName("postName");
        post.setPostSort(0);
        post.setStatus("status");

        when(mockPostMapper.updatePost(any(SysPost.class))).thenReturn(0);

        // Run the test
        final int result = sysPostServiceImplUnderTest.updatePost(post);

        // Verify the results
        assertThat(result).isEqualTo(0);
    }
}
