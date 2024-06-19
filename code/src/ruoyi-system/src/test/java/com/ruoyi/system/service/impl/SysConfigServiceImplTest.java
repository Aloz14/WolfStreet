package com.ruoyi.system.service.impl;

import com.ruoyi.system.domain.SysConfig;
import com.ruoyi.system.mapper.SysConfigMapper;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import static org.mockito.MockitoAnnotations.initMocks;

class SysConfigServiceImplTest {

    @Mock
    private SysConfigMapper mockConfigMapper;
    @Mock
    private RedisCache mockRedisCache;

    @InjectMocks
    private SysConfigServiceImpl sysConfigServiceImplUnderTest;

    @BeforeEach
    void setUp() {
        initMocks(this);
    }

    @Test
    void testInit() {
        // Setup
        // Configure SysConfigMapper.selectConfigList(...).
        final SysConfig sysConfig = new SysConfig();
        sysConfig.setConfigId(0L);
        sysConfig.setConfigName("configName");
        sysConfig.setConfigKey("configKey");
        sysConfig.setConfigValue("configValue");
        sysConfig.setConfigType("configType");
        final List<SysConfig> sysConfigs = Arrays.asList(sysConfig);
        when(mockConfigMapper.selectConfigList(any(SysConfig.class))).thenReturn(sysConfigs);

        // Run the test
        sysConfigServiceImplUnderTest.init();

        // Verify the results
    }

    @Test
    void testInit_SysConfigMapperReturnsNoItems() {
        // Setup
        when(mockConfigMapper.selectConfigList(any(SysConfig.class))).thenReturn(Collections.emptyList());

        // Run the test
        sysConfigServiceImplUnderTest.init();

        // Verify the results
    }

    @Test
    void testSelectConfigById() {
        // Setup
        // Configure SysConfigMapper.selectConfig(...).
        final SysConfig sysConfig = new SysConfig();
        sysConfig.setConfigId(0L);
        sysConfig.setConfigName("configName");
        sysConfig.setConfigKey("configKey");
        sysConfig.setConfigValue("configValue");
        sysConfig.setConfigType("configType");
        when(mockConfigMapper.selectConfig(any(SysConfig.class))).thenReturn(sysConfig);

        // Run the test
        final SysConfig result = sysConfigServiceImplUnderTest.selectConfigById(0L);

        // Verify the results
    }

    @Test
    void testSelectConfigByKey() {
        // Setup
        // Configure SysConfigMapper.selectConfig(...).
        final SysConfig sysConfig = new SysConfig();
        sysConfig.setConfigId(0L);
        sysConfig.setConfigName("configName");
        sysConfig.setConfigKey("configKey");
        sysConfig.setConfigValue("configValue");
        sysConfig.setConfigType("configType");
        when(mockConfigMapper.selectConfig(any(SysConfig.class))).thenReturn(sysConfig);

        // Run the test
        final String result = sysConfigServiceImplUnderTest.selectConfigByKey("configKey");

        // Verify the results
        assertThat(result).isEqualTo("configValue");
    }

    @Test
    void testSelectCaptchaEnabled() {
        // Setup
        // Configure SysConfigMapper.selectConfig(...).
        final SysConfig sysConfig = new SysConfig();
        sysConfig.setConfigId(0L);
        sysConfig.setConfigName("configName");
        sysConfig.setConfigKey("configKey");
        sysConfig.setConfigValue("configValue");
        sysConfig.setConfigType("configType");
        when(mockConfigMapper.selectConfig(any(SysConfig.class))).thenReturn(sysConfig);

        // Run the test
        final boolean result = sysConfigServiceImplUnderTest.selectCaptchaEnabled();

        // Verify the results
        assertThat(result).isFalse();
    }

    @Test
    void testSelectConfigList() {
        // Setup
        final SysConfig config = new SysConfig();
        config.setConfigId(0L);
        config.setConfigName("configName");
        config.setConfigKey("configKey");
        config.setConfigValue("configValue");
        config.setConfigType("configType");

        // Configure SysConfigMapper.selectConfigList(...).
        final SysConfig sysConfig = new SysConfig();
        sysConfig.setConfigId(0L);
        sysConfig.setConfigName("configName");
        sysConfig.setConfigKey("configKey");
        sysConfig.setConfigValue("configValue");
        sysConfig.setConfigType("configType");
        final List<SysConfig> sysConfigs = Arrays.asList(sysConfig);
        when(mockConfigMapper.selectConfigList(any(SysConfig.class))).thenReturn(sysConfigs);

        // Run the test
        final List<SysConfig> result = sysConfigServiceImplUnderTest.selectConfigList(config);

        // Verify the results
    }

    @Test
    void testSelectConfigList_SysConfigMapperReturnsNoItems() {
        // Setup
        final SysConfig config = new SysConfig();
        config.setConfigId(0L);
        config.setConfigName("configName");
        config.setConfigKey("configKey");
        config.setConfigValue("configValue");
        config.setConfigType("configType");

        when(mockConfigMapper.selectConfigList(any(SysConfig.class))).thenReturn(Collections.emptyList());

        // Run the test
        final List<SysConfig> result = sysConfigServiceImplUnderTest.selectConfigList(config);

        // Verify the results
        assertThat(result).isEqualTo(Collections.emptyList());
    }

