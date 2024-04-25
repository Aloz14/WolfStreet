<template>
  <div class="app-container home">
    <el-row :gutter="20">
      <el-col :sm="24" :lg="12" style="padding-left: 50px">
        <h2>欢迎您！业务员 {{ user.userName }} ！</h2>
        <br>
        <h1>系统介绍：</h1>
        <h1>Wolf基金业务操作系统</h1>
        <p>
          本项目为软件工程课程大作业，基于RuoYi-Vue开发，感谢RuoYi-Vue团队的开源贡献。
          开发背景：
          1. 随着经济全球化和信息技术的快速发展，金融行业面临着更加复杂和多样化的挑战。人们对于个人理财需求的增加、金融产品的多样化以及金融监管政策的不断更新，都要求金融机构提供更加专业、高效和个性化的理财服务。<br />
          2. 金融市场竞争日益激烈，金融机构需要不断提高市场占有率和客户满意度，通过推出新的金融产品、提供更好的理财服务来吸引和保留客户。为了实现这些目标，金融机构需要建立起一套高效的理财销售管理系统，以提高销售团队的工作效率、降低成本、提升客户体验。<br />
          3. 传统的理财销售过程通常繁琐而耗时，包括客户信息采集、风险评估、产品推荐、投资组合管理等环节。通过开发理财销售管理系统，可以对整个业务流程进行优化和自动化，提高工作效率和准确性，减少人为错误和重复劳动，节省时间和资源。<br />
          4. 随着信息技术的发展和应用，金融机构逐渐意识到数字化转型的重要性。通过引入理财销售管理系统，可以实现对销售业务的数字化管理和监控，将销售数据、客户信息、产品信息等进行集中存储和分析，提供准确的数据支持和决策依据，帮助管理层进行战略规划和业绩评估。
        </p>
        <p>
          <b>当前版本:</b> <span>v{{ version }}</span>
        </p>
      </el-col>
    </el-row>
    <el-divider />
    <el-row :gutter="20">
      <el-col :xs="24" :sm="24" :md="12" :lg="8">
        <el-card class="update-log">
          <div slot="header" class="clearfix">
            <span>开发成员信息</span>
          </div>
          <div class="body">
            <p>
              <i class="el-icon-s-promotion"></i> 同济大学软件学院官网：<br />
              <el-link
                href="https://sse.tongji.edu.cn/"
                target="_blank"
                >https://sse.tongji.edu.cn/</el-link
              >
            </p>
            <p>
              <i class="el-icon-hot-water"></i> 指导教师：<br />
              <el-link
                href="https://sse.tongji.edu.cn/info/1208/3184.htm"
                target="_blank"
                >Qingfeng DU</el-link
              >
            <p>
              <i class="el-icon-user-solid"></i> 小组成员：<br />
              郑楷 2154314<br />
              郑埴 2151617<br />
            </p>
            <p>
              <i class="el-icon-chat-dot-round"></i> 联系邮箱：<a
                href="trumanzwc@gmail.com"
                >trumanzwc@gmail.com</a
              >
            </p>
          </div>
        </el-card>
      </el-col>
        <el-col :xs="24" :sm="24" :md="12" :lg="8">
          <el-card class="update-log">
            <div slot="header" class="clearfix">
              <span>技术选型</span>
            </div>
            <div class="body">
              <p>
                <i class="el-icon-hot-water"></i> 前端技术：<br />
                  <ul>
                    <li>Vue</li>
                    <li>Vuex</li>
                    <li>Element-ui</li>
                    <li>Axios</li>
                    <li>Sass</li>
                    <li>Quill</li>
                    <li>...</li>
                  </ul>
                <p>
                  <i class="el-icon-user-solid"></i> 后端技术：<br />
                  <ul>
                    <li>SpringBoot</li>
                    <li>Spring Security</li>
                    <li>JWT</li>
                    <li>MyBatis</li>
                    <li>Druid</li>
                    <li>Fastjson</li>
                    <li>...</li>
                  </ul>
                </p>
              </p>
            </div>
          </el-card>
        </el-col>
    </el-row>
  </div>
</template>

<script>
import { getUserProfile } from "@/api/system/user";
export default {
  name: "Index",
  data() {
    return {
      // 版本号
      user: {},
      version: "1.2.0"
    };
  },
  created() {
    this.getUser();
  },
  methods: {
    goTarget(href) {
      window.open(href, "_blank");
    },
    getUser() {
      getUserProfile().then(response => {
        this.user = response.data;
      });
    },
  }
};
</script>

<style scoped lang="scss">
.home {
  blockquote {
    padding: 10px 20px;
    margin: 0 0 20px;
    font-size: 17.5px;
    border-left: 5px solid #eee;
  }
  hr {
    margin-top: 20px;
    margin-bottom: 20px;
    border: 0;
    border-top: 1px solid #eee;
  }
  .col-item {
    margin-bottom: 20px;
  }

  ul {
    padding: 0;
    margin: 0;
  }

  font-family: "open sans", "Helvetica Neue", Helvetica, Arial, sans-serif;
  font-size: 13px;
  color: #676a6c;
  overflow-x: hidden;

  ul {
    list-style-type: none;
  }

  h4 {
    margin-top: 0px;
  }

  h2 {
    margin-top: 10px;
    font-size: 26px;
    font-weight: 100;
  }

  p {
    margin-top: 10px;

    b {
      font-weight: 700;
    }
  }

  .update-log {
    ol {
      display: block;
      list-style-type: decimal;
      margin-block-start: 1em;
      margin-block-end: 1em;
      margin-inline-start: 0;
      margin-inline-end: 0;
      padding-inline-start: 40px;
    }
  }
}
</style>

