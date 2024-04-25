package com.ruoyi.fund.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.fund.domain.FundInfo;
import com.ruoyi.fund.service.IFundInfoService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 基金管理Controller
 * 
 * @author ruoyi
 * @date 2023-12-23
 */
@RestController
@RequestMapping("/fund_manage/FundManagement")
public class FundInfoController extends BaseController
{
    @Autowired
    private IFundInfoService fundInfoService;

    /**
     * 查询基金管理列表
     */
    @PreAuthorize("@ss.hasPermi('fund_manage:FundManagement:list')")
    @GetMapping("/list")
    public TableDataInfo list(FundInfo fundInfo)
    {
        startPage();
        List<FundInfo> list = fundInfoService.selectFundInfoList(fundInfo);
        return getDataTable(list);
    }

    /**
     * 导出基金管理列表
     */
    @PreAuthorize("@ss.hasPermi('fund_manage:FundManagement:export')")
    @Log(title = "基金管理", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, FundInfo fundInfo)
    {
        List<FundInfo> list = fundInfoService.selectFundInfoList(fundInfo);
        ExcelUtil<FundInfo> util = new ExcelUtil<FundInfo>(FundInfo.class);
        util.exportExcel(response, list, "基金管理数据");
    }

    /**
     * 获取基金管理详细信息
     */
    @PreAuthorize("@ss.hasPermi('fund_manage:FundManagement:query')")
    @GetMapping(value = "/{fId}")
    public AjaxResult getInfo(@PathVariable("fId") String fId)
    {
        return success(fundInfoService.selectFundInfoByFId(fId));
    }

    /**
     * 新增基金管理
     */
    @PreAuthorize("@ss.hasPermi('fund_manage:FundManagement:add')")
    @Log(title = "基金管理", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody FundInfo fundInfo)
    {
        return toAjax(fundInfoService.insertFundInfo(fundInfo));
    }

    /**
     * 修改基金管理
     */
    @PreAuthorize("@ss.hasPermi('fund_manage:FundManagement:edit')")
    @Log(title = "基金管理", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody FundInfo fundInfo)
    {
        return toAjax(fundInfoService.updateFundInfo(fundInfo));
    }

    /**
     * 删除基金管理
     */
    @PreAuthorize("@ss.hasPermi('fund_manage:FundManagement:remove')")
    @Log(title = "基金管理", businessType = BusinessType.DELETE)
	@DeleteMapping("/{fIds}")
    public AjaxResult remove(@PathVariable String[] fIds)
    {
        return toAjax(fundInfoService.deleteFundInfoByFIds(fIds));
    }
}
