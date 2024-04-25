<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="基金名称" prop="fName">
        <el-input
          v-model="queryParams.fName"
          placeholder="请输入基金名称"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="基金规模" prop="fSize"  style="width:265px">
        <el-rate 
          v-model="queryParams.fSize" 
          size="large"
          :max=5
          :texts="fSizeDisplay"
          :colors="['blue','blue','blue']"
          show-text
          style="position:relative;top:5px"
          @change="handleQuery"
        />
      </el-form-item>
      <el-form-item label="基金经理" prop="fMonitor">
        <el-input
          v-model="queryParams.fMonitor"
          placeholder="请输入基金经理"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="成立日" prop="fStartTime">
        <el-date-picker clearable
          v-model="queryParams.fStartTime"
          type="date"
          value-format="yyyy-MM-dd"
          placeholder="请选择基金成立日">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="所属公司" prop="fCompany">
        <treeselect
          v-model="queryParams.fCompany" 
          :options="deptOptions" 
          :show-count="true"
          placeholder="请选择归属部门" 
          style="width:198px"
        />
      </el-form-item>
      <el-form-item label="基金评级" prop="fLevel" style="width:265px">
        <el-rate 
          v-model="queryParams.fLevel" 
          size="large"
          :max=5
          :texts="fLevelDisplay"
          show-text
          style="position:relative;top:5px"
          @change="handleQuery"
        />
      </el-form-item>
      <el-form-item label="风险评级" prop="fRiskLevel" style="width:267px">
        <el-rate 
          v-model="queryParams.fRiskLevel" 
          size="large" 
          :max=3
          :texts="fRiskLevelDisplay"
          :colors="['red','red','red']"
          show-text
          style="position:relative;top:5px"
          @change="handleQuery"
        />
      </el-form-item>
      <el-form-item label="基本概况" prop="fOverview">
        <el-input
          v-model="queryParams.fOverview"
          placeholder="请输入基金基本概况"
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
          v-hasPermi="['fund_manage:FundManagement:add']"
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
          v-hasPermi="['fund_manage:FundManagement:edit']"
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
          v-hasPermi="['fund_manage:FundManagement:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['fund_manage:FundManagement:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="FundManagementList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="基金代码" align="center" prop="fId" />
      <el-table-column label="基金名称" align="center" prop="fName" />
      <el-table-column label="基金类型" align="center" prop="fType" />
      <el-table-column label="基金规模" align="center" prop="fSize">
        <template slot-scope="scope">
          <span>{{ fSizeDisplay[scope.row.fSize-1] }}</span>
        </template>
      </el-table-column>
      <el-table-column label="基金经理" align="center" prop="fMonitor" />
      <el-table-column label="成立日" align="center" prop="fStartTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.fStartTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="所属公司" align="center" prop="fCompany" />
      <el-table-column label="基金评级" align="center" prop="fLevel">
        <template slot-scope="scope">
          <span>{{ fLevelDisplay[scope.row.fLevel-1] }}</span>
        </template>
      </el-table-column>
      <el-table-column label="风险评级" align="center" prop="fRiskLevel">
        <template slot-scope="scope">
          <span>{{ fRiskLevelDisplay[scope.row.fRiskLevel-1] }}</span>
        </template>
      </el-table-column>
      <el-table-column label="基本概况" align="center" prop="fOverview" />
      <el-table-column label="基金状态" align="center" prop="fStatus" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['fund_manage:FundManagement:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['fund_manage:FundManagement:remove']"
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

    <!-- 添加或修改基金管理对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="基金名称" prop="fName">
          <el-input v-model="form.fName" placeholder="请输入基金名称" />
        </el-form-item>
        <el-form-item label="基金规模" prop="fSize">
          <!-- <el-input v-model="form.fSize" placeholder="请输入基金规模" /> -->
          <el-rate 
            v-model="form.fSize" 
            size="large"
            :max=5
            :texts="fSizeDisplay"
            :colors="['blue','blue','blue']"
            show-text
            style="position:relative;top:5px"
          />
        </el-form-item>
        <el-form-item label="基金经理" prop="fMonitor">
          <el-input v-model="form.fMonitor" placeholder="请输入基金经理" />
        </el-form-item>
        <el-form-item label="成立日" prop="fStartTime">
          <el-date-picker clearable
            v-model="form.fStartTime"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="请选择基金成立日">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="所属公司" prop="fCompany">
          <treeselect
            v-model="form.fCompany" 
            :options="deptOptions" 
            :show-count="true"
            placeholder="请选择归属部门" 
          />
        </el-form-item>
        <el-form-item label="基金评级" prop="fLevel">
          <el-rate 
            v-model="form.fLevel" 
            size="large"
            :max=5
            :texts="fLevelDisplay"
            show-text
            style="position:relative;top:5px"
          />
        </el-form-item>
        <el-form-item label="风险评级" prop="fRiskLevel">
          <el-rate 
            v-model="form.fRiskLevel" 
            size="large" 
            :max=3
            :texts="fRiskLevelDisplay"
            :colors="['red','red','red']"
            show-text
            style="position:relative;top:5px"
          />
        </el-form-item>
        <el-form-item label="基本概况" prop="fOverview">
          <el-input v-model="form.fOverview" placeholder="请输入基金基本概况" />
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
import { listFundManagement, getFundManagement, delFundManagement, addFundManagement, updateFundManagement } from "@/api/fund_manage/FundManagement";
import { deptTreeSelect } from "@/api/system/user";
import Treeselect from "@riophae/vue-treeselect";
import "@riophae/vue-treeselect/dist/vue-treeselect.css";

export default {
  name: "FundManagement",
  components: { Treeselect },
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
      // 部门树选项
      deptOptions: undefined,
      // 基金管理表格数据
      FundManagementList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        fName: null,
        fType: null,
        fSize: null,
        fMonitor: null,
        fStartTime: null,
        fCompany: null,
        // 基金评级
        fLevel: null,
        // 基金风险评级
        fRiskLevel: null,
        fOverview: null,
        fStatus: null
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
      },
      // 基金规模显示
      fSizeDisplay : ['1亿以下', '1-10亿', '10-30亿', '30-100亿', '100亿以上'],
      // 基金评级显示
      fLevelDisplay : ['较差', '合格', '中等', '良好', '极佳'],
      // 基金风险评级显示
      fRiskLevelDisplay : ['低风险', '中风险', '高风险'],
    };
  },
  created() {
    this.getList();
    this.getDeptTree();
  },
  methods: {
    /** 查询部门下拉树结构 */
    getDeptTree() {
      deptTreeSelect().then(response => {
        this.deptOptions = response.data;
      });
    },
    /** 查询基金管理列表 */
    getList() {
      this.loading = true;
      listFundManagement(this.queryParams).then(response => {
        this.FundManagementList = response.rows;
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
        fId: null,
        fName: null,
        fType: null,
        fSize: null,
        fMonitor: null,
        fStartTime: null,
        fCompany: null,
        fLevel: null,
        fRiskLevel: null,
        fOverview: null,
        fStatus: null
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
      this.ids = selection.map(item => item.fId)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.open = true;
      this.title = "添加基金管理";
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const fId = row.fId || this.ids
      getFundManagement(fId).then(response => {
        this.form = response.data;
        this.open = true;
        this.title = "修改基金管理";
      });
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.fId != null) {
            updateFundManagement(this.form).then(response => {
              this.$modal.msgSuccess("修改成功");
              this.open = false;
              this.getList();
            });
          } else {
            addFundManagement(this.form).then(response => {
              this.$modal.msgSuccess("新增成功");
              this.open = false;
              this.getList();
            });
          }
        }
      });
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      const fIds = row.fId || this.ids;
      this.$modal.confirm('是否确认删除基金管理编号为"' + fIds + '"的数据项？').then(function() {
        return delFundManagement(fIds);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("删除成功");
      }).catch(() => {});
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('fund_manage/FundManagement/export', {
        ...this.queryParams
      }, `FundManagement_${new Date().getTime()}.xlsx`)
    }
  }
};
</script>