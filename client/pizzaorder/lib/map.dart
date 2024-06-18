import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class FullMap extends StatefulWidget {
  const FullMap({super.key});

  @override
  State createState() => FullMapState();
}

class FullMapState extends State<FullMap> {
  MapboxMap? mapboxMap;
  static Position center = Position(106.637250, 10.868578);
  static Position destination = Position(106.637250, 10.868578);

  _trackingMode(){
    
  }


  _onMapCreated(MapboxMap mapboxMap) {
    this.mapboxMap = mapboxMap;
    _addMarker(mapboxMap);
  }

  _addMarker(MapboxMap mapboxMap) {
    mapboxMap.annotations
        .createPointAnnotationManager()
        .then((pointAnnotationManager) async {
      final ByteData bytes = await rootBundle.load('assets/icons/marker.png');
      final Uint8List list = bytes.buffer.asUint8List();
      var options = <PointAnnotationOptions>[];
      for (var i = 0; i < 5; i++) {
        options.add(
          PointAnnotationOptions(
            geometry: Point(
              coordinates: center,
            ),
            image: list,
            iconSize: 0.3,
          ),
        );
      }
      pointAnnotationManager.createMulti(options);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: MapWidget(
      key: const ValueKey("mapWidget"),
      cameraOptions: CameraOptions(
        center: Point(coordinates: Position(106.637250, 10.868578)),
        zoom: 16.0,
      ),
      onMapCreated: _onMapCreated,
    ));
  }
}
