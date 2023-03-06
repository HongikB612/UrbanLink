import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:urbanlink_project/services/auth.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  TextEditingController textController = TextEditingController();
  late GoogleMapController mapController;

  LatLng _center = const LatLng(37.7, 126.6);

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  // created method for getting user current location
  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      logger.e(error, stackTrace.toString());
    });
    return await Geolocator.getCurrentPosition();
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
              target: _center,
              zoom: 11.0,
            ),
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
              onSubmitted: (String value) {
                _searchLocation(value);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _searchLocation(String value) async {
    try {
      List<Location> locations = await locationFromAddress(value);
      if (locations.isNotEmpty) {
        final LatLng newCenter =
            LatLng(locations.first.latitude, locations.first.longitude);

        mapController.animateCamera(CameraUpdate.newLatLng(newCenter));
        setState(() {
          _center = newCenter;
        });
      }
    } on PlatformException catch (e) {
      logger.e(e);
    } catch (e) {
      logger.e(e);
    }
  }
}
