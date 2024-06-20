package com.ruoyi.common.utils;

import com.ruoyi.common.core.domain.model.LoginUser;
import org.junit.jupiter.api.Test;

import java.util.Arrays;

import static org.assertj.core.api.Assertions.assertThat;

class SecurityUtilsTest {

    @Test
    void testGetUserId() {
        assertThat(SecurityUtils.getUserId()).isEqualTo(0L);
    }

    @Test
    void testGetDeptId() {
        assertThat(SecurityUtils.getDeptId()).isEqualTo(0L);
    }

    @Test
    void testGetUsername() {
        assertThat(SecurityUtils.getUsername()).isEqualTo("result");
    }

    @Test
    void testGetLoginUser() {
        // Setup
        // Run the test
        final LoginUser result = SecurityUtils.getLoginUser();

        // Verify the results
    }

    @Test
    void testGetAuthentication() {
        // Setup
        // Run the test
        final Authentication result = SecurityUtils.getAuthentication();

        // Verify the results
    }

    @Test
    void testEncryptPassword() {
        assertThat(SecurityUtils.encryptPassword("password")).isEqualTo("result");
    }

    @Test
    void testMatchesPassword() {
        assertThat(SecurityUtils.matchesPassword("rawPassword", "encodedPassword")).isFalse();
    }

    @Test
    void testIsAdmin() {
        assertThat(SecurityUtils.isAdmin(0L)).isFalse();
    }

    @Test
    void testHasPermi1() {
        assertThat(SecurityUtils.hasPermi("permission")).isFalse();
    }

    @Test
    void testHasPermi2() {
        assertThat(SecurityUtils.hasPermi(Arrays.asList("value"), "permission")).isFalse();
    }

    @Test
    void testHasRole1() {
        assertThat(SecurityUtils.hasRole("role")).isFalse();
    }

    @Test
    void testHasRole2() {
        assertThat(SecurityUtils.hasRole(Arrays.asList("value"), "role")).isFalse();
    }
}
