### 4 程序（针对面向对象类）设计说明

#### 4.1 程序描述
该类为SysUser实体类，用于表示系统中的用户信息，包括用户ID、部门ID、用户账号等属性。

#### 4.2 功能
主要功能包括：
- 表示和管理用户信息，如用户ID、部门ID、用户账号等。
- 提供一些辅助方法，如isAdmin()用于检查用户是否是管理员。

#### 4.3 输入项（输入接口）
- 通过类的构造方法和各个setter方法设置用户相关属性，如用户ID、部门ID、用户账号等。

#### 4.4 输出项（输出接口）
- 通过各个getter方法获取用户的属性信息，如用户ID、部门ID、用户账号等。
- 通过toString()方法输出用户信息的字符串表示。

#### 4.5 属性详细描述
| 属性名      | 类型    | 说明                            |
| ----------- | ------- | ------------------------------- |
| userId      | Long    | 用户ID                          |
| deptId      | Long    | 部门ID                          |
| userName    | String  | 用户账号                        |
| nickName    | String  | 用户昵称                        |
| email       | String  | 用户邮箱                        |
| phonenumber | String  | 手机号码                        |
| sex         | String  | 用户性别（0=男,1=女,2=未知）    |
| avatar      | String  | 用户头像                        |
| riskLevel   | String  | 风险等级（0=低,1=中,2=高）      |
| credType    | String  | 证件类型（身份证=0，护照=1）    |
| credID      | String  | 证件号码                        |
| address     | String  | 用户地址                        |
| password    | String  | 密码                            |
| status      | String  | 帐号状态（0正常 1停用）         |
| delFlag     | String  | 删除标志（0代表存在 2代表删除） |
| loginIp     | String  | 最后登录IP                      |
| loginDate   | Date    | 最后登录时间                    |
| dept        | SysDept | 部门对象                        |
| roles       | List    | 角色对象列表                    |
| roleIds     | Long[]  | 角色ID数组                      |
| postIds     | Long[]  | 岗位ID数组                      |
| roleId      | Long    | 角色ID                          |

#### 

#### 4.6 方法详细描述及实现流程
- `isAdmin()`: 检查用户是否是管理员，通过判断当前用户ID是否为特殊值实现。
- `toString()`: 生成用户信息的字符串表示，包括所有属性。

#### 4.7 类内、类外方法调用状态图


#### 4.8 限制条件及出错处理
- 对用户账号、昵称、邮箱等属性进行了输入验证，确保其符合规范。
- 在一些方法中使用了注解，如Xss、NotBlank、Email等，用于处理输入数据的安全性和合法性。



### 4 程序（针对面向对象类）设计说明

#### 4.1 程序描述
该程序是一个Spring Boot控制器类，用于处理用户信息相关的请求。主要功能包括用户列表展示、用户信息导出导入、用户详细信息获取、用户新增、修改、删除等操作。

#### 4.2 功能
主要功能包括：
- 获取用户列表
- 导出用户信息
- 获取用户详细信息
- 新增用户
- 修改用户
- 删除用户
- 重置用户密码
- 修改用户状态
- 获取用户授权角色
- 用户授权角色
- 获取部门树列表

#### 4.3 输入项（输入接口）
- 用户列表展示：GET请求，接收SysUser对象作为查询条件。
- 导出用户信息：POST请求，接收SysUser对象作为查询条件。
- 导入用户信息：POST请求，接收MultipartFile文件和updateSupport标志。
- 获取用户详细信息：GET请求，路径中带有userId参数。
- 新增用户：POST请求，接收SysUser对象。
- 修改用户：PUT请求，接收SysUser对象。
- 删除用户：DELETE请求，路径中带有userIds参数。
- 重置用户密码：PUT请求，路径中带有resetPwd参数，接收SysUser对象。
- 修改用户状态：PUT请求，路径中带有changeStatus参数，接收SysUser对象。
- 获取用户授权角色：GET请求，路径中带有userId参数。
- 用户授权角色：PUT请求，路径中带有authRole参数，接收userId和roleIds。
- 获取部门树列表：GET请求，接收SysDept对象作为查询条件。

