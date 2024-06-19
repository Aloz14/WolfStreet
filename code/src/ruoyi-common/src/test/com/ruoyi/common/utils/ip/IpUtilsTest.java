package com.ruoyi.common.utils.ip;

import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;

class IpUtilsTest {

    @Test
    void testGetIpAddr1() {
        assertThat(IpUtils.getIpAddr()).isEqualTo("unknown");
    }

    @Test
    void testGetIpAddr2() {
        // Setup
        final HttpServletRequest request = null;

        // Run the test
        final String result = IpUtils.getIpAddr(request);

        // Verify the results
        assertThat(result).isEqualTo("unknown");
    }

    @Test
    void testInternalIp1() {
        assertThat(IpUtils.internalIp("ip")).isFalse();
    }

    @Test
    void testTextToNumericFormatV4() {
        assertThat(IpUtils.textToNumericFormatV4("text")).isEqualTo("content".getBytes());
    }

    @Test
    void testGetHostIp() {
        assertThat(IpUtils.getHostIp()).isEqualTo("127.0.0.1");
    }

    @Test
    void testGetHostName() {
        assertThat(IpUtils.getHostName()).isEqualTo("未知");
    }

    @Test
    void testGetMultistageReverseProxyIp() {
        assertThat(IpUtils.getMultistageReverseProxyIp("ip")).isEqualTo("result");
    }

    @Test
    void testIsUnknown() {
        assertThat(IpUtils.isUnknown("checkString")).isFalse();
    }

    @Test
    void testIsIP() {
        assertThat(IpUtils.isIP("ip")).isFalse();
    }

    @Test
    void testIsIpWildCard() {
        assertThat(IpUtils.isIpWildCard("ip")).isFalse();
    }

    @Test
    void testIpIsInWildCardNoCheck() {
        assertThat(IpUtils.ipIsInWildCardNoCheck("ipWildCard", "ip")).isFalse();
    }

    @Test
    void testIsIPSegment() {
        assertThat(IpUtils.isIPSegment("ipSeg")).isFalse();
    }

    @Test
    void testIpIsInNetNoCheck() {
        assertThat(IpUtils.ipIsInNetNoCheck("iparea", "ip")).isFalse();
    }

    @Test
    void testIsMatchedIp() {
        assertThat(IpUtils.isMatchedIp("filter", "ip")).isFalse();
    }
}
