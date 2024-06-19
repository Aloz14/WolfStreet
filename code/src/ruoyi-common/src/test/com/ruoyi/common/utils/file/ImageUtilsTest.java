package com.ruoyi.common.utils.file;

import org.junit.jupiter.api.Test;

import java.io.InputStream;

import static org.assertj.core.api.Assertions.assertThat;

class ImageUtilsTest {

    @Test
    void testGetImage() {
        assertThat(ImageUtils.getImage("imagePath")).isEqualTo("content".getBytes());
    }

    @Test
    void testGetFile() {
        // Setup
        // Run the test
        final InputStream result = ImageUtils.getFile("imagePath");

        // Verify the results
    }

    @Test
    void testReadFile() {
        assertThat(ImageUtils.readFile("imagePath")).isEqualTo("content".getBytes());
    }
}
