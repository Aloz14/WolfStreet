package com.ruoyi.common.utils.file;

import org.junit.jupiter.api.Test;

import java.io.File;

import static org.assertj.core.api.Assertions.assertThat;

class FileTypeUtilsTest {

    @Test
    void testGetFileType1() {
        // Setup
        final File file = new File("filename.txt");

        // Run the test
        final String result = FileTypeUtils.getFileType(file);

        // Verify the results
        assertThat(result).isEqualTo("result");
    }

    @Test
    void testGetFileType2() {
        assertThat(FileTypeUtils.getFileType("fileName")).isEqualTo("");
    }

    @Test
    void testGetFileExtendName() {
        assertThat(FileTypeUtils.getFileExtendName("content".getBytes())).isEqualTo("BMP");
    }
}
