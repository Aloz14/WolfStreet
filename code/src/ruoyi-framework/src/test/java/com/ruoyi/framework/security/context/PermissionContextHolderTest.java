package com.ruoyi.framework.security.context;

import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;

class PermissionContextHolderTest {

    @Test
    void testSetContext() {
        // Setup
        // Run the test
        PermissionContextHolder.setContext("permission");

        // Verify the results
    }

    @Test
    void testGetContext() {
        assertThat(PermissionContextHolder.getContext()).isEqualTo("result");
    }
}
