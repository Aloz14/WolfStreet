package com.ruoyi.common.utils;

import com.ruoyi.common.core.domain.entity.SysDictData;
import org.junit.jupiter.api.Test;

import java.util.Arrays;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;

class DictUtilsTest {

    @Test
    void testSetDictCache() {
        // Setup
        final SysDictData sysDictData = new SysDictData();
        sysDictData.setDictCode(0L);
        sysDictData.setDictSort(0L);
        sysDictData.setDictLabel("dictLabel");
        sysDictData.setDictValue("dictValue");
        sysDictData.setDictType("dictType");
        final List<SysDictData> dictDatas = Arrays.asList(sysDictData);

        // Run the test
        DictUtils.setDictCache("key", dictDatas);

        // Verify the results
    }

    @Test
    void testGetDictCache() {
        // Setup
        // Run the test
        final List<SysDictData> result = DictUtils.getDictCache("key");

        // Verify the results
    }

    @Test
    void testGetDictLabel1() {
        assertThat(DictUtils.getDictLabel("dictType", "dictValue")).isEqualTo("result");
    }

    @Test
    void testGetDictValue1() {
        assertThat(DictUtils.getDictValue("dictType", "dictLabel")).isEqualTo("result");
    }

    @Test
    void testGetDictLabel2() {
        assertThat(DictUtils.getDictLabel("dictType", "dictValue", "separator")).isEqualTo("dictLabel");
    }

    @Test
    void testGetDictValue2() {
        assertThat(DictUtils.getDictValue("dictType", "dictLabel", "separator")).isEqualTo("dictValue");
    }

    @Test
    void testRemoveDictCache() {
        // Setup
        // Run the test
        DictUtils.removeDictCache("key");

        // Verify the results
    }

    @Test
    void testClearDictCache() {
        // Setup
        // Run the test
        DictUtils.clearDictCache();

        // Verify the results
    }

    @Test
    void testGetCacheKey() {
        assertThat(DictUtils.getCacheKey("configKey")).isEqualTo("result");
    }
}
