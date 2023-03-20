import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:location/location.dart' as loc;

class LocationSearchDialog extends StatefulWidget {
  final loc.LocationData? currentLocation;
  final ValueChanged<String> onSelected;

  const LocationSearchDialog(
      {super.key, this.currentLocation, required this.onSelected});

  @override
  State<LocationSearchDialog> createState() => _LocationSearchDialogState();
}

class _LocationSearchDialogState extends State<LocationSearchDialog> {
  late GoogleMapsPlaces _places;
  late TextEditingController _searchController;
  late FocusNode _searchFocusNode;

  @override
  void initState() {
    super.initState();
    _places = GoogleMapsPlaces(apiKey: "YOUR_API_KEY");
    _searchController = TextEditingController();
    _searchFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _places.dispose();
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  Future<void> _showPlacePicker() async {
    final currentLocation = await loc.Location().getLocation();
    final result = await PlacesAutocomplete.show(
      context: context,
      apiKey: 'AIzaSyCA6eLlZg1DQdmgWzQ3KfN7GtaY48iW9Zc',
      location: Location(
        lat: currentLocation.latitude!,
        lng: currentLocation.longitude!,
      ),
      radius: 10000,
      language: "kr",
      mode: Mode.fullscreen,
      types: [],
    );
    if (result != null && result.placeId != null) {
      final placeDetails = await _places.getDetailsByPlaceId(result.placeId!);
      widget.onSelected(placeDetails.result.formattedAddress!);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("검색"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: const InputDecoration(hintText: "주소를 입력하세요"),
            controller: _searchController,
            focusNode: _searchFocusNode,
            onTap: () async {
              _searchFocusNode.requestFocus();
              _showPlacePicker();
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("취소"),
        ),
      ],
    );
  }
}
