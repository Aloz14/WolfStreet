<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="用户ID" prop="userId">
        <el-input
          v-model="queryParams.userId"
          placeholder="请输入用户ID"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="银行卡号" prop="cardId">
        <el-input
          v-model="queryParams.cardId"
          placeholder="银行卡号"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="基金代码" prop="fId">
        <el-input
          v-model="queryParams.fId"
          placeholder="请输入基金代码"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="交易时间" prop="fDealTime">
        <el-date-picker clearable
          v-model="queryParams.fDealTime"
          type="date"
          value-format="yyyy-MM-dd"
          placeholder="请选择交易时间">
        </el-date-picker>
      </el-form-item>

      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-plus"
          size="large"
          @click="handleAdd"
          v-hasPermi="['transaction_manage:trans:add']"
        >添加业务</el-button>
      </el-col>

      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-aim"
          size="large"
          @click="handleLiquidation"
          v-hasPermi="['transaction_manage:trans:edit']"
        >业务清算</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="transList">
      <el-table-column label="交易流水编号" align="center" prop="fStreamId" />
      <el-table-column label="用户ID" align="center" prop="userId" />
      <el-table-column label="银行卡号" align="center" prop="cardId" />
      <el-table-column label="基金代码" align="center" prop="fId" />
      <el-table-column label="交易时间" align="center" prop="fDealTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.fDealTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="交易金额" align="center" prop="fDealAmount" />
      <el-table-column label="交易状态" align="center" prop="fDealStatus">
        <template slot-scope="scope">
          <div v-if="scope.row.fDealStatus === 0">未清算</div>
          <div v-else-if="scope.row.fDealStatus === 1" >已清算</div>
          <div v-else >已撤回</div>
        </template>
      </el-table-column>
      <el-table-column label="交易类型" align="center" prop="fDealType" >
        <template slot-scope="scope">
          <div v-if="scope.row.fDealType === 0">申购业务</div>
          <div v-else >赎回业务</div>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            :disabled="scope.row.fDealStatus !== 0"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['transaction_manage:trans:remove']"
          >撤销业务</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination
      v-show="total>0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />

    <!-- 添加或修改trans对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="用户ID" prop="userId" required>
          <el-input v-model="form.userId" placeholder="请输入用户ID" />
        </el-form-item>
        <el-form-item label="银行卡号" prop="cardId" required>
          <el-input v-model="form.cardId" placeholder="请输入银行卡号" />
        </el-form-item>
        <el-form-item label="基金代码" prop="fId" required>
          <el-input v-model="form.fId" placeholder="请输入基金代码" />
        </el-form-item>
        <el-form-item label="交易金额" prop="fDealAmount" required>
          <el-input v-model="form.fDealAmount" placeholder="请输入交易金额" />
        </el-form-item>
        <el-form-item label="交易类型" required>
          <el-select v-model="form.fDealType" placeholder="请选择交易类型">
            <el-option
              v-for="dict in transTypeDict"
              :key="dict.value"
              :label="dict.label"
              :value="dict.value"
            ></el-option>
          </el-select>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listTrans, getTrans, delTrans, addTrans, updateTrans } from "@/api/transaction_manage/trans";
import { updateCardManagement,getCardManagement } from "@/api/card/CardManagement";
import {getTime} from "@/utils";

export default {
  name: "Trans",
  data() {
    return {
      // 遮罩层
      loading: true,
      // 选中数组
      ids: [],
      // 非单个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      // trans表格数据
      transList: [],
      transTypeDict:[
        {value:0,label:"申购"},
        {value:1,label:"赎回"}
      ],
      transStatusDict:[
        {value:0,label:"未清算"},
        {value:1,label:"已清算"},
        {value: 2,label: "已撤回"}
      ],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        userId: null,
        cardId: null,
        fId: null,
        fDealTime: null,
        fDealAmount: null,
        fDealStatus: null,
        fDealType: null,
      },
      // 表单参数
      form: {
        userId: undefined,
        cardId: undefined,
        fId: undefined,
        fDealTime: undefined,
        fDealAmount: undefined,
        fDealStatus: undefined,
        fDealType: undefined
      },
      // 表单校验
      rules: {
      }
    };
  },
  created() {
    this.getList();
  },
  methods: {
    /** 查询trans列表 */
    getList() {
      this.loading = true;
      listTrans(this.queryParams).then(response => {
        this.transList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },
    // 取消按钮
    cancel() {
      this.open = false;
      this.reset();
    },
    // 表单重置
    reset() {
      this.form = {
        userId: null,
        cardId: null,
        fId: null,
        fDealTime: null,
        fDealAmount: null,
        fDealStatus: null,
        fDealType: null
      };
      this.resetForm("form");
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1;
      this.getList();
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.resetForm("queryForm");
      this.handleQuery();
    },

    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.open = true;
      this.title = "添加业务";
    },
    handleDelete(row) {
      const fStreamId = row.fStreamId;
      this.$modal.confirm('是否确认撤回编号为"' + fStreamId + '"的业务？').then(function() {
        return delTrans(fStreamId);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("撤回成功");
      }).catch(() => {});
    },
    /** 提交按钮 */
    submitForm() {
      this.form.fDealTime = getTime();
      this.form.fDealStatus = 0;  // 未清算
      this.$refs["form"].validate(valid => {
        if (valid) {
            addTrans(this.form).then(response => {
              this.$modal.msgSuccess("添加业务成功");
              this.open = false;
              this.getList();
            });
        }
      });
    },
    /** 清算，对当前所有标记为“未清算”的操作进行结算 */
    handleLiquidation() {
      this.$modal.confirm('是否进行清算？').then(() => {

        var num = 0;
        var failed_num = 0;
        var cForm={};

        this.transList.forEach(item=>{
          if(item.fDealStatus === 0){
            num++;

            getCardManagement(item.cardId).then(response => {
              cForm = response.data;
              if (item.fDealType === 0){
                cForm.cardAmount -= item.fDealAmount;
              }
              else{
                cForm.cardAmount += item.fDealAmount;
              }
              updateCardManagement(cForm);
            });

          }
        })


        // 更新状态
        this.reset();
        this.form.fDealStatus = 1;

        if(num != 0){
          updateTrans(this.form).then(response => {
            this.$modal.msgSuccess("清算完成");
            this.getList();
          })
        }
        else{
          this.$modal.msgSuccess("无需清算！");
        }



      }).catch(() =>{
      })


    }
  }
};
</script>
