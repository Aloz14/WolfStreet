package com.ruoyi.card.controller;

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
import com.ruoyi.card.domain.UserCard;
import com.ruoyi.card.service.IUserCardService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 银行卡管理Controller
 * 
 * @author ruoyi
 * @date 2023-12-26
 */
@RestController
@RequestMapping("/card/CardManagement")
public class UserCardController extends BaseController
{
    @Autowired
    private IUserCardService userCardService;

    /**
     * 查询银行卡管理列表
     */
    @PreAuthorize("@ss.hasPermi('card:CardManagement:list')")
    @GetMapping("/list")
    public TableDataInfo list(UserCard userCard)
    {
        startPage();
        List<UserCard> list = userCardService.selectUserCardList(userCard);
        return getDataTable(list);
    }

    /**
     * 导出银行卡管理列表
     */
    @PreAuthorize("@ss.hasPermi('card:CardManagement:export')")
    @Log(title = "银行卡管理", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, UserCard userCard)
    {
        List<UserCard> list = userCardService.selectUserCardList(userCard);
        ExcelUtil<UserCard> util = new ExcelUtil<UserCard>(UserCard.class);
        util.exportExcel(response, list, "银行卡管理数据");
    }

    /**
     * 获取银行卡管理详细信息
     */
    @PreAuthorize("@ss.hasPermi('card:CardManagement:query')")
    @GetMapping(value = "/{cardId}")
    public AjaxResult getInfo(@PathVariable("cardId") String cardId)
    {
        return success(userCardService.selectUserCardByCardId(cardId));
    }

    /**
     * 新增银行卡管理
     */
    @PreAuthorize("@ss.hasPermi('card:CardManagement:add')")
    @Log(title = "银行卡管理", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody UserCard userCard)
    {
        return toAjax(userCardService.insertUserCard(userCard));
    }

    /**
     * 修改银行卡管理
     */
    @PreAuthorize("@ss.hasPermi('card:CardManagement:edit')")
    @Log(title = "银行卡管理", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody UserCard userCard)
    {
        return toAjax(userCardService.updateUserCard(userCard));
    }

    /**
     * 删除银行卡管理
     */
    @PreAuthorize("@ss.hasPermi('card:CardManagement:remove')")
    @Log(title = "银行卡管理", businessType = BusinessType.DELETE)
	@DeleteMapping("/{cardIds}")
    public AjaxResult remove(@PathVariable String[] cardIds)
    {
        return toAjax(userCardService.deleteUserCardByCardIds(cardIds));
    }
}
