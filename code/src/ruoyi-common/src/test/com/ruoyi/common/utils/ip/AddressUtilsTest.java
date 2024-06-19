package com.ruoyi.common.utils.ip;

import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;

class AddressUtilsTest {

    @Test
    void testGetRealAddressByIP() {
        assertThat(AddressUtils.getRealAddressByIP("ip")).isEqualTo("XX XX");
    }
}
