

### route & channel篇
> **默认channel : all_future_flutter_method_plugin**

> route规则：wanmei://host/path?params1={}&params2=xxx

> eg.  wmactivity://user_ttal_set?params={"lieOption": "text1","truthOption1": "text2","truthOption2": "text3"}

scheme | host | path | queryParameters
--|--|--|--
wmactivity | user_ttal_set | null | {"lieOption": "text1","truthOption1": "text2","truthOption2": "text3"}

 

1. 端上启动flutter，需要按router规则进入相应的页面，如下：

router(host) | requestParams | responseChannel | responseData | 备注
---|---|---|---|---
user_ttal_set | {"lieOption": "text1","truthOption1": "text2","truthOption2": "text3"} | updateUserTTALData | {"type":"TTAL","ttalQuestion":{"lieOption":"t1", "truthOption1":"t2", "truthOption2":"t3"}} | 俩真一假
contacts_list |  |  |  | 购票联系人列表
contacts_add |  |  |  | 新增购票联系人
report |  |  |  | 举报页面

2. 端上注册 flutter调用

nativeRegisterChannel | flutterPullDataByChannel | flutterPushDataByChannel | 备注
---|---|---|---|---
getNativeGlobalInfo |  | {"appBarHeight":80.0,"baseUrl":""} | 全局的一些属性，会在启动的时候调用，需要端上准备好
getPlatformHeaders | {"url": "url","method": "post/get", "contentType": "json","requestBody": {"key","value"}} | {"ax":""} | 需要把端上的header数据都带过来，特别是ax,否则报401

### API篇

1. ConfigManager （全局）
2. EasyNetApi（网络请求） 
3. 

### 项目架构篇

```
lib
├── base
    ├── api(网络库)
    ├── common(不区分项目，任何项目都可能用到的一些东西)-有点不明确还是
    ├── hold(封装的工具类->轻量级本地数据保存)
    ├── logger(封装的工具类->日志管理)
    ├── utils(和common有点冲突，但是感觉有必要这么划分，再思考思考)
    └── widgets(通用的一些控件，这个库比较重要，作为一个UI沉淀库，要不断完善，写一个demo，否则会重复写一些控件)
├── services(服务，负责去拿数据，可以是服务器的过来的数据，也可以是本地的数据)
├── page(ui层面)
├── provider(基于provider这个库，做一个封装，方便page层使用)
└── test(写一些测试demo,比如widgets通用控件有哪些)
```

- #### 重构1.0(网络库)-2021.6.26
1. 引入adapter模式，实现快速插拔
2. 模块分工进一步明确
