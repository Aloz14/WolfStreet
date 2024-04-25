package com.ruoyi.card.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.card.mapper.UserCardMapper;
import com.ruoyi.card.domain.UserCard;
import com.ruoyi.card.service.IUserCardService;

/**
 * 银行卡管理Service业务层处理
 * 
 * @author ruoyi
 * @date 2023-12-26
 */
@Service
public class UserCardServiceImpl implements IUserCardService 
{
    @Autowired
    private UserCardMapper userCardMapper;

    /**
     * 查询银行卡管理
     * 
     * @param cardId 银行卡管理主键
     * @return 银行卡管理
     */
    @Override
    public UserCard selectUserCardByCardId(String cardId)
    {
        return userCardMapper.selectUserCardByCardId(cardId);
    }

    /**
     * 查询银行卡管理列表
     * 
     * @param userCard 银行卡管理
     * @return 银行卡管理
     */
    @Override
    public List<UserCard> selectUserCardList(UserCard userCard)
    {
        return userCardMapper.selectUserCardList(userCard);
    }

    /**
     * 新增银行卡管理
     * 
     * @param userCard 银行卡管理
     * @return 结果
     */
    @Override
    public int insertUserCard(UserCard userCard)
    {
        return userCardMapper.insertUserCard(userCard);
    }

    /**
     * 修改银行卡管理
     * 
     * @param userCard 银行卡管理
     * @return 结果
     */
    @Override
    public int updateUserCard(UserCard userCard)
    {
        return userCardMapper.updateUserCard(userCard);
    }

    /**
     * 批量删除银行卡管理
     * 
     * @param cardIds 需要删除的银行卡管理主键
     * @return 结果
     */
    @Override
    public int deleteUserCardByCardIds(String[] cardIds)
    {
        return userCardMapper.deleteUserCardByCardIds(cardIds);
    }

    /**
     * 删除银行卡管理信息
     * 
     * @param cardId 银行卡管理主键
     * @return 结果
     */
    @Override
    public int deleteUserCardByCardId(String cardId)
    {
        return userCardMapper.deleteUserCardByCardId(cardId);
    }
}
