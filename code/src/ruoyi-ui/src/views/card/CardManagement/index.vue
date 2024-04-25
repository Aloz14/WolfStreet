<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="银行卡号" prop="cardId">
        <el-input
          v-model="queryParams.cardId"
          placeholder="请输入银行卡号"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="持卡人ID" prop="userId">
        <el-input
          v-model="queryParams.userId"
          placeholder="请输入持卡人ID"
          clearable
          @keyup.enter.native="handleQuery"
        />
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
          size="mini"
          @click="handleAdd"
          v-hasPermi="['card:CardManagement:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="el-icon-edit"
          size="mini"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['card:CardManagement:edit']"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="el-icon-delete"
          size="mini"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['card:CardManagement:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['card:CardManagement:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="CardManagementList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="银行卡号" align="center" prop="cardId" />
      <el-table-column label="持卡人ID" align="center" prop="userId" />
      <el-table-column label="金额" align="center" prop="cardAmount" />
      <el-table-column label="卡状态" align="center" prop="cardStatus" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['card:CardManagement:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['card:CardManagement:remove']"
          >删除</el-button>
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

    <!-- 添加或修改银行卡管理对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="银行卡ID" prop="cardId">
          <el-input v-model="form.cardId" :disabled="update" placeholder="请输入银行卡ID" />
        </el-form-item>
        <el-form-item label="持卡人ID" prop="userId">
          <el-input v-model="form.userId" placeholder="请输入持卡人ID" />
        </el-form-item>
        <el-form-item label="金额" prop="cardAmount">
          <el-input v-model="form.cardAmount" placeholder="请输入金额" />
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
import { listCardManagement, getCardManagement, delCardManagement, addCardManagement, updateCardManagement } from "@/api/card/CardManagement";
import { getUser } from "@/api/system/user";

export default {
  name: "CardManagement",
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
      // 银行卡管理表格数据
      CardManagementList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        cardId: null,
        userId: null,
        cardStatus: null
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
      },
      // 修改或新增
      update: true,
    };
  },
  created() {
    this.getList();
  },
  methods: {
    /** 查询银行卡管理列表 */
    getList() {
      this.loading = true;
      listCardManagement(this.queryParams).then(response => {
        this.CardManagementList = response.rows;
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
        cardId: null,
        userId: null,
        cardAmount: null,
        cardStatus: null
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
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.cardId)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.open = true;
      this.update = false;
      this.title = "绑定银行卡";
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      this.update = true;
      const cardId = row.cardId || this.ids
      getCardManagement(cardId).then(response => {
        this.form = response.data;
        this.open = true;
        this.title = "修改银行卡信息";
      });
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          getUser(this.form.userId).then(responseA => {
            if(responseA.msg=="操作成功")
            {
              if (this.form.cardId != null && this.update) {
                updateCardManagement(this.form).then(response => {
                console.log("1234");
                this.$modal.msgSuccess("修改成功");
                this.open = false;
                this.getList();
                });
              } 
              else {
                getCardManagement(this.form.cardId).then(responseB=>{
                console.log(responseB.data);
                if(responseB.data==null)
                {
                  addCardManagement(this.form).then(response => {
                  this.$modal.msgSuccess("新增成功");
                  this.open = false;
                  this.getList();
                  });
                }
                else
                {
                  this.$modal.msgError("此银行卡已存在");
                }
                });
                
              }
            }
            else{
              this.$modal.msgError("未找到该用户");
            };
          });
          
        }
      });
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      const cardIds = row.cardId || this.ids;
      this.$modal.confirm('是否确认删除银行卡管理编号为"' + cardIds + '"的数据项？').then(function() {
        return delCardManagement(cardIds);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("删除成功");
      }).catch(() => {});
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('card/CardManagement/export', {
        ...this.queryParams
      }, `CardManagement_${new Date().getTime()}.xlsx`)
    }
  }
};
</script>
