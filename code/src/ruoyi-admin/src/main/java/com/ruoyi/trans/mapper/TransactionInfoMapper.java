package com.ruoyi.trans.mapper;

import java.util.List;
import com.ruoyi.trans.domain.TransactionInfo;

/**
 * transMapper接口
 * 
 * @author z
 * @date 2023-12-26
 */
public interface TransactionInfoMapper 
{
    /**
     * 查询trans
     * 
     * @param fStreamId trans主键
     * @return trans
     */
    public TransactionInfo selectTransactionInfoByFStreamId(Long fStreamId);

    /**
     * 查询trans列表
     * 
     * @param transactionInfo trans
     * @return trans集合
     */
    public List<TransactionInfo> selectTransactionInfoList(TransactionInfo transactionInfo);

    /**
     * 新增trans
     * 
     * @param transactionInfo trans
     * @return 结果
     */
    public int insertTransactionInfo(TransactionInfo transactionInfo);

    /**
     * 修改trans
     * 
     * @param transactionInfo
     * @return 结果
     */
    public int updateTransactionInfo(TransactionInfo transactionInfo);

    /**
     * 删除trans
     * 
     * @param fStreamId trans主键
     * @return 结果
     */
    public int deleteTransactionInfoByFStreamId(Long fStreamId);

    /**
     * 批量删除trans
     * 
     * @param fStreamIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteTransactionInfoByFStreamIds(Long[] fStreamIds);
}
