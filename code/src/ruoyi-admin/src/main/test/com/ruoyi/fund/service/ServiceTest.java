package com.ruoyi.fund.service;

import com.ruoyi.fund.domain.FundInfo;
import com.ruoyi.fund.service.impl.FundInfoServiceImpl;
import org.hibernate.validator.internal.constraintvalidators.bv.AssertFalseValidator;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;

import java.util.Date;
import java.util.List;

@SpringBootTest
public class ServiceTest {
    @Autowired
    private FundInfoServiceImpl fundInfoService;

    @Test
    public void testGetList() {
        // Not exist
        FundInfo fundInfo1 = new FundInfo();
        fundInfo1.setfId("001");
        fundInfo1.setfName("Test Fund 1");
        fundInfo1.setfType(1L);
        fundInfo1.setfSize(100000L);
        fundInfo1.setfMonitor("John Doe");
        fundInfo1.setfStartTime(new Date());
        fundInfo1.setfCompany("Company A");
        fundInfo1.setfLevel(3L);
        fundInfo1.setfRiskLevel(2L);
        fundInfo1.setfOverview("This is a test fund 1.");
        fundInfo1.setfStatus(1L);

        // 空值情况
        FundInfo fundInfo2 = new FundInfo();
        fundInfo2.setfId("002");
        fundInfo2.setfName(""); // 空值
        fundInfo2.setfType(null); // 空值
        fundInfo2.setfSize(null); // 空值
        fundInfo2.setfMonitor("Jane Doe");
        fundInfo2.setfStartTime(new Date());
        fundInfo2.setfCompany("Company B");
        fundInfo2.setfLevel(null); // 空值
        fundInfo2.setfRiskLevel(1L);
        fundInfo2.setfOverview(""); // 空值
        fundInfo2.setfStatus(null); // 空值

        // 边界情况
        FundInfo fundInfo3 = new FundInfo();
        fundInfo3.setfId("003");
        fundInfo3.setfName("Test Fund 3");
        fundInfo3.setfType(Long.MAX_VALUE); // 最大值
        fundInfo3.setfSize(Long.MAX_VALUE); // 最大值
        fundInfo3.setfMonitor("Jack Smith");
        fundInfo3.setfStartTime(new Date());
        fundInfo3.setfCompany("Company C");
        fundInfo3.setfLevel(0L); // 最小值
        fundInfo3.setfRiskLevel(2L);
        fundInfo3.setfOverview("This is a test fund 3.");
        fundInfo3.setfStatus(2L); // 其他值

        // 根据等级筛选
        FundInfo fundInfo4 = new FundInfo();
        fundInfo4.setfRiskLevel(1L);

        String[] ids = {"001", "002", "003", "004", "005", "006"};
        fundInfoService.selectFundInfoByFId("001");
        fundInfoService.deleteFundInfoByFId("001");
        fundInfoService.deleteFundInfoByFIds(ids);
        fundInfoService.updateFundInfo(fundInfo3);


        List<FundInfo> result1 = fundInfoService.selectFundInfoList(fundInfo1);
        List<FundInfo> result2 = fundInfoService.selectFundInfoList(fundInfo2);
        List<FundInfo> result3 = fundInfoService.selectFundInfoList(fundInfo3);
        List<FundInfo> result4 = fundInfoService.selectFundInfoList(fundInfo4);

        assertEquals(result1.isEmpty(),true);
        assertEquals(result2.isEmpty(),true);
        assertEquals(result3.isEmpty(),true);
        assertEquals(result4.isEmpty(),true);
    }
}
