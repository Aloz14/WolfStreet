package com.ruoyi.system.service.impl;

import com.ruoyi.common.core.domain.model.LoginUser;
import com.ruoyi.system.domain.SysUserOnline;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class SysUserOnlineServiceImplTest {

    private SysUserOnlineServiceImpl sysUserOnlineServiceImplUnderTest;

    @BeforeEach
    void setUp() throws Exception {
        sysUserOnlineServiceImplUnderTest = new SysUserOnlineServiceImpl();
    }

    @Test
    void testSelectOnlineByIpaddr() {
        // Setup
        final LoginUser user = null;

        // Run the test
        final SysUserOnline result = sysUserOnlineServiceImplUnderTest.selectOnlineByIpaddr("ipaddr", user);

        // Verify the results
    }

    @Test
    void testSelectOnlineByUserName() {
        // Setup
        final LoginUser user = null;

        // Run the test
        final SysUserOnline result = sysUserOnlineServiceImplUnderTest.selectOnlineByUserName("userName", user);

        // Verify the results
    }

    @Test
    void testSelectOnlineByInfo() {
        // Setup
        final LoginUser user = null;

        // Run the test
        final SysUserOnline result = sysUserOnlineServiceImplUnderTest.selectOnlineByInfo("ipaddr", "userName", user);

        // Verify the results
    }

    @Test
    void testLoginUserToUserOnline() {
        // Setup
        final LoginUser user = null;

        // Run the test
        final SysUserOnline result = sysUserOnlineServiceImplUnderTest.loginUserToUserOnline(user);

        // Verify the results
    }
}
