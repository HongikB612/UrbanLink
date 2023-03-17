import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'dart:async';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  TextEditingController textController = TextEditingController();

  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414
  );
  //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Map'),
        ),

        body: Stack(
          children: <Widget>[
            GoogleMap(
              mapType: MapType.terrain,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              initialCameraPosition: _kGooglePlex,
            //markers: Set<Marker>.of(markers.values)),
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
                onSubmitted: (String _) {},
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheHome,
        label: const Text('To the home!'),
        icon: const Icon(Icons.directions_boat),
      ),
    );
  }
  Future<void> _goToTheHome() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
