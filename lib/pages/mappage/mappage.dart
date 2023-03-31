import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'dart:async';
import 'package:urbanlink_project/services/auth.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _AnimateGroupOfMarkersDynamicallyState();
}

class _AnimateGroupOfMarkersDynamicallyState extends State<MapPage>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  late CurvedAnimation _animation;
  late MapTileLayerController _tileLayerController;

  late MapZoomPanBehavior _zoomPanBehavior;

  late Map<String, MapLatLng> _markers;

  List<int> _selectedMarkerIndices = [];
  TextEditingController textController = TextEditingController();
  @override
  void initState() {
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 750),
        reverseDuration: const Duration(milliseconds: 750));
    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.easeOutBack);
    _tileLayerController = MapTileLayerController();

    _zoomPanBehavior = MapZoomPanBehavior()
      ..zoomLevel = 12
      ..focalLatLng = const MapLatLng(37.565643683342, 126.95524147826)
      ..toolbarSettings = const MapToolbarSettings();

    _markers = <String, MapLatLng>{
      'Sogu': const MapLatLng(37.552635722509, 126.92436042413),
      'Mapo': const MapLatLng(37.565643683342, 126.95524147826),
      'SangSu': const MapLatLng(37.495172947072, 126.95453489844),
      'GanAk0': const MapLatLng(37.47538611, 126.9538444),
      'GanAk1': const MapLatLng(37.53573889, 127.0845333),
      'GanAk2': const MapLatLng(37.49265, 126.8895972),
      'GanAk3': const MapLatLng(37.44910833, 126.9041972),
      'Chad': const MapLatLng(15.454166, 18.732206),
      'Nigeria': const MapLatLng(9.081999, 8.675277),
      'DRC': const MapLatLng(-4.038333, 21.758663),
      'CAR': const MapLatLng(6.600281, 20.480205),
      'Sudan': const MapLatLng(12.862807, 30.217636),
      'Kenya': const MapLatLng(0.0236, 37.9062),
      'Zambia': const MapLatLng(-10.974129, 30.861397),
      'Egypt': const MapLatLng(25.174109, 28.776359),
      'Algeria': const MapLatLng(24.276672, 7.308186),
    };

    _controller.repeat(min: 0.1, max: 1.0, reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _controller.stop();
    _controller.dispose();
    _markers.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isbuttonPressed = false;
    return Scaffold(
      appBar: AppBar(title: const Text('Map Page')),
      body: Stack(
        children: [
          SfMaps(layers: [
            MapTileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              initialZoomLevel: 13,
              initialFocalLatLng:
                  const MapLatLng(37.565643683342, 126.95524147826),
              controller: _tileLayerController,
              initialMarkersCount: _markers.length,
              zoomPanBehavior: _zoomPanBehavior,
              markerBuilder: (BuildContext context, int index) {
                final double size =
                    _selectedMarkerIndices.contains(index) ? 400 : 300;
                final MapLatLng markerLatLng = _markers.values.elementAt(index);
                Widget current = Icon(Icons.circle,
                    color: isbuttonPressed
                        ? Colors.pinkAccent.withOpacity(0.5)
                        : Colors.lightBlueAccent.withOpacity(0.5),
                    size: size);
                return MapMarker(
                  latitude: markerLatLng.latitude,
                  longitude: markerLatLng.longitude,
                  child: GestureDetector(
                    child: Transform.translate(
                      offset: Offset(0.0, -size / 2),
                      child: _selectedMarkerIndices.contains(index)
                          ? ScaleTransition(
                              alignment: Alignment.bottomCenter,
                              scale: _animation,
                              child: current)
                          : current,
                    ),
                  ),
                );
              },
            ),
          ]),
          Positioned(
            top: 5,
            right: 15,
            left: 15,
            child: AnimSearchBar(
              width: MediaQuery.of(context).size.width,
              textController: textController,
              onSuffixTap: () {
                setState(() {
                  textController.clear();
                });
              },
              onSubmitted: (String searchQuery) {
                _searchLocation(searchQuery);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: GestureDetector(
        child: FloatingActionButton(
          child: const Icon(Icons.animation),
          onPressed: () {
            setState(() {
              isbuttonPressed = !isbuttonPressed;
            });
            _selectedMarkerIndices = [0, 2, 4, 12];
            _tileLayerController.updateMarkers(_selectedMarkerIndices);
            _controller.forward(from: 0.2);
          },
        ),
      ),
    );
  }

  Future<void> _searchLocation(String query) async {
    try {
      List<Location> locations = await locationFromAddress(query);
      if (locations.isNotEmpty) {
        final LatLng newCenter =
            LatLng(locations.first.latitude, locations.first.longitude);
        final focusLatLng = MapLatLng(newCenter.latitude, newCenter.longitude);

        setState(() {
          _tileLayerController.pixelToLatLng(
              Offset(focusLatLng.latitude, focusLatLng.longitude));
        });
      } else {
        setState(() {
          _tileLayerController
              .pixelToLatLng(const Offset(15.454166, 18.732206));
        });
      }
    } catch (e) {
      logger.e(e);
    }
  }
}
