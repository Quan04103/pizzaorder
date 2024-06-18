import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

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
    getEnd('Huflit quận 10').then((_) {
      if (endPlace.isNotEmpty) {
        selectPlace(endPlace[0]);
      }
    });
  }

  MapboxMap? mapboxMap;
  CircleAnnotationManager? _circleAnnotationManagerStart;
  CircleAnnotationManager? _circleAnnotationManagerEnd;

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
                  circleColor: Colors.blue.value,
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

    mapboxMap?.flyTo(
        CameraOptions(
            anchor: ScreenCoordinate(x: 0, y: 0),
            zoom: 15,
            bearing: 0,
            pitch: 0),
        MapAnimationOptions(duration: 2000, startDelay: 0));
    mapboxMap?.annotations.createCircleAnnotationManager().then((value) async {
      setState(() {
        _circleAnnotationManagerEnd = value;
        lngEnd = endDetails[0]['geometry']['location']['lng'];
        latEnd = endDetails[0]['geometry']['location']['lat'];
      });

      value.create(
        CircleAnnotationOptions(
          geometry: Point(
              coordinates: Position(
            endDetails[0]['geometry']['location']['lng'],
            endDetails[0]['geometry']['location']['lat'],
          )),
          circleColor: Colors.red.value,
          circleRadius: 12.0,
        ),
      );
    });
    _searchEnd.text = coordinate['description'];
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
     "line-width":9.0
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
        appBar: AppBar(
          title: const Text('Direction'),
        ),
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
            Container(
                height: 120,
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
                                    color: Colors.blue,
                                    size: 20,
                                  ),
                                  Expanded(
                                      child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    child: TextField(
                                      controller: _searchStart,
                                      onChanged: (startText) {
                                        int currentStartLength =
                                            startText.length;

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
                                          // removeLayer();
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
                          Container(
                              padding: const EdgeInsets.only(left: 12),
                              decoration:
                                  const BoxDecoration(color: Colors.white),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.location_on_outlined,
                                    color: Colors.blue,
                                  ),
                                  Expanded(
                                      child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    child: TextField(
                                      controller: _searchEnd,
                                      onChanged: (endText) {
                                        int currentEndLength = endText.length;

                                        if (endText.length >= 3) {
                                          setState(() {
                                            end = endText;
                                          });
                                          getEnd(end);
                                        }
                                        isShowEnd = true;
                                        if (currentEndLength != endLength) {
                                          setState(() {
                                            isHidden = true;
                                          });
                                          // removeLayer();
                                        }
                                        endLength = currentEndLength;
                                      },
                                      onTap: () {
                                        getZoom();
                                      },
                                    ),
                                  ))
                                ],
                              ))
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        left: 4,
                      ),
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(),
                      child: IconButton(
                        iconSize: 40,
                        color: Colors.blue[900],
                        icon: const Icon(Icons.directions),
                        onPressed: () {
                          _fetchData();
                        },
                      ),
                    )
                  ],
                )),
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
                        height: 100,
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
                              left: 16, right: 16, top: 10),
                          child: ListView(
                            children: [
                              RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text: duration,
                                    style: TextStyle(
                                        color: Colors.green[800],
                                        fontSize: 18)),
                                TextSpan(
                                    text: ' ($distance)',
                                    style: const TextStyle(
                                        color: Colors.black87, fontSize: 18)),
                              ])),
                              const Padding(
                                  padding: EdgeInsets.only(
                                top: 8,
                              )),
                              const Text(
                                'Ở tình trạng giao thông hiện tại thì đây là tuyến đường nhanh nhất',
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 16),
                              ),
                            ],
                          ),
                        )),
                  ),
          ],
        ));
  }
}
