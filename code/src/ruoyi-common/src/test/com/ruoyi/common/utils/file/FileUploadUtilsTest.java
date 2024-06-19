package com.ruoyi.common.utils.file;

import com.ruoyi.common.exception.file.FileNameLengthLimitExceededException;
import com.ruoyi.common.exception.file.FileSizeLimitExceededException;
import com.ruoyi.common.exception.file.InvalidExtensionException;
import org.junit.jupiter.api.Test;

import java.io.File;
import java.io.IOException;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

class FileUploadUtilsTest {

    @Test
    void testSetDefaultBaseDir() {
        // Setup
        // Run the test
        FileUploadUtils.setDefaultBaseDir("defaultBaseDir");

        // Verify the results
    }

    @Test
    void testGetDefaultBaseDir() {
        assertThat(FileUploadUtils.getDefaultBaseDir()).isEqualTo("defaultBaseDir");
    }

    @Test
    void testUpload1() throws Exception {
        // Setup
        final MultipartFile file = null;

        // Run the test
        final String result = FileUploadUtils.upload(file);

        // Verify the results
        assertThat(result).isEqualTo("result");
    }

    @Test
    void testUpload1_ThrowsIOException() {
        // Setup
        final MultipartFile file = null;

        // Run the test
        assertThatThrownBy(() -> FileUploadUtils.upload(file)).isInstanceOf(IOException.class);
    }

    @Test
    void testUpload2() throws Exception {
        // Setup
        final MultipartFile file = null;

        // Run the test
        final String result = FileUploadUtils.upload("baseDir", file);

        // Verify the results
        assertThat(result).isEqualTo("result");
    }

    @Test
    void testUpload2_ThrowsIOException() {
        // Setup
        final MultipartFile file = null;

        // Run the test
        assertThatThrownBy(() -> FileUploadUtils.upload("baseDir", file)).isInstanceOf(IOException.class);
    }

    @Test
    void testUpload3() throws Exception {
        // Setup
        final MultipartFile file = null;

        // Run the test
        final String result = FileUploadUtils.upload("baseDir", file, new String[]{"allowedExtension"});

        // Verify the results
        assertThat(result).isEqualTo("result");
    }

    @Test
    void testUpload3_ThrowsFileSizeLimitExceededException() {
        // Setup
        final MultipartFile file = null;

        // Run the test
        assertThatThrownBy(
                () -> FileUploadUtils.upload("baseDir", file, new String[]{"allowedExtension"})).isInstanceOf(
                FileSizeLimitExceededException.class);
    }

    @Test
    void testUpload3_ThrowsIOException() {
        // Setup
        final MultipartFile file = null;

        // Run the test
        assertThatThrownBy(
                () -> FileUploadUtils.upload("baseDir", file, new String[]{"allowedExtension"})).isInstanceOf(
                IOException.class);
    }

    @Test
    void testUpload3_ThrowsFileNameLengthLimitExceededException() {
        // Setup
        final MultipartFile file = null;

        // Run the test
        assertThatThrownBy(
                () -> FileUploadUtils.upload("baseDir", file, new String[]{"allowedExtension"})).isInstanceOf(
                FileNameLengthLimitExceededException.class);
    }

    @Test
    void testUpload3_ThrowsInvalidExtensionException() {
        // Setup
        final MultipartFile file = null;

        // Run the test
        assertThatThrownBy(
                () -> FileUploadUtils.upload("baseDir", file, new String[]{"allowedExtension"})).isInstanceOf(
                InvalidExtensionException.class);
    }

    @Test
    void testExtractFilename() {
        // Setup
        final MultipartFile file = null;

        // Run the test
        final String result = FileUploadUtils.extractFilename(file);

        // Verify the results
        assertThat(result).isEqualTo("result");
    }

    @Test
    void testGetAbsoluteFile() throws Exception {
        // Setup
        final File expectedResult = new File("filename.txt");

        // Run the test
        final File result = FileUploadUtils.getAbsoluteFile("uploadDir", "fileName");

        // Verify the results
        assertThat(result).isEqualTo(expectedResult);
    }

    @Test
    void testGetAbsoluteFile_ThrowsIOException() {
        // Setup
        // Run the test
        assertThatThrownBy(() -> FileUploadUtils.getAbsoluteFile("uploadDir", "fileName")).isInstanceOf(
                IOException.class);
    }

    @Test
    void testGetPathFileName() throws Exception {
        assertThat(FileUploadUtils.getPathFileName("uploadDir", "fileName")).isEqualTo("result");
        assertThatThrownBy(() -> FileUploadUtils.getPathFileName("uploadDir", "fileName")).isInstanceOf(
                IOException.class);
    }

    @Test
    void testAssertAllowed() throws Exception {
        // Setup
        final MultipartFile file = null;

        // Run the test
        FileUploadUtils.assertAllowed(file, new String[]{"allowedExtension"});

        // Verify the results
    }

    @Test
    void testAssertAllowed_ThrowsFileSizeLimitExceededException() {
        // Setup
        final MultipartFile file = null;

        // Run the test
        assertThatThrownBy(() -> FileUploadUtils.assertAllowed(file, new String[]{"allowedExtension"})).isInstanceOf(
                FileSizeLimitExceededException.class);
    }

    @Test
    void testAssertAllowed_ThrowsInvalidExtensionException() {
        // Setup
        final MultipartFile file = null;

        // Run the test
        assertThatThrownBy(() -> FileUploadUtils.assertAllowed(file, new String[]{"allowedExtension"})).isInstanceOf(
                InvalidExtensionException.class);
    }

    @Test
    void testIsAllowedExtension() {
        assertThat(FileUploadUtils.isAllowedExtension("extension", new String[]{"allowedExtension"})).isFalse();
    }

    @Test
    void testGetExtension() {
        // Setup
        final MultipartFile file = null;

        // Run the test
        final String result = FileUploadUtils.getExtension(file);

        // Verify the results
        assertThat(result).isEqualTo("result");
    }
}
