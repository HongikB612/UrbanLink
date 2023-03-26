import 'package:flutter/material.dart';
import 'package:urbanlink_project/services/auth.dart';

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

  List<String> fakeLocations = [
    "서울 마포구 창천동",
    "서울 마포구 동교동",
    "서울 서대문구 창천동",
    "서울 마포구 서강동",
    "서울 마포구 노고산동",
    "서울 마포구 서교동",
    "서울 마포구 상수동",
    "서울 마포구 신수동",
    "서울 마포구 구수동",
    "서울 마포구 하중동",
    "서울 마포구 신정동",
    "서울 마포구 대흥동",
    "서울 마포구 연남동",
    "서울 마포구 현석동",
    "서울 마포구 당인동",
    "서울 마포구 용강동",
    "서울 서대문구 대현동",
    "서울 서대문구 신촌동",
    "서울 마포구 염리동",
    "서울 서대문구 대신동",
    "서울 마포구 토정동",
    "서울 마포구 망원제1동",
    "서울 마포구 합정동",
    "서울 마포구 성산제1동"
  ];

  Future<void> _searchLocation(String query) async {
    try {
      List<String> results = [];
      results.addAll(fakeLocations);
      results.retainWhere(
          (location) => location.toLowerCase().contains(query.toLowerCase()));
      setState(() {
        _locationList.clear();
        _locationList.addAll(results);
      });
    } catch (e) {
      logger.e(e);
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
