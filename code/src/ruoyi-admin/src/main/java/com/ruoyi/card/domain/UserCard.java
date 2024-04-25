package com.ruoyi.card.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 银行卡管理对象 User_Card
 * 
 * @author ruoyi
 * @date 2023-12-26
 */
public class UserCard extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 银行卡号 */
    @Excel(name = "银行卡号")
    private String cardId;

    /** 持卡人ID */
    @Excel(name = "持卡人ID")
    private Long userId;

    /** 金额 */
    @Excel(name = "金额")
    private Long cardAmount;

    /** 卡状态（0正常 1停用） */
    @Excel(name = "卡状态", readConverterExp = "0=正常,1=停用")
    private String cardStatus;

    public void setCardId(String cardId) 
    {
        this.cardId = cardId;
    }

    public String getCardId() 
    {
        return cardId;
    }
    public void setUserId(Long userId) 
    {
        this.userId = userId;
    }

    public Long getUserId() 
    {
        return userId;
    }
    public void setCardAmount(Long cardAmount) 
    {
        this.cardAmount = cardAmount;
    }

    public Long getCardAmount() 
    {
        return cardAmount;
    }
    public void setCardStatus(String cardStatus) 
    {
        this.cardStatus = cardStatus;
    }

    public String getCardStatus() 
    {
        return cardStatus;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("cardId", getCardId())
            .append("userId", getUserId())
            .append("cardAmount", getCardAmount())
            .append("cardStatus", getCardStatus())
            .toString();
    }
}
