package com.ruoyi.fund.mapper;

import java.util.List;
import com.ruoyi.fund.domain.FundInfo;

/**
 * 基金管理Mapper接口
 * 
 * @author ruoyi
 * @date 2023-12-23
 */
public interface FundInfoMapper 
{
    /**
     * 查询基金管理
     * 
     * @param fId 基金管理主键
     * @return 基金管理
     */
    public FundInfo selectFundInfoByFId(String fId);

    /**
     * 查询基金管理列表
     * 
     * @param fundInfo 基金管理
     * @return 基金管理集合
     */
    public List<FundInfo> selectFundInfoList(FundInfo fundInfo);

    /**
     * 新增基金管理
     * 
     * @param fundInfo 基金管理
     * @return 结果
     */
    public int insertFundInfo(FundInfo fundInfo);

    /**
     * 修改基金管理
     * 
     * @param fundInfo 基金管理
     * @return 结果
     */
    public int updateFundInfo(FundInfo fundInfo);

    /**
     * 删除基金管理
     * 
     * @param fId 基金管理主键
     * @return 结果
     */
    public int deleteFundInfoByFId(String fId);

    /**
     * 批量删除基金管理
     * 
     * @param fIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteFundInfoByFIds(String[] fIds);
}
