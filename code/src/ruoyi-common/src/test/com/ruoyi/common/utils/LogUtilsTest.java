package com.ruoyi.common.utils;

import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;

class LogUtilsTest {

    @Test
    void testGetBlock() {
        assertThat(LogUtils.getBlock("msg")).isEqualTo("result");
    }
}
