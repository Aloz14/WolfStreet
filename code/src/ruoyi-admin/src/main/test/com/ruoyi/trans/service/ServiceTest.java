package com.ruoyi.trans.service;

import com.ruoyi.fund.domain.FundInfo;
import com.ruoyi.fund.service.impl.FundInfoServiceImpl;
import com.ruoyi.trans.domain.TransactionInfo;
import com.ruoyi.trans.service.impl.TransactionInfoServiceImpl;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
public class ServiceTest {
    @Autowired
    private FundInfoServiceImpl fundInfoService;

    @Autowired
    private TransactionInfoServiceImpl transactionInfoService;

    @Test
    public void testInteract(){
        String fundID = "1";
        FundInfo fund = fundInfoService.selectFundInfoByFId(fundID);
        TransactionInfo trans = new TransactionInfo();
        trans.setfId(fund.getfId());
        trans.setfDealAmount(fund.getfSize());

        transactionInfoService.insertTransactionInfo(trans);

    }

}
