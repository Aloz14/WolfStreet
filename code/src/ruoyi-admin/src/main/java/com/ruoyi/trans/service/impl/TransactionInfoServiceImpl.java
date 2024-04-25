package com.ruoyi.trans.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.trans.mapper.TransactionInfoMapper;
import com.ruoyi.trans.domain.TransactionInfo;
import com.ruoyi.trans.service.ITransactionInfoService;

/**
 * transService业务层处理
 * 
 * @author z
 * @date 2023-12-26
 */
@Service
public class TransactionInfoServiceImpl implements ITransactionInfoService 
{
    @Autowired
    private TransactionInfoMapper transactionInfoMapper;

    /**
     * 查询trans
     * 
     * @param fStreamId trans主键
     * @return trans
     */
    @Override
    public TransactionInfo selectTransactionInfoByFStreamId(Long fStreamId)
    {
        return transactionInfoMapper.selectTransactionInfoByFStreamId(fStreamId);
    }

    /**
     * 查询trans列表
     * 
     * @param transactionInfo trans
     * @return trans
     */
    @Override
    public List<TransactionInfo> selectTransactionInfoList(TransactionInfo transactionInfo)
    {
        return transactionInfoMapper.selectTransactionInfoList(transactionInfo);
    }

    /**
     * 新增trans
     * 
     * @param transactionInfo trans
     * @return 结果
     */
    @Override
    public int insertTransactionInfo(TransactionInfo transactionInfo)
    {
        return transactionInfoMapper.insertTransactionInfo(transactionInfo);
    }

    /**
     * 修改trans
     *
     * @param
     * @param transactionInfo
     * @return 结果
     */
    @Override
    public int updateTransactionInfo(TransactionInfo transactionInfo)
    {
        return transactionInfoMapper.updateTransactionInfo(transactionInfo);
    }

    /**
     * 批量删除trans
     * 
     * @param fStreamIds 需要删除的trans主键
     * @return 结果
     */
    @Override
    public int deleteTransactionInfoByFStreamIds(Long[] fStreamIds)
    {
        return transactionInfoMapper.deleteTransactionInfoByFStreamIds(fStreamIds);
    }

    /**
     * 删除trans信息
     * 
     * @param fStreamId trans主键
     * @return 结果
     */
    @Override
    public int deleteTransactionInfoByFStreamId(Long fStreamId)
    {
        return transactionInfoMapper.deleteTransactionInfoByFStreamId(fStreamId);
    }
}
