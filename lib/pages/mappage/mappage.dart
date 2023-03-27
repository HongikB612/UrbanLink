
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:urbanlink_project/pages/postpage/postspage.dart';
import 'dart:async';
import 'package:get/get.dart';
import 'package:urbanlink_project/services/auth.dart';
import 'package:urbanlink_project/widgets/location_drawer_widget.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class MapPage extends StatefulWidget {
  @override
  _AnimateGroupOfMarkersDynamicallyState createState() =>
      _AnimateGroupOfMarkersDynamicallyState();
}

class _AnimateGroupOfMarkersDynamicallyState extends State<MapPage> with TickerProviderStateMixin {
  late AnimationController _controller;

  late CurvedAnimation _animation;
  late MapTileLayerController _tileLayerController;

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

    _markers = <String, MapLatLng>{
      'Chad': MapLatLng(15.454166, 18.732206),
      'Nigeria': MapLatLng(9.081999, 8.675277),
      'DRC': MapLatLng(-4.038333, 21.758663),
      'CAR': MapLatLng(6.600281, 20.480205),
      'Sudan': MapLatLng(12.862807, 30.217636),
      'Kenya': MapLatLng(0.0236, 37.9062),
      'Zambia': MapLatLng(-10.974129, 30.861397),
      'Egypt': MapLatLng(25.174109, 28.776359),
      'Algeria': MapLatLng(24.276672, 7.308186),
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
    bool selected = false;
    return Scaffold(
      appBar: AppBar(title: Text('Animate group of markers dynamically')),
      endDrawer: const LocationDrawerWidget(),
      body: Stack(
        children: [
          MapTileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            initialZoomLevel: 3,
            initialFocalLatLng: MapLatLng(2.3104, 16.5581),
            controller: _tileLayerController,
            initialMarkersCount: _markers.length,
            zoomPanBehavior: MapZoomPanBehavior(enableMouseWheelZooming: true, showToolbar: true,),
            markerBuilder: (BuildContext context, int index) {
              final double size = _selectedMarkerIndices.contains(index) ? 40 : 25;
              final MapLatLng markerLatLng = _markers.values.elementAt(index);
              Widget current = Icon(Icons.circle, color: isbuttonPressed ? Colors.pinkAccent.withOpacity(0.5) : Colors.lightBlueAccent.withOpacity(0.5), size: size);
              return MapMarker(
                latitude: markerLatLng.latitude,
                longitude: markerLatLng.longitude,
                child: GestureDetector(
                  onTap: () {
                    selected = true;
                  },
                  child: selected ? Transform.translate(
                    offset: Offset(0.0, -size),
                    child: _selectedMarkerIndices.contains(index)
                        ? ScaleTransition(
                        alignment: Alignment.bottomCenter,
                        scale: _animation,
                        child: current)
                        : current,
                  ) :
                  Transform.translate(
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
          child: Icon(Icons.animation),
          onPressed: () {
            setState(() {
              isbuttonPressed = !isbuttonPressed;
            });
            _selectedMarkerIndices = [0, 2, 4];
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
          _tileLayerController.pixelToLatLng(Offset(focusLatLng.latitude, focusLatLng.longitude));
        });
      }
      else {
        setState(() {
          _tileLayerController.pixelToLatLng(Offset(15.454166, 18.732206));
        });
      }
    } catch (e) {
      logger.e(e);
    }
  }
}
