package com.ruoyi.framework.web.service;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;

class PermissionServiceTest {

    private PermissionService permissionServiceUnderTest;

    @BeforeEach
    void setUp() {
        permissionServiceUnderTest = new PermissionService();
    }

    @Test
    void testHasPermi() {
        assertThat(permissionServiceUnderTest.hasPermi("permission")).isFalse();
    }

    @Test
    void testLacksPermi() {
        assertThat(permissionServiceUnderTest.lacksPermi("permission")).isFalse();
    }

    @Test
    void testHasAnyPermi() {
        assertThat(permissionServiceUnderTest.hasAnyPermi("permissions")).isFalse();
    }

    @Test
    void testHasRole() {
        assertThat(permissionServiceUnderTest.hasRole("role")).isFalse();
    }

    @Test
    void testLacksRole() {
        assertThat(permissionServiceUnderTest.lacksRole("role")).isFalse();
    }

    @Test
    void testHasAnyRoles() {
        assertThat(permissionServiceUnderTest.hasAnyRoles("roles")).isFalse();
    }
}
