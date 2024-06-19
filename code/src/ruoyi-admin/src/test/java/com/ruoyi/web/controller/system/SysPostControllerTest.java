package com.ruoyi.web.controller.system;

import com.ruoyi.system.domain.SysPost;
import com.ruoyi.system.service.ISysPostService;
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
@WebMvcTest(SysPostController.class)
class SysPostControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private ISysPostService mockPostService;

    @Test
    void testList() {
        // Setup
        // Configure ISysPostService.selectPostList(...).
        final SysPost sysPost = new SysPost();
        sysPost.setCreateBy("createBy");
        sysPost.setUpdateBy("updateBy");
        sysPost.setPostId(0L);
        sysPost.setPostCode("postCode");
        sysPost.setPostName("postName");
        final List<SysPost> sysPosts = Arrays.asList(sysPost);
        when(mockPostService.selectPostList(any(SysPost.class))).thenReturn(sysPosts);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(get("/system/post/list")
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testList_ISysPostServiceReturnsNoItems() {
        // Setup
        when(mockPostService.selectPostList(any(SysPost.class))).thenReturn(Collections.emptyList());

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(get("/system/post/list")
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
        // Configure ISysPostService.selectPostList(...).
        final SysPost sysPost = new SysPost();
        sysPost.setCreateBy("createBy");
        sysPost.setUpdateBy("updateBy");
        sysPost.setPostId(0L);
        sysPost.setPostCode("postCode");
        sysPost.setPostName("postName");
        final List<SysPost> sysPosts = Arrays.asList(sysPost);
        when(mockPostService.selectPostList(any(SysPost.class))).thenReturn(sysPosts);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(post("/system/post/export")
                        .content("content").contentType(MediaType.APPLICATION_JSON)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testExport_ISysPostServiceReturnsNoItems() {
        // Setup
        when(mockPostService.selectPostList(any(SysPost.class))).thenReturn(Collections.emptyList());

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(post("/system/post/export")
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
        // Configure ISysPostService.selectPostById(...).
        final SysPost sysPost = new SysPost();
        sysPost.setCreateBy("createBy");
        sysPost.setUpdateBy("updateBy");
        sysPost.setPostId(0L);
        sysPost.setPostCode("postCode");
        sysPost.setPostName("postName");
        when(mockPostService.selectPostById(0L)).thenReturn(sysPost);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(get("/system/post/{postId}", 0)
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
        when(mockPostService.checkPostNameUnique(any(SysPost.class))).thenReturn(false);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(post("/system/post")
                        .content("content").contentType(MediaType.APPLICATION_JSON)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testAdd_ISysPostServiceCheckPostNameUniqueReturnsTrue() {
        // Setup
        when(mockPostService.checkPostNameUnique(any(SysPost.class))).thenReturn(true);
        when(mockPostService.checkPostCodeUnique(any(SysPost.class))).thenReturn(false);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(post("/system/post")
                        .content("content").contentType(MediaType.APPLICATION_JSON)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testAdd_ISysPostServiceCheckPostCodeUniqueReturnsTrue() {
        // Setup
        when(mockPostService.checkPostNameUnique(any(SysPost.class))).thenReturn(true);
        when(mockPostService.checkPostCodeUnique(any(SysPost.class))).thenReturn(true);
        when(mockPostService.insertPost(any(SysPost.class))).thenReturn(0);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(post("/system/post")
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
        when(mockPostService.checkPostNameUnique(any(SysPost.class))).thenReturn(false);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(put("/system/post")
                        .content("content").contentType(MediaType.APPLICATION_JSON)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testEdit_ISysPostServiceCheckPostNameUniqueReturnsTrue() {
        // Setup
        when(mockPostService.checkPostNameUnique(any(SysPost.class))).thenReturn(true);
        when(mockPostService.checkPostCodeUnique(any(SysPost.class))).thenReturn(false);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(put("/system/post")
                        .content("content").contentType(MediaType.APPLICATION_JSON)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testEdit_ISysPostServiceCheckPostCodeUniqueReturnsTrue() {
        // Setup
        when(mockPostService.checkPostNameUnique(any(SysPost.class))).thenReturn(true);
        when(mockPostService.checkPostCodeUnique(any(SysPost.class))).thenReturn(true);
        when(mockPostService.updatePost(any(SysPost.class))).thenReturn(0);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(put("/system/post")
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
        when(mockPostService.deletePostByIds(any(Long[].class))).thenReturn(0);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(delete("/system/post/{postIds}", 0)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testOptionselect() {
        // Setup
        // Configure ISysPostService.selectPostAll(...).
        final SysPost sysPost = new SysPost();
        sysPost.setCreateBy("createBy");
        sysPost.setUpdateBy("updateBy");
        sysPost.setPostId(0L);
        sysPost.setPostCode("postCode");
        sysPost.setPostName("postName");
        final List<SysPost> sysPosts = Arrays.asList(sysPost);
        when(mockPostService.selectPostAll()).thenReturn(sysPosts);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(get("/system/post/optionselect")
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testOptionselect_ISysPostServiceReturnsNoItems() {
        // Setup
        when(mockPostService.selectPostAll()).thenReturn(Collections.emptyList());

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(get("/system/post/optionselect")
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }
}
