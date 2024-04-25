package com.ruoyi.card.service;

import java.util.List;
import com.ruoyi.card.domain.UserCard;

/**
 * 银行卡管理Service接口
 * 
 * @author ruoyi
 * @date 2023-12-26
 */
public interface IUserCardService 
{
    /**
     * 查询银行卡管理
     * 
     * @param cardId 银行卡管理主键
     * @return 银行卡管理
     */
    public UserCard selectUserCardByCardId(String cardId);

    /**
     * 查询银行卡管理列表
     * 
     * @param userCard 银行卡管理
     * @return 银行卡管理集合
     */
    public List<UserCard> selectUserCardList(UserCard userCard);

    /**
     * 新增银行卡管理
     * 
     * @param userCard 银行卡管理
     * @return 结果
     */
    public int insertUserCard(UserCard userCard);

    /**
     * 修改银行卡管理
     * 
     * @param userCard 银行卡管理
     * @return 结果
     */
    public int updateUserCard(UserCard userCard);

    /**
     * 批量删除银行卡管理
     * 
     * @param cardIds 需要删除的银行卡管理主键集合
     * @return 结果
     */
    public int deleteUserCardByCardIds(String[] cardIds);

    /**
     * 删除银行卡管理信息
     * 
     * @param cardId 银行卡管理主键
     * @return 结果
     */
    public int deleteUserCardByCardId(String cardId);
}