#### 4.4 输出项（输出接口）
- 用户列表展示：返回TableDataInfo对象。
- 导出用户信息：无返回，直接将Excel文件导出。
- 导入用户信息：返回AjaxResult对象。
- 获取用户详细信息：返回AjaxResult对象。
- 新增用户：返回AjaxResult对象。
- 修改用户：返回AjaxResult对象。
- 删除用户：返回AjaxResult对象。
- 重置用户密码：返回AjaxResult对象。
- 修改用户状态：返回AjaxResult对象。
- 获取用户授权角色：返回AjaxResult对象。
- 用户授权角色：返回AjaxResult对象。
- 获取部门树列表：返回AjaxResult对象。

#### 4.5 属性详细描述
- `userService`: 用户服务对象
- `roleService`: 角色服务对象

#### 4.6 方法详细描述及实现流程
- `list()`: 获取用户列表，调用`userService.selectUserList(user)`获取用户数据。
- `export()`: 导出用户信息，调用`userService.selectUserList(user)`获取用户数据，然后使用`ExcelUtil`导出。
- `getInfo()`: 获取用户详细信息，调用相关服务获取用户信息、角色信息、岗位信息等。
- `add()`: 新增用户，调用`userService.insertUser(user)`插入用户数据。
- `edit()`: 修改用户，调用`userService.updateUser(user)`更新用户数据。
- `remove()`: 删除用户，调用`userService.deleteUserByIds(userIds)`删除用户数据。

#### 4.7 类内、类外方法调用状态图
- 未提供相关信息，可以根据具体情况补充。

#### 4.8 限制条件及出错处理
- 对于一些涉及敏感操作的方法，使用了Spring Security的`@PreAuthorize`注解进行权限控制。
- 在导入用户信息时，进行了重要数据的唯一性检查，并使用了ExcelUtil进行文件操作的异常处理。



### 4 程序（针对面向对象类）设计说明

#### 4.1 程序描述
该程序是一个Spring Boot控制器类，用于处理用户登录验证、获取用户信息以及获取路由信息等请求。主要功能包括用户登录、获取用户基本信息、获取用户角色和权限信息、获取系统路由信息。

#### 4.2 功能
主要功能包括：
- 用户登录验证
- 获取用户基本信息
- 获取用户角色和权限信息
- 获取系统路由信息

#### 4.3 输入项（输入接口）
- 用户登录验证：POST请求，接收LoginBody对象，包含用户名、密码、验证码等信息。
- 获取用户基本信息：GET请求，无参数。
- 获取用户角色和权限信息：GET请求，无参数。
- 获取系统路由信息：GET请求，无参数。

#### 4.4 输出项（输出接口）
- 用户登录验证：返回AjaxResult对象，包含用户令牌。
- 获取用户基本信息：返回AjaxResult对象，包含用户基本信息、角色集合和权限集合。
- 获取用户角色和权限信息：返回AjaxResult对象，包含用户基本信息、角色集合和权限集合。
- 获取系统路由信息：返回AjaxResult对象，包含系统路由信息。

#### 4.5 属性详细描述
- `loginService`: 登录服务对象
- `menuService`: 菜单服务对象
- `permissionService`: 权限服务对象

#### 4.6 方法详细描述及实现流程
- `login()`: 用户登录验证，调用`loginService.login()`生成令牌。
- `getInfo()`: 获取用户基本信息，调用相关服务获取用户信息、角色信息、权限信息等。
- `getRouters()`: 获取系统路由信息，调用相关服务获取用户的菜单信息，并使用`menuService.buildMenus()`构建菜单树。

#### 4.7 类内、类外方法调用状态图
- 未提供相关信息，可以根据具体情况补充。

