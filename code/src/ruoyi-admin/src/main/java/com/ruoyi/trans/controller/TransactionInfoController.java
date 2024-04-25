package com.ruoyi.trans.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;

import com.ruoyi.framework.web.domain.server.Sys;
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
import com.ruoyi.trans.domain.TransactionInfo;
import com.ruoyi.trans.service.ITransactionInfoService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * transController
 * 
 * @author z
 * @date 2023-12-26
 */
@RestController
@RequestMapping("/transaction_manage/trans")
public class TransactionInfoController extends BaseController
{
    @Autowired
    private ITransactionInfoService transactionInfoService;

    /**
     * 查询trans列表
     */
    @PreAuthorize("@ss.hasPermi('transaction_manage:trans:list')")
    @GetMapping("/list")
    public TableDataInfo list(TransactionInfo transactionInfo)
    {
        startPage();
        List<TransactionInfo> list = transactionInfoService.selectTransactionInfoList(transactionInfo);
        return getDataTable(list);
    }

    /**
     * 导出trans列表
     */
    @PreAuthorize("@ss.hasPermi('transaction_manage:trans:export')")
    @Log(title = "trans", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, TransactionInfo transactionInfo)
    {
        List<TransactionInfo> list = transactionInfoService.selectTransactionInfoList(transactionInfo);
        ExcelUtil<TransactionInfo> util = new ExcelUtil<TransactionInfo>(TransactionInfo.class);
        util.exportExcel(response, list, "trans数据");
    }

    /**
     * 获取trans详细信息
     */
    @PreAuthorize("@ss.hasPermi('transaction_manage:trans:query')")
    @GetMapping(value = "/{fStreamId}")
    public AjaxResult getInfo(@PathVariable("fStreamId") Long fStreamId)
    {
        return success(transactionInfoService.selectTransactionInfoByFStreamId(fStreamId));
    }

    /**
     * 新增trans
     */
    @PreAuthorize("@ss.hasPermi('transaction_manage:trans:add')")
    @Log(title = "trans", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody TransactionInfo transactionInfo)
    {
        return toAjax(transactionInfoService.insertTransactionInfo(transactionInfo));
    }

    /**
     * 修改trans
     */
    @PreAuthorize("@ss.hasPermi('transaction_manage:trans:edit')")
    @Log(title = "trans", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody TransactionInfo transactionInfo)
    {
        return toAjax(transactionInfoService.updateTransactionInfo(transactionInfo));
    }

    /**
     * 删除trans
     */
    @PreAuthorize("@ss.hasPermi('transaction_manage:trans:remove')")
    @Log(title = "trans", businessType = BusinessType.DELETE)
	@DeleteMapping("/{fStreamIds}")
    public AjaxResult remove(@PathVariable Long[] fStreamIds)
    {
        return toAjax(transactionInfoService.deleteTransactionInfoByFStreamIds(fStreamIds));
    }
}
