package com.ruoyi.common.utils;

import org.junit.jupiter.api.Test;

import java.math.BigDecimal;
import java.util.*;

import static org.assertj.core.api.Assertions.assertThat;

class StringUtilsTest {

    @Test
    void testNvl() {
        assertThat(StringUtils.nvl("value", "defaultValue")).isEqualTo("result");
    }

    @Test
    void testIsEmpty1() {
        assertThat(StringUtils.isEmpty(Arrays.asList("value"))).isFalse();
    }

    @Test
    void testIsNotEmpty1() {
        assertThat(StringUtils.isNotEmpty(Arrays.asList("value"))).isFalse();
    }

    @Test
    void testIsEmpty2() {
        assertThat(StringUtils.isEmpty(new Object[]{"objects"})).isFalse();
    }

    @Test
    void testIsNotEmpty2() {
        assertThat(StringUtils.isNotEmpty(new Object[]{"objects"})).isFalse();
    }

    @Test
    void testIsEmpty3() {
        // Setup
        final Map<?, ?> map = new HashMap<>();

        // Run the test
        final boolean result = StringUtils.isEmpty(map);

        // Verify the results
        assertThat(result).isFalse();
    }

    @Test
    void testIsNotEmpty3() {
        // Setup
        final Map<?, ?> map = new HashMap<>();

        // Run the test
        final boolean result = StringUtils.isNotEmpty(map);

        // Verify the results
        assertThat(result).isFalse();
    }

    @Test
    void testIsEmpty4() {
        assertThat(StringUtils.isEmpty("str")).isFalse();
    }

    @Test
    void testIsNotEmpty4() {
        assertThat(StringUtils.isNotEmpty("str")).isFalse();
    }

    @Test
    void testIsNull() {
        assertThat(StringUtils.isNull("object")).isFalse();
    }

    @Test
    void testIsNotNull() {
        assertThat(StringUtils.isNotNull("object")).isFalse();
    }

    @Test
    void testIsArray() {
        assertThat(StringUtils.isArray("object")).isFalse();
    }

    @Test
    void testTrim() {
        assertThat(StringUtils.trim("str")).isEqualTo("result");
    }

    @Test
    void testSubstring1() {
        assertThat(StringUtils.substring("str", 0)).isEqualTo("");
    }

    @Test
    void testSubstring2() {
        assertThat(StringUtils.substring("str", 0, 0)).isEqualTo("");
    }

    @Test
    void testHasText() {
        assertThat(StringUtils.hasText("str")).isFalse();
    }

    @Test
    void testFormat() {
        assertThat(StringUtils.format("template", "params")).isEqualTo("template");
    }

    @Test
    void testIshttp() {
        assertThat(StringUtils.ishttp("link")).isFalse();
    }

    @Test
    void testStr2Set() {
        assertThat(StringUtils.str2Set("str", "sep")).isEqualTo(new HashSet<>(Arrays.asList("value")));
        assertThat(StringUtils.str2Set("str", "sep")).isEqualTo(Collections.emptySet());
    }

    @Test
    void testStr2List() {
        assertThat(StringUtils.str2List("str", "sep", false, false)).isEqualTo(Arrays.asList("value"));
        assertThat(StringUtils.str2List("str", "sep", false, false)).isEqualTo(Collections.emptyList());
    }

    @Test
    void testContainsAny() {
        assertThat(StringUtils.containsAny(Arrays.asList("value"), "array")).isFalse();
    }

    @Test
    void testContainsAnyIgnoreCase() {
        assertThat(StringUtils.containsAnyIgnoreCase("cs", "searchCharSequences")).isFalse();
    }

    @Test
    void testToUnderScoreCase() {
        assertThat(StringUtils.toUnderScoreCase("str")).isEqualTo("result");
    }

    @Test
    void testInStringIgnoreCase() {
        assertThat(StringUtils.inStringIgnoreCase("str", "strs")).isFalse();
    }

    @Test
    void testConvertToCamelCase() {
        assertThat(StringUtils.convertToCamelCase("name")).isEqualTo("");
    }

    @Test
    void testToCamelCase() {
        assertThat(StringUtils.toCamelCase("s")).isEqualTo("s");
    }

    @Test
    void testMatches() {
        assertThat(StringUtils.matches("str", Arrays.asList("value"))).isFalse();
    }

    @Test
    void testIsMatch() {
        assertThat(StringUtils.isMatch("pattern", "url")).isFalse();
    }

    @Test
    void testCast() {
        assertThat(StringUtils.cast("obj")).isEqualTo("result");
    }

    @Test
    void testPadl1() {
        assertThat(StringUtils.padl(new BigDecimal("0.00"), 0)).isEqualTo("result");
    }

    @Test
    void testPadl2() {
        assertThat(StringUtils.padl("s", 0, 'a')).isEqualTo("result");
    }
}
