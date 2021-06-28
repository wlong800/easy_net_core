

### route & channel
> route规则：wanmei:host/path?params1={}&params2=xxx
>  channel 

> 默认channel : all_future_flutter_method_plugin


1. (俩真一假) user_ttal_set?params={
                                                     "lieOption": _fakeController?.text,
                                                     "truthOption1": _real1Controller?.text,
               getNativeGlobalInfo

{
 "                                      "truthOption2": _real2Controller?.text
                                                   }


```
update成功后，把下边的数据回传给原生，通过 ->
channel: updateUserTTALData ->
{
                    "type": "TTAL",
                    "ttalQuestion": {
                      "lieOption": _fakeController?.text,
                      "truthOption1": _real1Controller?.text,
                      "truthOption2": _real2Controller?.text,
                    }
                  }
```

2. (给到flutter一些全局数据，比如appbar高度..) 
```
getNativeGlobalInfo ->
{
    "appBarHeight":80,
    "baseUrl":""
}

ios字典格式，android Map格式
```



### 重构1.0(网络库)-2021.6.26
1. 引入adapter模式，实现快速插拔
2. 模块分工进一步明确
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