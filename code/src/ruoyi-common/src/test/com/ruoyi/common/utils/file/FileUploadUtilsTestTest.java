package com.ruoyi.common.utils.file;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThatThrownBy;

class FileUploadUtilsTestTest {

    private FileUploadUtilsTest fileUploadUtilsTestUnderTest;

    @BeforeEach
    void setUp() {
        fileUploadUtilsTestUnderTest = new FileUploadUtilsTest();
    }

    @Test
    void testTestSetDefaultBaseDir() {
        // Setup
        // Run the test
        fileUploadUtilsTestUnderTest.testSetDefaultBaseDir();

        // Verify the results
    }

    @Test
    void testTestGetDefaultBaseDir() {
        // Setup
        // Run the test
        fileUploadUtilsTestUnderTest.testGetDefaultBaseDir();

        // Verify the results
    }

    @Test
    void testTestUpload1() throws Exception {
        // Setup
        // Run the test
        fileUploadUtilsTestUnderTest.testUpload1();

        // Verify the results
    }

    @Test
    void testTestUpload1_ThrowsException() {
        // Setup
        // Run the test
        assertThatThrownBy(() -> fileUploadUtilsTestUnderTest.testUpload1()).isInstanceOf(Exception.class);
    }

    @Test
    void testTestUpload1_ThrowsIOException() {
        // Setup
        // Run the test
        fileUploadUtilsTestUnderTest.testUpload1_ThrowsIOException();

        // Verify the results
    }

    @Test
    void testTestUpload2() throws Exception {
        // Setup
        // Run the test
        fileUploadUtilsTestUnderTest.testUpload2();

        // Verify the results
    }

    @Test
    void testTestUpload2_ThrowsException() {
        // Setup
        // Run the test
        assertThatThrownBy(() -> fileUploadUtilsTestUnderTest.testUpload2()).isInstanceOf(Exception.class);
    }

    @Test
    void testTestUpload2_ThrowsIOException() {
        // Setup
        // Run the test
        fileUploadUtilsTestUnderTest.testUpload2_ThrowsIOException();

        // Verify the results
    }

    @Test
    void testTestUpload3() throws Exception {
        // Setup
        // Run the test
        fileUploadUtilsTestUnderTest.testUpload3();

        // Verify the results
    }

    @Test
    void testTestUpload3_ThrowsException() {
        // Setup
        // Run the test
        assertThatThrownBy(() -> fileUploadUtilsTestUnderTest.testUpload3()).isInstanceOf(Exception.class);
    }

    @Test
    void testTestUpload3_ThrowsFileSizeLimitExceededException() {
        // Setup
        // Run the test
        fileUploadUtilsTestUnderTest.testUpload3_ThrowsFileSizeLimitExceededException();

        // Verify the results
    }

    @Test
    void testTestUpload3_ThrowsIOException() {
        // Setup
        // Run the test
        fileUploadUtilsTestUnderTest.testUpload3_ThrowsIOException();

        // Verify the results
    }

    @Test
    void testTestUpload3_ThrowsFileNameLengthLimitExceededException() {
        // Setup
        // Run the test
        fileUploadUtilsTestUnderTest.testUpload3_ThrowsFileNameLengthLimitExceededException();

        // Verify the results
    }

    @Test
    void testTestUpload3_ThrowsInvalidExtensionException() {
        // Setup
        // Run the test
        fileUploadUtilsTestUnderTest.testUpload3_ThrowsInvalidExtensionException();

        // Verify the results
    }

    @Test
    void testTestExtractFilename() {
        // Setup
        // Run the test
        fileUploadUtilsTestUnderTest.testExtractFilename();

        // Verify the results
    }

    @Test
    void testTestGetAbsoluteFile() throws Exception {
        // Setup
        // Run the test
        fileUploadUtilsTestUnderTest.testGetAbsoluteFile();

        // Verify the results
    }

    @Test
    void testTestGetAbsoluteFile_ThrowsException() {
        // Setup
        // Run the test
        assertThatThrownBy(() -> fileUploadUtilsTestUnderTest.testGetAbsoluteFile()).isInstanceOf(Exception.class);
    }

    @Test
    void testTestGetAbsoluteFile_ThrowsIOException() {
        // Setup
        // Run the test
        fileUploadUtilsTestUnderTest.testGetAbsoluteFile_ThrowsIOException();

        // Verify the results
    }

    @Test
    void testTestGetPathFileName() throws Exception {
        // Setup
        // Run the test
        fileUploadUtilsTestUnderTest.testGetPathFileName();

        // Verify the results
    }

    @Test
    void testTestGetPathFileName_ThrowsException() {
        // Setup
        // Run the test
        assertThatThrownBy(() -> fileUploadUtilsTestUnderTest.testGetPathFileName()).isInstanceOf(Exception.class);
    }

    @Test
    void testTestAssertAllowed() throws Exception {
        // Setup
        // Run the test
        fileUploadUtilsTestUnderTest.testAssertAllowed();

        // Verify the results
    }

    @Test
    void testTestAssertAllowed_ThrowsException() {
        // Setup
        // Run the test
        assertThatThrownBy(() -> fileUploadUtilsTestUnderTest.testAssertAllowed()).isInstanceOf(Exception.class);
    }

    @Test
    void testTestAssertAllowed_ThrowsFileSizeLimitExceededException() {
        // Setup
        // Run the test
        fileUploadUtilsTestUnderTest.testAssertAllowed_ThrowsFileSizeLimitExceededException();

        // Verify the results
    }

    @Test
    void testTestAssertAllowed_ThrowsInvalidExtensionException() {
        // Setup
        // Run the test
        fileUploadUtilsTestUnderTest.testAssertAllowed_ThrowsInvalidExtensionException();

        // Verify the results
    }

    @Test
    void testTestIsAllowedExtension() {
        // Setup
        // Run the test
        fileUploadUtilsTestUnderTest.testIsAllowedExtension();

        // Verify the results
    }

    @Test
    void testTestGetExtension() {
        // Setup
        // Run the test
        fileUploadUtilsTestUnderTest.testGetExtension();

        // Verify the results
    }
}
