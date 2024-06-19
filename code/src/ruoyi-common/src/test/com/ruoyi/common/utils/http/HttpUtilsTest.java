package com.ruoyi.common.utils.http;

import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;

class HttpUtilsTest {

    @Test
    void testSendGet1() {
        assertThat(HttpUtils.sendGet("url")).isEqualTo("result");
    }

    @Test
    void testSendGet2() {
        assertThat(HttpUtils.sendGet("url", "param")).isEqualTo("result");
    }

    @Test
    void testSendGet3() {
        assertThat(HttpUtils.sendGet("url", "param", "contentType")).isEqualTo("result");
    }

    @Test
    void testSendPost() {
        assertThat(HttpUtils.sendPost("url", "param")).isEqualTo("result");
    }

    @Test
    void testSendSSLPost() {
        assertThat(HttpUtils.sendSSLPost("url", "param")).isEqualTo("result");
    }
}
