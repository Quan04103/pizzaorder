import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:location/location.dart';

void main() {
  runApp(const MaterialApp(
      debugShowCheckedModeBanner: false, home: FullMapTest()));
}

class FullMapTest extends StatefulWidget {
  const FullMapTest({super.key});

  @override
  State createState() => FullMapTestState();
}

class FullMapTestState extends State<FullMapTest> {
  @override
  void initState() {
    super.initState();
    determinePosition();
    updateCircleAnnotation();
    getEnd('Huflit quận 10').then((_) {
      if (endPlace.isNotEmpty) {
        selectPlace(endPlace[0]);
      }
    });
  }

  MapboxMap? mapboxMap;
  CircleAnnotationManager? _circleAnnotationManagerStart;
  CircleAnnotationManager? _circleAnnotationManagerEnd;

  PointAnnotationManager? _pointAnnotationManager;

  String start = "";
  String end = "";
  String duration = "";
  String distance = "";

  double? lngStart;
  double? latStart;
  double? lngEnd;
  double? latEnd;

  bool isShowStart = false;
  bool isShowEnd = false;
  bool isHidden = true;

  List<dynamic> startPlace = [];
  List<dynamic> startDetails = [];
  List<dynamic> endPlace = [];
  List<dynamic> endDetails = [];
  int startLength = 0;
  int endLength = 0;

  final TextEditingController _searchStart = TextEditingController();
  final TextEditingController _searchEnd = TextEditingController();

  PolylinePoints polylinePoints = PolylinePoints();

  final Location location = Location();

  Future<void> determinePosition() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    // Kiểm tra xem dịch vụ vị trí có được bật không.
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      // Nếu không, yêu cầu bật dịch vụ vị trí.
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    // Kiểm tra quyền truy cập vị trí.
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      // Nếu quyền bị từ chối, yêu cầu quyền.
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    // Lấy vị trí hiện tại.
    LocationData locationData = await location.getLocation();