#### 4.8 限制条件及出错处理
- 在用户登录验证时，通过`SecurityUtils`工具类获取登录用户信息，生成令牌并返回。
- 在获取用户信息、角色和权限信息时，通过`SecurityUtils`工具类获取登录用户信息，再通过相应的服务获取相关信息。
- 在获取系统路由信息时，通过`SecurityUtils`工具类获取登录用户信息，再调用`menuService`获取用户的菜单信息。

### 4 程序（针对面向对象类）设计说明

#### 4.1 程序描述
该程序是一个Spring Boot控制器类，用于处理操作日志记录相关的请求。主要功能包括获取操作日志列表、导出操作日志、删除操作日志、清空操作日志等。

#### 4.2 功能
主要功能包括：
- 获取操作日志列表
- 导出操作日志
- 删除操作日志
- 清空操作日志

#### 4.3 输入项（输入接口）
- 获取操作日志列表：GET请求，接收SysOperLog对象作为查询条件。
- 导出操作日志：POST请求，接收SysOperLog对象作为查询条件。
- 删除操作日志：DELETE请求，路径中带有operIds参数，表示要删除的操作日志的ID数组。
- 清空操作日志：DELETE请求。

#### 4.4 输出项（输出接口）
- 获取操作日志列表：返回TableDataInfo对象，包含分页后的操作日志列表。
- 导出操作日志：无返回，直接将Excel文件导出。
- 删除操作日志：返回AjaxResult对象，表示删除操作的结果。
- 清空操作日志：返回AjaxResult对象，表示清空操作的结果。

#### 4.5 属性详细描述
- `operLogService`: 操作日志服务对象

#### 4.6 方法详细描述及实现流程
- `list()`: 获取操作日志列表，调用`operLogService.selectOperLogList(operLog)`获取操作日志数据。
- `export()`: 导出操作日志，调用`operLogService.selectOperLogList(operLog)`获取操作日志数据，然后使用ExcelUtil导出。
- `remove()`: 删除操作日志，调用`operLogService.deleteOperLogByIds(operIds)`删除操作日志数据。
- `clean()`: 清空操作日志，调用`operLogService.cleanOperLog()`清空操作日志数据。

#### 4.7 类内、类外方法调用状态图
- 未提供相关信息，可以根据具体情况补充。

#### 4.8 限制条件及出错处理
- 对于一些涉及敏感操作的方法，使用了Spring Security的`@PreAuthorize`注解进行权限控制。
- 在删除操作日志时，通过`operLogService.deleteOperLogByIds(operIds)`进行删除，并返回操作结果。
- 在清空操作日志时，通过`operLogService.cleanOperLog()`进行清空，并返回操作结果。



#### 4.1 程序描述
该程序是一个操作日志记录表的领域模型类，用于表示系统中的操作日志信息，包括操作人员、操作时间、操作模块等。

#### 4.2 功能
主要功能包括：
- 记录系统中的操作日志信息
- 包含操作人员、操作时间、操作模块等属性

#### 4.3 输入项（输入接口）
- 无

#### 4.4 输出项（输出接口）
- 无

#### 4.5 属性详细描述
- `operId`: 操作日志的主键
- `title`: 操作模块
- `businessType`: 业务类型（0其它 1新增 2修改 3删除）
- `businessTypes`: 业务类型数组
- `method`: 请求方法
- `requestMethod`: 请求方式
- `operatorType`: 操作类别（0其它 1后台用户 2手机端用户）
- `operName`: 操作人员
- `deptName`: 部门名称
- `operUrl`: 请求url
- `operIp`: 操作地址
- `operLocation`: 操作地点
- `operParam`: 请求参数
- `jsonResult`: 返回参数
- `status`: 操作状态（0正常 1异常）
- `errorMsg`: 错误消息
- `operTime`: 操作时间
- `costTime`: 消耗时间

#### 4.6 方法详细描述及实现流程
- 无

#### 4.7 类内、类外方法调用状态图
- 未提供相关信息，可以根据具体情况补充。

#### 4.8 限制条件及出错处理
- 无



