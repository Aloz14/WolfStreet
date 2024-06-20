package com.ruoyi.common.utils.file;

import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;

class MimeTypeUtilsTest {

    @Test
    void testGetExtension() {
        assertThat(MimeTypeUtils.getExtension("prefix")).isEqualTo("");
    }
}
