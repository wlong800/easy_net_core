

### route & channel
1. route: user_ttal_set（调起俩真一假页面->UserTTALSetPage()）
>  channel 默认 all_future_flutter_method_plugin

```
update成功后，把下边的数据回传给原生，通过 ->
channel: updateUserTTALData
{
                    "type": "TTAL",
                    "ttalQuestion": {
                      "lieOption": _fakeController?.text,
                      "truthOption1": _real1Controller?.text,
                      "truthOption2": _real2Controller?.text,
                    }
                  }
```

