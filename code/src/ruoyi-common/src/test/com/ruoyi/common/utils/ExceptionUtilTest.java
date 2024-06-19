package com.ruoyi.common.utils;

import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;

class ExceptionUtilTest {

    @Test
    void testGetExceptionMessage() {
        assertThat(ExceptionUtil.getExceptionMessage(new Exception("message"))).isEqualTo("result");
    }

    @Test
    void testGetRootErrorMessage() {
        assertThat(ExceptionUtil.getRootErrorMessage(new Exception("message"))).isEqualTo("");
    }
}
