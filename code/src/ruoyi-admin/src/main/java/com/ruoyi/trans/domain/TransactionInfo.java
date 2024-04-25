package com.ruoyi.trans.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * trans对象 Transaction_Info
 * 
 * @author z
 * @date 2023-12-26
 */
public class TransactionInfo extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 交易流水编号 */
    private Long fStreamId;

    /** 用户内部代码 */
    @Excel(name = "用户内部代码")
    private Long userId;

    /** 使用的银行卡号 */
    @Excel(name = "使用的银行卡号")
    private String cardId;

    /** 基金代码 */
    @Excel(name = "基金代码")
    private String fId;

    /** 交易时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "交易时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date fDealTime;

    /** 交易金额 */
    @Excel(name = "交易金额")
    private Long fDealAmount;

    /** 交易状态 */
    @Excel(name = "交易状态", readConverterExp = "0=未清算 1=已清算 2=已撤销")
    private Long fDealStatus;

    /** 交易类型（0申购1赎回） */
    @Excel(name = "交易类型", readConverterExp = "0=申购1赎回")
    private Long fDealType;

    public void setfStreamId(Long fStreamId) 
    {
        this.fStreamId = fStreamId;
    }

    public Long getfStreamId() 
    {
        return fStreamId;
    }
    public void setUserId(Long userId) 
    {
        this.userId = userId;
    }

    public Long getUserId() 
    {
        return userId;
    }
    public void setCardId(String cardId) 
    {
        this.cardId = cardId;
    }

    public String getCardId() 
    {
        return cardId;
    }
    public void setfId(String fId) 
    {
        this.fId = fId;
    }

    public String getfId() 
    {
        return fId;
    }
    public void setfDealTime(Date fDealTime) 
    {
        this.fDealTime = fDealTime;
    }

    public Date getfDealTime() 
    {
        return fDealTime;
    }
    public void setfDealAmount(Long fDealAmount) 
    {
        this.fDealAmount = fDealAmount;
    }

    public Long getfDealAmount() 
    {
        return fDealAmount;
    }
    public void setfDealStatus(Long fDealStatus) 
    {
        this.fDealStatus = fDealStatus;
    }

    public Long getfDealStatus() 
    {
        return fDealStatus;
    }
    public void setfDealType(Long fDealType) 
    {
        this.fDealType = fDealType;
    }

    public Long getfDealType() 
    {
        return fDealType;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("fStreamId", getfStreamId())
            .append("userId", getUserId())
            .append("cardId", getCardId())
            .append("fId", getfId())
            .append("fDealTime", getfDealTime())
            .append("fDealAmount", getfDealAmount())
            .append("fDealStatus", getfDealStatus())
            .append("fDealType", getfDealType())
            .toString();
    }
}
