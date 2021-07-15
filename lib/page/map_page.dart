
import 'package:amap_flutter_map/amap_flutter_map.dart';
import 'package:amap_flutter_base/amap_flutter_base.dart';
import 'package:app/base/logger/logger.dart';
import 'package:flutter/material.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  _onMapCreated(AMapController controller) {
    logger("_onMapCreated : ${controller.mapId}");
  }

  @override
  Widget build(BuildContext context) {
    ///使用默认属性创建一个地图
    final AMapWidget map = AMapWidget(
      apiKey: AMapApiKey(
          androidKey: "03f40ef02ea5c3940552963280e752b3", iosKey: "03f40ef02ea5c3940552963280e752b3"),
      onMapCreated: _onMapCreated,
    );
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: map,
    );
  }
}
