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
  List<String> fakeLocations = ["서울 마포구 창천동", "서울 마포구 동교동", "서울 서대문구 창천동", "서울 마포구 서강동", "서울 마포구 노고산동", "서울 마포구 서교동", "서울 마포구 상수동", "서울 마포구 신수동", "서울 마포구 구수동", "서울 마포구 하중동", "서울 마포구 신정동", "서울 마포구 대흥동", "서울 마포구 연남동", "서울 마포구 현석동", "서울 마포구 당인동", "서울 마포구 용강동", "서울 서대문구 대현동", "서울 서대문구 신촌동", "서울 마포구 염리동", "서울 서대문구 대신동", "서울 마포구 토정동", "서울 마포구 망원제1동", "서울 마포구 합정동", "서울 마포구 성산제1동"];
  late GoogleMapController _mapController;
  final List<Marker> _markers = [];
  LatLng _displayLocation = const LatLng(37.552635722509, 126.92436042413);

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

        _mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: newCenter,
              zoom: 11.0,
            ),
          ),
        );

        setState(() {
          _displayLocation = newCenter;
        });
      }
    } catch (e) {
      logger.e(e);
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _mapController = controller;
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
        Get.to(const PostsPage(), arguments: "서울 마포구 서교동"),
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
      backgroundColor: Colors.white38,
      appBar: AppBar(
        title: const Text('Map', style: TextStyle(color: Colors.white),),
        backgroundColor: const Color.fromARGB(250, 63, 186, 219),
        shadowColor: Colors.grey,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      endDrawer: Drawer(
          child: ListView.builder(
            itemCount: fakeLocations.length,
            itemBuilder: (c, i) => Card(
              child: ListTile(title: Text(fakeLocations[i]), onTap: (){Get.to(() => const PostsPage(), arguments: fakeLocations[i] ?? "location");},),
            ),
          )
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              //innital position in map
              target: _displayLocation, //initial position
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
