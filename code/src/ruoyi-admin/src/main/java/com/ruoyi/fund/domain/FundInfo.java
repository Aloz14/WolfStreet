package com.ruoyi.fund.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 基金管理对象 Fund_Info
 * 
 * @author ruoyi
 * @date 2023-12-23
 */
public class FundInfo extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 基金代码 */
    private String fId;

    /** 基金名称 */
    @Excel(name = "基金名称")
    private String fName;

    /** 基金类型 */
    @Excel(name = "基金类型")
    private Long fType;

    /** 基金规模 */
    @Excel(name = "基金规模")
    private Long fSize;

    /** 基金经理 */
    @Excel(name = "基金经理")
    private String fMonitor;

    /** 基金成立日 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "基金成立日", width = 30, dateFormat = "yyyy-MM-dd")
    private Date fStartTime;

    /** 基金所属公司 */
    @Excel(name = "基金所属公司")
    private String fCompany;

    /** 基金评级(0~4) */
    @Excel(name = "基金评级(0~4)")
    private Long fLevel;

    /** 基金风险评级(012对应低中高) */
    @Excel(name = "基金风险评级(012对应低中高)")
    private Long fRiskLevel;

    /** 基金基本概况 */
    @Excel(name = "基金基本概况")
    private String fOverview;

    /** 基金状态 */
    @Excel(name = "基金状态")
    private Long fStatus;

    public void setfId(String fId) 
    {
        this.fId = fId;
    }

    public String getfId() 
    {
        return fId;
    }
    public void setfName(String fName) 
    {
        this.fName = fName;
    }

    public String getfName() 
    {
        return fName;
    }
    public void setfType(Long fType) 
    {
        this.fType = fType;
    }

    public Long getfType() 
    {
        return fType;
    }
    public void setfSize(Long fSize) 
    {
        this.fSize = fSize;
    }

    public Long getfSize() 
    {
        return fSize;
    }
    public void setfMonitor(String fMonitor) 
    {
        this.fMonitor = fMonitor;
    }

    public String getfMonitor() 
    {
        return fMonitor;
    }
    public void setfStartTime(Date fStartTime) 
    {
        this.fStartTime = fStartTime;
    }

    public Date getfStartTime() 
    {
        return fStartTime;
    }
    public void setfCompany(String fCompany) 
    {
        this.fCompany = fCompany;
    }

    public String getfCompany() 
    {
        return fCompany;
    }
    public void setfLevel(Long fLevel) 
    {
        this.fLevel = fLevel;
    }

    public Long getfLevel() 
    {
        return fLevel;
    }
    public void setfRiskLevel(Long fRiskLevel) 
    {
        this.fRiskLevel = fRiskLevel;
    }

    public Long getfRiskLevel() 
    {
        return fRiskLevel;
    }
    public void setfOverview(String fOverview) 
    {
        this.fOverview = fOverview;
    }

    public String getfOverview() 
    {
        return fOverview;
    }
    public void setfStatus(Long fStatus) 
    {
        this.fStatus = fStatus;
    }

    public Long getfStatus() 
    {
        return fStatus;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("fId", getfId())
            .append("fName", getfName())
            .append("fType", getfType())
            .append("fSize", getfSize())
            .append("fMonitor", getfMonitor())
            .append("fStartTime", getfStartTime())
            .append("fCompany", getfCompany())
            .append("fLevel", getfLevel())
            .append("fRiskLevel", getfRiskLevel())
            .append("fOverview", getfOverview())
            .append("fStatus", getfStatus())
            .toString();
    }
}
