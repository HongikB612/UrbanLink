import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:urbanlink_project/pages/postpage/postspage.dart';
import 'dart:async';
import 'package:get/get.dart';
import 'package:urbanlink_project/services/auth.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  TextEditingController textController = TextEditingController();

  late GoogleMapController mapController;
  final List<Marker> _markers = [];
  LatLng displayLocation = const LatLng(37.552635722509, 126.92436042413);

  @override
  void initState() {
    super.initState();
    addMarkers();
  }

  Future<void> _searchLocation(String query) async {
    try {
      List<Location> locations = await locationFromAddress(query);

      if (locations.isNotEmpty) {
        final LatLng newCenter =
            LatLng(locations.first.latitude, locations.first.longitude);

        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: newCenter,
              zoom: 11.0,
            ),
          ),
        );

        setState(() {
          displayLocation = newCenter;
        });
      }
    } catch (e) {
      logger.e(e);
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  addMarkers() async {
    BitmapDescriptor customMarkerIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(
        size: Size(120, 80),
      ),
      'assets/images/blueround.png',
    );
    _markers.add(Marker(
      markerId: const MarkerId("1"),
      onTap: () => {
        logger.i("1"),
        Get.to(const PostsPage()),
      },
      position: const LatLng(37.552635722509, 126.92436042413),
      icon: customMarkerIcon,
      alpha: 0.4,
    ));
    _markers.add(Marker(
      markerId: const MarkerId("2"),
      onTap: () => {
        logger.i("2"),
        Get.to(const PostsPage()),
      },
      position: const LatLng(37.565643683342, 126.95524147826),
      icon: customMarkerIcon,
      alpha: 0.4,
    ));
    _markers.add(Marker(
      markerId: const MarkerId("3"),
      onTap: () => {
        logger.i("3"),
        Get.to(const PostsPage()),
      },
      position: const LatLng(37.495172947072, 126.95453489844),
      icon: customMarkerIcon,
      alpha: 0.4,
    ));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              //innital position in map
              target: displayLocation, //initial position
              zoom: 12.0, //initial zoom level
            ),
            markers: Set.from(_markers),
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
    );
  }
}