    @Test
    void testInsertConfig() {
        // Setup
        final SysConfig config = new SysConfig();
        config.setConfigId(0L);
        config.setConfigName("configName");
        config.setConfigKey("configKey");
        config.setConfigValue("configValue");
        config.setConfigType("configType");

        when(mockConfigMapper.insertConfig(any(SysConfig.class))).thenReturn(0);

        // Run the test
        final int result = sysConfigServiceImplUnderTest.insertConfig(config);

        // Verify the results
        assertThat(result).isEqualTo(0);
    }

    @Test
    void testUpdateConfig() {
        // Setup
        final SysConfig config = new SysConfig();
        config.setConfigId(0L);
        config.setConfigName("configName");
        config.setConfigKey("configKey");
        config.setConfigValue("configValue");
        config.setConfigType("configType");

        // Configure SysConfigMapper.selectConfigById(...).
        final SysConfig sysConfig = new SysConfig();
        sysConfig.setConfigId(0L);
        sysConfig.setConfigName("configName");
        sysConfig.setConfigKey("configKey");
        sysConfig.setConfigValue("configValue");
        sysConfig.setConfigType("configType");
        when(mockConfigMapper.selectConfigById(0L)).thenReturn(sysConfig);

        when(mockConfigMapper.updateConfig(any(SysConfig.class))).thenReturn(0);

        // Run the test
        final int result = sysConfigServiceImplUnderTest.updateConfig(config);

        // Verify the results
        assertThat(result).isEqualTo(0);
    }

    @Test
    void testDeleteConfigByIds() {
        // Setup
        // Configure SysConfigMapper.selectConfig(...).
        final SysConfig sysConfig = new SysConfig();
        sysConfig.setConfigId(0L);
        sysConfig.setConfigName("configName");
        sysConfig.setConfigKey("configKey");
        sysConfig.setConfigValue("configValue");
        sysConfig.setConfigType("configType");
        when(mockConfigMapper.selectConfig(any(SysConfig.class))).thenReturn(sysConfig);

        // Run the test
        sysConfigServiceImplUnderTest.deleteConfigByIds(new Long[]{0L});

        // Verify the results
        verify(mockConfigMapper).deleteConfigById(0L);
    }

    @Test
    void testLoadingConfigCache() {
        // Setup
        // Configure SysConfigMapper.selectConfigList(...).
        final SysConfig sysConfig = new SysConfig();
        sysConfig.setConfigId(0L);
        sysConfig.setConfigName("configName");
        sysConfig.setConfigKey("configKey");
        sysConfig.setConfigValue("configValue");
        sysConfig.setConfigType("configType");
        final List<SysConfig> sysConfigs = Arrays.asList(sysConfig);
        when(mockConfigMapper.selectConfigList(any(SysConfig.class))).thenReturn(sysConfigs);

        // Run the test
        sysConfigServiceImplUnderTest.loadingConfigCache();

        // Verify the results
    }

    @Test
    void testLoadingConfigCache_SysConfigMapperReturnsNoItems() {
        // Setup
        when(mockConfigMapper.selectConfigList(any(SysConfig.class))).thenReturn(Collections.emptyList());

        // Run the test
        sysConfigServiceImplUnderTest.loadingConfigCache();

        // Verify the results
    }

    @Test
    void testClearConfigCache() {
        // Setup
        // Run the test
        sysConfigServiceImplUnderTest.clearConfigCache();

        // Verify the results
    }

    @Test
    void testResetConfigCache() {
        // Setup
        // Configure SysConfigMapper.selectConfigList(...).
        final SysConfig sysConfig = new SysConfig();
        sysConfig.setConfigId(0L);
        sysConfig.setConfigName("configName");
        sysConfig.setConfigKey("configKey");
        sysConfig.setConfigValue("configValue");
        sysConfig.setConfigType("configType");
        final List<SysConfig> sysConfigs = Arrays.asList(sysConfig);
        when(mockConfigMapper.selectConfigList(any(SysConfig.class))).thenReturn(sysConfigs);

        // Run the test
        sysConfigServiceImplUnderTest.resetConfigCache();

        // Verify the results
    }

    @Test
    void testResetConfigCache_SysConfigMapperReturnsNoItems() {
        // Setup
        when(mockConfigMapper.selectConfigList(any(SysConfig.class))).thenReturn(Collections.emptyList());

        // Run the test
        sysConfigServiceImplUnderTest.resetConfigCache();

        // Verify the results
    }

    @Test
    void testCheckConfigKeyUnique() {
        // Setup
        final SysConfig config = new SysConfig();
        config.setConfigId(0L);
        config.setConfigName("configName");
        config.setConfigKey("configKey");
        config.setConfigValue("configValue");
        config.setConfigType("configType");

        // Configure SysConfigMapper.checkConfigKeyUnique(...).
        final SysConfig sysConfig = new SysConfig();
        sysConfig.setConfigId(0L);
        sysConfig.setConfigName("configName");
        sysConfig.setConfigKey("configKey");
        sysConfig.setConfigValue("configValue");
        sysConfig.setConfigType("configType");
        when(mockConfigMapper.checkConfigKeyUnique("configKey")).thenReturn(sysConfig);

        // Run the test
        final boolean result = sysConfigServiceImplUnderTest.checkConfigKeyUnique(config);

        // Verify the results
        assertThat(result).isFalse();
    }
}
