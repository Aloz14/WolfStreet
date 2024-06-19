package com.ruoyi.framework.config;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;

import javax.sql.DataSource;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.MockitoAnnotations.initMocks;

class MyBatisConfigTest {

    @Mock
    private Environment mockEnv;

    @InjectMocks
    private MyBatisConfig myBatisConfigUnderTest;

    @BeforeEach
    void setUp() {
        initMocks(this);
    }

    @Test
    void testSetTypeAliasesPackage() {
        assertThat(MyBatisConfig.setTypeAliasesPackage("typeAliasesPackage")).isEqualTo("typeAliasesPackage");
    }

    @Test
    void testResolveMapperLocations() {
        // Setup
        // Run the test
        final Resource[] result = myBatisConfigUnderTest.resolveMapperLocations(new String[]{"mapperLocations"});

        // Verify the results
    }

    @Test
    void testSqlSessionFactory() throws Exception {
        // Setup
        final DataSource dataSource = null;

        // Run the test
        final SqlSessionFactory result = myBatisConfigUnderTest.sqlSessionFactory(dataSource);

        // Verify the results
    }

    @Test
    void testSqlSessionFactory_ThrowsException() {
        // Setup
        final DataSource dataSource = null;

        // Run the test
        assertThatThrownBy(() -> myBatisConfigUnderTest.sqlSessionFactory(dataSource)).isInstanceOf(Exception.class);
    }
}
