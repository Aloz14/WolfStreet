package com.ruoyi.fund.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.fund.mapper.FundInfoMapper;
import com.ruoyi.fund.domain.FundInfo;
import com.ruoyi.fund.service.IFundInfoService;

/**
 * 基金管理Service业务层处理
 * 
 * @author ruoyi
 * @date 2023-12-23
 */
@Service
public class FundInfoServiceImpl implements IFundInfoService 
{
    @Autowired
    private FundInfoMapper fundInfoMapper;

    /**
     * 查询基金管理
     * 
     * @param fId 基金管理主键
     * @return 基金管理
     */
    @Override
    public FundInfo selectFundInfoByFId(String fId)
    {
        return fundInfoMapper.selectFundInfoByFId(fId);
    }

    /**
     * 查询基金管理列表
     * 
     * @param fundInfo 基金管理
     * @return 基金管理
     */
    @Override
    public List<FundInfo> selectFundInfoList(FundInfo fundInfo)
    {
        return fundInfoMapper.selectFundInfoList(fundInfo);
    }

    /**
     * 新增基金管理
     * 
     * @param fundInfo 基金管理
     * @return 结果
     */
    @Override
    public int insertFundInfo(FundInfo fundInfo)
    {
        return fundInfoMapper.insertFundInfo(fundInfo);
    }

    /**
     * 修改基金管理
     * 
     * @param fundInfo 基金管理
     * @return 结果
     */
    @Override
    public int updateFundInfo(FundInfo fundInfo)
    {
        return fundInfoMapper.updateFundInfo(fundInfo);
    }

    /**
     * 批量删除基金管理
     * 
     * @param fIds 需要删除的基金管理主键
     * @return 结果
     */
    @Override
    public int deleteFundInfoByFIds(String[] fIds)
    {
        return fundInfoMapper.deleteFundInfoByFIds(fIds);
    }

    /**
     * 删除基金管理信息
     * 
     * @param fId 基金管理主键
     * @return 结果
     */
    @Override
    public int deleteFundInfoByFId(String fId)
    {
        return fundInfoMapper.deleteFundInfoByFId(fId);
    }
}
