package com.ruoyi.web.controller.monitor;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.data.redis.core.RedisCallback;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.test.web.servlet.MockMvc;

import java.util.Arrays;
import java.util.Collections;
import java.util.HashSet;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.user;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;

@ExtendWith(SpringExtension.class)
@WebMvcTest(CacheController.class)
class CacheControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private RedisTemplate<String, String> mockRedisTemplate;

    @Test
    void testGetInfo() {
        // Setup
        when(mockRedisTemplate.execute(any(RedisCallback.class))).thenReturn("result");

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(get("/monitor/cache")
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testGetInfo_RedisTemplateReturnsNull() {
        // Setup
        when(mockRedisTemplate.execute(any(RedisCallback.class))).thenReturn(null);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(get("/monitor/cache")
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testCache() {
        // Setup
        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(get("/monitor/cache/getNames")
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testGetCacheKeys() {
        // Setup
        when(mockRedisTemplate.keys("pattern")).thenReturn(new HashSet<>(Arrays.asList("value")));

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(get("/monitor/cache/getKeys/{cacheName}", "cacheName")
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testGetCacheKeys_RedisTemplateReturnsNull() {
        // Setup
        when(mockRedisTemplate.keys("pattern")).thenReturn(null);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(get("/monitor/cache/getKeys/{cacheName}", "cacheName")
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testGetCacheKeys_RedisTemplateReturnsNoItems() {
        // Setup
        when(mockRedisTemplate.keys("pattern")).thenReturn(Collections.emptySet());

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(get("/monitor/cache/getKeys/{cacheName}", "cacheName")
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testGetCacheValue() {
        // Setup
        when(mockRedisTemplate.opsForValue()).thenReturn(null);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(
                        get("/monitor/cache/getValue/{cacheName}/{cacheKey}", "cacheName", "cacheKey")
                                .with(user("username"))
                                .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testClearCacheName() {
        // Setup
        when(mockRedisTemplate.keys("pattern")).thenReturn(new HashSet<>(Arrays.asList("value")));

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(
                        delete("/monitor/cache/clearCacheName/{cacheName}", "cacheName")
                                .with(user("username"))
                                .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
        verify(mockRedisTemplate).delete(Arrays.asList("value"));
    }

    @Test
    void testClearCacheName_RedisTemplateKeysReturnsNull() {
        // Setup
        when(mockRedisTemplate.keys("pattern")).thenReturn(null);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(
                        delete("/monitor/cache/clearCacheName/{cacheName}", "cacheName")
                                .with(user("username"))
                                .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
        verify(mockRedisTemplate).delete(Arrays.asList("value"));
    }

    @Test
    void testClearCacheName_RedisTemplateKeysReturnsNoItems() {
        // Setup
        when(mockRedisTemplate.keys("pattern")).thenReturn(Collections.emptySet());

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(
                        delete("/monitor/cache/clearCacheName/{cacheName}", "cacheName")
                                .with(user("username"))
                                .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
        verify(mockRedisTemplate).delete(Arrays.asList("value"));
    }

    @Test
    void testClearCacheKey() {
        // Setup
        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(
                        delete("/monitor/cache/clearCacheKey/{cacheKey}", "cacheKey")
                                .with(user("username"))
                                .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
        verify(mockRedisTemplate).delete("cacheKey");
    }

    @Test
    void testClearCacheAll() {
        // Setup
        when(mockRedisTemplate.keys("*")).thenReturn(new HashSet<>(Arrays.asList("value")));

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(delete("/monitor/cache/clearCacheAll")
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
        verify(mockRedisTemplate).delete(Arrays.asList("value"));
    }

    @Test
    void testClearCacheAll_RedisTemplateKeysReturnsNull() {
        // Setup
        when(mockRedisTemplate.keys("*")).thenReturn(null);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(delete("/monitor/cache/clearCacheAll")
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
        verify(mockRedisTemplate).delete(Arrays.asList("value"));
    }

    @Test
    void testClearCacheAll_RedisTemplateKeysReturnsNoItems() {
        // Setup
        when(mockRedisTemplate.keys("*")).thenReturn(Collections.emptySet());

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(delete("/monitor/cache/clearCacheAll")
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
        verify(mockRedisTemplate).delete(Arrays.asList("value"));
    }
}
