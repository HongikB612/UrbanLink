import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:logger/logger.dart';

class LocationSearchbar extends StatefulWidget {
  final ValueChanged<String> onChanged;

  const LocationSearchbar({Key? key, required this.onChanged})
      : super(key: key);

  @override
  State<LocationSearchbar> createState() => _LocationSearchbarState();
}

class _LocationSearchbarState extends State<LocationSearchbar> {
  final List<String> _locationList = [];
  String _selectedLocation = '';

  Future<void> _searchLocation(String query) async {
    try {
      List<Location> locations = await locationFromAddress(query);

      List<String> locationList = [];
      for (var location in locations) {
        List<Placemark> placemarks = await placemarkFromCoordinates(
            location.latitude, location.longitude);
        for (var placemark in placemarks) {
          String formattedAddress =
              '${placemark.street}, ${placemark.subLocality}, ${placemark.locality}, ${placemark.country}';
          locationList.add(formattedAddress);
        }
      }

      setState(() {
        _locationList.clear();
        _locationList.addAll(locationList);
      });
    } catch (e) {
      Logger().e(e);
    }
  }

  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Search Location'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(
                  hintText: '위치를 입력하세요.',
                  icon: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.search),
                  ),
                ),
                keyboardType: TextInputType.text,
                onChanged: (text) {
                  _searchLocation(text);
                },
              ),
              const SizedBox(height: 16),
              Expanded(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _locationList.length,
                    itemBuilder: (BuildContext context, int index) {
                      final location = _locationList[index];

                      return ListTile(
                        title: Text(location),
                        onTap: () {
                          _selectLocation(context, location);
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _selectLocation(BuildContext context, String location) {
    setState(() {
      widget.onChanged(location);
      _selectedLocation = location;
    });
    // Perform action when a location is selected
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => _showSearchDialog(context),
          child: const Text('Search Location'),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '선택된 위치: $_selectedLocation',
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