    location.onLocationChanged.listen((LocationData currentLocation) {
      print(
          "Vị trí hiện tại: Lat: ${currentLocation.latitude}, Long: ${currentLocation.longitude}");
    });
    print(
        "Vị trí hiện tại: Lat: ${locationData.latitude}, Long: ${locationData.longitude}");
  }

  _onMapCreated(MapboxMap mapboxMap) async {
    this.mapboxMap = mapboxMap;
  }

  Future<void> getStart(String input) async {
    try {
      final url = Uri.parse(
          'https://rsapi.goong.io/Place/AutoComplete?api_key=IcniA2Z5Cpx1HXx0rMUj0L0kRro6hQ1uOkP1cuvV&input=$input');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        setState(() {
          startPlace = jsonResponse['predictions'] as List<dynamic>;
          print(startPlace.toString());
          _circleAnnotationManagerStart?.deleteAll();
          isShowStart = true;
        });
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Widget _buildListStart() {
    return ListView.builder(
      itemCount: startPlace.length,
      itemBuilder: (context, index) {
        final coordinate = startPlace[index];

        return ListTile(
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(
                Icons.location_on_outlined,
                color: Colors.blue,
              ),
              SizedBox(
                width: 330,
                height: 30,
                child: Text(
                  coordinate['description'],
                  softWrap: true,
                ),
              )
            ],
          ),
          onTap: () async {
            setState(() {
              isShowStart = false;
            });

            final url = Uri.parse(
                'https://rsapi.goong.io/geocode?address=${coordinate['description']}&api_key=IcniA2Z5Cpx1HXx0rMUj0L0kRro6hQ1uOkP1cuvV');
            var response = await http.get(url);
            final jsonResponse = jsonDecode(response.body);
            startDetails = jsonResponse['results'] as List<dynamic>;

            mapboxMap?.setCamera(CameraOptions(
                center: Point(
                    coordinates: Position(
                        startDetails[0]['geometry']['location']['lng'],
                        startDetails[0]['geometry']['location']['lat'])),
                zoom: 12.0));
            mapboxMap?.flyTo(
                CameraOptions(
                    anchor: ScreenCoordinate(x: 0, y: 0),
                    zoom: 15,
                    bearing: 0,
                    pitch: 0),
                MapAnimationOptions(duration: 2000, startDelay: 0));
            mapboxMap?.annotations
                .createCircleAnnotationManager()
                .then((value) async {
              setState(() {
                _circleAnnotationManagerStart = value;
                lngStart = startDetails[0]['geometry']['location']['lng'];
                latStart = startDetails[0]['geometry']['location']['lat'];
              });

              value.create(
                CircleAnnotationOptions(
                  geometry: Point(
                      coordinates: Position(
                    startDetails[0]['geometry']['location']['lng'],
                    startDetails[0]['geometry']['location']['lat'],
                  )),
                  circleColor: Colors.purple.value,
                  circleRadius: 12.0,
                ),
              );
            });
            _searchStart.text = coordinate['description'];
          },
        );
      },
    );
  }

  Future<void> getEnd(String input) async {
    try {
      final url = Uri.parse(
          'https://rsapi.goong.io/Place/AutoComplete?api_key=IcniA2Z5Cpx1HXx0rMUj0L0kRro6hQ1uOkP1cuvV&input=$input');
      var response = await http.get(url);
      final jsonResponse = jsonDecode(response.body);

      setState(() {
        endPlace = jsonResponse['predictions'] as List<dynamic>;
        _circleAnnotationManagerEnd?.deleteAll();
        isShowEnd = true;
      });
    } catch (e) {
      print('$e');
    }
  }

  void selectPlace(dynamic coordinate) async {
    setState(() {
      isShowEnd = false;
    });

    final url = Uri.parse(
        'https://rsapi.goong.io/geocode?address=${coordinate['description']}&api_key=IcniA2Z5Cpx1HXx0rMUj0L0kRro6hQ1uOkP1cuvV');
    var response = await http.get(url);
    final jsonResponse = jsonDecode(response.body);
    endDetails = jsonResponse['results'] as List<dynamic>;

    mapboxMap?.setCamera(CameraOptions(
        center: Point(
            coordinates: Position(endDetails[0]['geometry']['location']['lng'],
                endDetails[0]['geometry']['location']['lat'])),
        zoom: 12.0));

    // mapboxMap?.flyTo(
    //     CameraOptions(
    //         anchor: ScreenCoordinate(x: 0, y: 0),
    //         zoom: 15,
    //         bearing: 0,
    //         pitch: 0),
    //     MapAnimationOptions(duration: 2000, startDelay: 0));
    // mapboxMap?.annotations.createCircleAnnotationManager().then((value) async {
    //   setState(() {
    //     _circleAnnotationManagerEnd = value;
    //     lngEnd = endDetails[0]['geometry']['location']['lng'];
    //     latEnd = endDetails[0]['geometry']['location']['lat'];
    //   });

    //   value.create(
    //     CircleAnnotationOptions(
    //       geometry: Point(
    //           coordinates: Position(
    //         endDetails[0]['geometry']['location']['lng'],
    //         endDetails[0]['geometry']['location']['lat'],
    //       )),
    //       circleColor: Colors.purple.value,
    //       circleRadius: 12.0,
    //     ),
    //   );
    // });
    mapboxMap?.flyTo(
        CameraOptions(
            anchor: ScreenCoordinate(x: 0, y: 0),
            zoom: 15,
            bearing: 0,
            pitch: 0),
        MapAnimationOptions(duration: 2000, startDelay: 0));
    mapboxMap?.annotations.createPointAnnotationManager().then((value) async {
      setState(() {
        _pointAnnotationManager = value;
        lngEnd = endDetails[0]['geometry']['location']['lng'];
        latEnd = endDetails[0]['geometry']['location']['lat'];
      });
      Uint8List imageBytes =
          await loadImageFromAssets('assets/icons/deliveryman.png');
      value.create(
        PointAnnotationOptions(
          geometry: Point(
              coordinates: Position(
            endDetails[0]['geometry']['location']['lng'],
            endDetails[0]['geometry']['location']['lat'],
          )),
          image: imageBytes,
          iconSize: 1.5,
        ),
      );
    });
    _searchEnd.text = coordinate['description'];
  }

  //Hàm giúp load ảnh từ assets thành Uint8List để sử dụng trong Mapbox
  Future<Uint8List> loadImageFromAssets(String path) async {
    final ByteData data = await rootBundle.load(path);
    final Uint8List bytes = data.buffer.asUint8List();
    return bytes;
  }

  Future<void> updateCircleAnnotation() async {
    LocationData? lastLocation;

    // Tải imageBytes một lần
    Uint8List imageBytes =
        await loadImageFromAssets('assets/icons/deliveryman.png');

    location.onLocationChanged.listen(
      (LocationData currentLocation) async {
        // Kiểm tra sự khác biệt vị trí đáng kể (ví dụ: 0.001 độ)
        if (lastLocation != null &&
            (lastLocation!.latitude! - currentLocation.latitude!).abs() <
                0.001 &&
            (lastLocation!.longitude! - currentLocation.longitude!).abs() <
                0.001) {
          // Nếu vị trí không thay đổi đáng kể, không cần cập nhật
          return;
        }

        // Cập nhật lastLocation với vị trí hiện tại
        lastLocation = currentLocation;

        _pointAnnotationManager ??=
            await mapboxMap?.annotations.createPointAnnotationManager();

        // Xóa tất cả PointAnnotation hiện có trước khi tạo mới
        if (_pointAnnotationManager != null) {
          await _pointAnnotationManager!.deleteAll();
        }

        // Tạo PointAnnotation mới với imageBytes đã tải
        _pointAnnotationManager?.create(
          PointAnnotationOptions(
            geometry: Point(
                coordinates: Position(
                    currentLocation.longitude!, currentLocation.latitude!)),
            image: imageBytes,
            iconSize: 1.5,
          ),
        );

        print(
            "Vị trí hiện tại: Lat: ${currentLocation.latitude}, Long: ${currentLocation.longitude}");
      },
    );
  }

  Widget _buildListEnd() {
    return ListView.builder(
      itemCount: endPlace.length,
      itemBuilder: (context, index) {
        final coordinate = endPlace[index];

        return ListTile(
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(
                Icons.location_on_outlined,
                color: Colors.blue,
              ),
              SizedBox(
                width: 330,
                height: 30,
                child: Text(
                  coordinate['description'],
                  softWrap: true,
                ),
              )
            ],
          ),
          onTap: () async {
            selectPlace(coordinate);
          },
        );
      },
    );
  }

  void getZoom() async {
    mapboxMap?.flyTo(
        CameraOptions(
          zoom: 13.0,
        ),
        MapAnimationOptions(duration: 2000, startDelay: 0));
  }

  void _fetchData() async {
    // location.onLocationChanged.listen((LocationData currentLocation) async {

    // });

    if (latStart != null &&
        lngStart != null &&
        latEnd != null &&
        lngEnd != null) {
      final url = Uri.parse(
          'https://rsapi.goong.io/Direction?origin=$latStart,$lngStart&destination=$latEnd,$lngEnd&vehicle=bike&api_key=IcniA2Z5Cpx1HXx0rMUj0L0kRro6hQ1uOkP1cuvV');

      mapboxMap?.setBounds(CameraBoundsOptions(
          bounds: CoordinateBounds(
              southwest: Point(
                  coordinates: Position(
                lngStart!,
                latStart!,
              )),
              northeast: Point(
                  coordinates: Position(
                lngEnd!,
                latEnd!,
              )),
              infiniteBounds: true),
          maxZoom: 13,
          minZoom: 0,
          maxPitch: 10,
          minPitch: 0));

      var response = await http.get(url);
      final jsonResponse = jsonDecode(response.body);
      var route = jsonResponse['routes'][0]['overview_polyline']['points'];
      duration = jsonResponse['routes'][0]['legs'][0]['duration']['text'];
      distance = jsonResponse['routes'][0]['legs'][0]['distance']['text'];
      List<PointLatLng> result = polylinePoints.decodePolyline(route);
      List<List<double>> coordinates =
          result.map((point) => [point.longitude, point.latitude]).toList();

      String geojson = '''{
      "type": "FeatureCollection",
      "features": [
        {
          "type": "Feature",
          "properties": {
            "name": "Crema to Council Crest"
          },
          "geometry": {
            "type": "LineString",
            "coordinates": $coordinates
          }
        }
      ]
    }''';

      await mapboxMap?.style
          .addSource(GeoJsonSource(id: "line", data: geojson));
      var lineLayerJson = """{
     "type":"line",
     "id":"line_layer",
     "source":"line",
     "paint":{
     "line-join":"round",
     "line-cap":"round",
     "line-color":"rgb(51, 51, 255)",
     "line-width":5.0
     }
     }""";

      await mapboxMap?.style.addPersistentStyleLayer(lineLayerJson, null);
    }
    setState(() {
      isHidden = false;
    });
  }

  void removeLayer() async {
    if (mapboxMap != null && mapboxMap?.style != null) {
      try {
        await mapboxMap?.style.removeStyleLayer("line_layer");
        await mapboxMap?.style.removeStyleSource("line");
      } catch (e) {
        if (e is PlatformException &&
            e.message!.contains('Layer line_layer does not exist')) {
          print('Layer does not exist, cannot remove');
        } else {
          rethrow;
        }
      }
    } else {
      print('Mapbox map or style is null, cannot remove layer or source');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        SizedBox(
          child: MapWidget(
            key: const ValueKey("mapWidget"),
            cameraOptions: CameraOptions(
                center: Point(coordinates: Position(105.83991, 21.02800)),
                zoom: 14.0),
            styleUri: MapboxStyles.MAPBOX_STREETS,
            textureView: true,
            onMapCreated: _onMapCreated,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Container(
              height: 80,
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              decoration: BoxDecoration(color: Colors.grey[200]),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            padding: const EdgeInsets.only(left: 12),
                            decoration:
                                const BoxDecoration(color: Colors.white),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.circle_outlined,
                                  color: Colors.purple,
                                  size: 20,
                                ),
                                Expanded(
                                    child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8, right: 8),
                                  child: TextField(
                                    controller: _searchStart,
                                    onChanged: (startText) {
                                      int currentStartLength = startText.length;

                                      if (startText.length >= 3 &&
                                          startText[0] != " " &&
                                          startText.contains(" ")) {
                                        setState(() {
                                          start = startText;
                                        });
                                        getStart(start);
                                      }
                                      isShowStart = true;
                                      if (currentStartLength != startLength) {
                                        removeLayer();
                                        setState(() {
                                          isHidden = true;
                                        });
                                      }
                                      startLength = currentStartLength;
                                    },
                                    onTap: () {
                                      getZoom();
                                    },
                                    decoration: const InputDecoration(
                                        hintText: "Địa chỉ của bạn",
                                        border: InputBorder.none,
                                        hintStyle: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 16)),
                                  ),
                                ))
                              ],
                            )),
                        const Padding(
                            padding: EdgeInsets.only(top: 5, bottom: 5)),
                        // Container(
                        //     padding: const EdgeInsets.only(left: 12),
                        //     decoration: const BoxDecoration(color: Colors.white),
                        //     child: Row(
                        //       children: [
                        //         const Icon(
                        //           Icons.location_on_outlined,
                        //           color: Colors.purple,
                        //         ),
                        //         Expanded(
                        //             child: Padding(
                        //           padding:
                        //               const EdgeInsets.only(left: 8, right: 8),
                        //           child: TextField(
                        //             controller: _searchEnd,
                        //             onChanged: (endText) {
                        //               int currentEndLength = endText.length;

                        //               if (endText.length >= 3) {
                        //                 setState(() {
                        //                   end = endText;
                        //                 });
                        //                 getEnd(end);
                        //               }
                        //               isShowEnd = true;
                        //               if (currentEndLength != endLength) {
                        //                 setState(() {
                        //                   isHidden = true;
                        //                 });
                        //                 removeLayer();
                        //               }
                        //               endLength = currentEndLength;
                        //             },
                        //             onTap: () {
                        //               getZoom();
                        //             },
                        //           ),
                        //         ))
                        //       ],
                        //     ))
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 10),
                    margin: const EdgeInsets.only(
                      left: 4,
                    ),
                    width: 50,
                    height: 100,
                    decoration: const BoxDecoration(),
                    child: IconButton(
                      iconSize: 40,
                      color: Colors.green[900],
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        _fetchData();
                      },
                    ),
                  )
                ],
              )),
        ),
        isShowStart
            ? Container(
                height: 120,
                margin: const EdgeInsets.fromLTRB(10, 75, 10, 0),
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                decoration: const BoxDecoration(color: Colors.white),
                child: _buildListStart(),
              )
            : const Card(),
        isShowEnd
            ? Container(
                height: 120,
                margin: const EdgeInsets.fromLTRB(10, 130, 10, 0),
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                decoration: const BoxDecoration(color: Colors.white),
                child: _buildListEnd(),
              )
            : const Card(),
        isHidden
            ? const Card()
            : Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    height: 200,
                    margin: const EdgeInsets.fromLTRB(0, 200, 0, 0),
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    alignment: Alignment.topLeft,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12))),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                      ),
                      child: ListView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const ImageIcon(
                                      AssetImage('assets/icons/pizza.png'),
                                      color: Colors.green,
                                      size: 30,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: Text(
                                        distance,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 20.0),
                                  child: Text(
                                    duration, // Giả sử thời gian là 15 phút
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Divider(
                            color: Colors.grey,
                            thickness: 1,
                            indent: 20,
                            endIndent: 20,
                          ),
                          const Padding(
                              padding: EdgeInsets.only(
                            top: 8,
                          )),
                          const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ImageIcon(
                                AssetImage('assets/icons/financial.png'),
                                color: Colors.green,
                                size: 30,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 15.0),
                                child: Text(
                                  'Tiền mặt',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: ElevatedButton(
                              onPressed: () {
                                // Thêm hành động khi nút được nhấn
                              },
                              style: ElevatedButton.styleFrom(
                                  alignment: Alignment.centerLeft,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  backgroundColor: Colors.green),
                              child: const Padding(
                                padding: EdgeInsets.only(left: 15.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Đặt hàng',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '100.000đ',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 10.0),
                                          child: ImageIcon(
                                            AssetImage(
                                                'assets/icons/arrow.png'),
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
      ],
    ));
  }
}