### 5 程序设计说明

#### 5.1 程序描述
该程序是一个Spring Boot Web应用的Controller类，负责处理系统中与个人信息相关的业务请求，包括查看个人信息、修改用户资料、重置密码、上传头像等功能。

#### 5.2 功能
主要功能包括：
- 查看个人信息
- 修改用户资料
- 重置密码
- 头像上传

#### 5.3 输入项（输入接口）
- 通过HTTP请求接收前端传递的参数，包括用户信息、密码、头像文件等。

#### 5.4 输出项（输出接口）
- 通过HTTP响应返回处理结果，以JSON格式包括操作成功与否、错误信息等。

#### 5.5 方法详细描述及实现流程

##### `profile()`
- **描述：** 获取当前登录用户的个人信息，包括基本信息、角色信息、岗位信息。
- **实现流程：**
  - 调用`getLoginUser()`获取当前登录用户信息。
  - 调用`userService.selectUserRoleGroup()`和`userService.selectUserPostGroup()`获取用户的角色组和岗位组。
  - 构造返回的`AjaxResult`对象，包含用户基本信息、角色组、岗位组。

##### `updateProfile(@RequestBody SysUser user)`
- **描述：** 修改当前登录用户的个人信息，包括昵称、邮箱、手机号、性别。
- **实现流程：**
  - 调用`getLoginUser()`获取当前登录用户信息。
  - 将传入的`SysUser`对象中的信息更新到当前用户信息中。
  - 检查手机号和邮箱是否唯一，若不唯一则返回错误信息。
  - 调用`userService.updateUserProfile()`更新用户个人信息。
  - 若更新成功，更新缓存中的用户信息。

##### `updatePwd(String oldPassword, String newPassword)`
- **描述：** 重置当前登录用户的密码。
- **实现流程：**
  - 调用`getLoginUser()`获取当前登录用户信息。
  - 检查旧密码是否正确，不正确则返回错误信息。
  - 检查新密码是否与旧密码相同，相同则返回错误信息。
  - 使用`SecurityUtils.encryptPassword()`加密新密码。
  - 调用`userService.resetUserPwd()`更新用户密码。
  - 若更新成功，更新缓存中的用户密码。

##### `avatar(@RequestParam("avatarfile") MultipartFile file)`
- **描述：** 上传用户头像。
- **实现流程：**
  - 调用`getLoginUser()`获取当前登录用户信息。
  - 调用`FileUploadUtils.upload()`上传头像文件到指定目录，获取头像路径。
  - 调用`userService.updateUserAvatar()`更新用户头像信息。
  - 若更新成功，更新缓存中的用户头像，并返回头像路径。

#### 5.6 类内、类外方法调用状态图
- 未提供相关信息，可以根据具体情况补充。

#### 5.7 限制条件及出错处理
- 若操作失败，返回相应的错误信息，具体错误信息会包含在`AjaxResult`中。

| 属性名        | 类型      | 说明                                    |
| ------------- | --------- | --------------------------------------- |
| operId        | Long      | 操作日志的主键                          |
| title         | String    | 操作模块                                |
| businessType  | Integer   | 业务类型（0其它 1新增 2修改 3删除）     |
| businessTypes | Integer[] | 业务类型数组                            |
| method        | String    | 请求方法                                |
| requestMethod | String    | 请求方式                                |
| operatorType  | Integer   | 操作类别（0其它 1后台用户 2手机端用户） |
| operName      | String    | 操作人员                                |
| deptName      | String    | 部门名称                                |
| operUrl       | String    | 请求url                                 |
| operIp        | String    | 操作地址                                |
| operLocation  | String    | 操作地点                                |
| operParam     | String    | 请求参数                                |
| jsonResult    | String    | 返回参数                                |
| status        | Integer   | 操作状态（0正常 1异常）                 |
| errorMsg      | String    | 错误消息                                |
| operTime      | Date      | 操作时间                                |
| costTime      | Long      | 消耗时间（毫秒）                        |





