import 'package:flutter/material.dart';

class LocationSearchbar extends StatefulWidget {
  final ValueChanged<String> onChanged;

  const LocationSearchbar({Key? key, required this.onChanged})
      : super(key: key);

  @override
  State<LocationSearchbar> createState() => _LocationSearchbarState();
}

class _LocationSearchbarState extends State<LocationSearchbar> {
  List<String> searchResult = [];
  String _selectedLocation = '';

  List<String> fakeLocations = [
    "대한민국 서울시 마포구 창천동",
    "대한민국 서울시 마포구 동교동",
    "대한민국 서울시 서대문구 창천동",
    "대한민국 서울시 마포구 서강동",
    "대한민국 서울시 마포구 노고산동",
    "대한민국 서울시 마포구 서교동",
    "대한민국 서울시 마포구 상수동",
    "대한민국 서울시 마포구 신수동",
    "대한민국 서울시 마포구 구수동",
    "대한민국 서울시 마포구 하중동",
    "대한민국 서울시 마포구 신정동",
    "대한민국 서울시 마포구 대흥동",
    "대한민국 서울시 마포구 연남동",
    "대한민국 서울시 마포구 현석동",
    "대한민국 서울시 마포구 당인동",
    "대한민국 서울시 마포구 용강동",
    "대한민국 서울시 서대문구 대현동",
    "대한민국 서울시 서대문구 신촌동",
    "대한민국 서울시 마포구 염리동",
    "대한민국 서울시 서대문구 대신동",
    "대한민국 서울시 마포구 토정동",
    "대한민국 서울시 마포구 망원제1동",
    "대한민국 서울시 마포구 합정동",
    "대한민국 서울시 마포구 성산제1동"
  ];

  Future<List<String>> _fetchSearch(String name) async {
    List<String> results = [];
    final List<String> parsedResponse = [];
    parsedResponse.addAll(fakeLocations);
    parsedResponse.retainWhere(
        (location) => location.toLowerCase().contains(name.toLowerCase()));

    results.clear();
    results.addAll(parsedResponse);
    return results;
  }

  _setResults(String query) async {
    final List<String> results = await _fetchSearch(query);
    setState(() {
      searchResult.clear();
      searchResult.addAll(results);
    });
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
                controller: TextEditingController(),
                decoration: const InputDecoration(
                  hintText: '위치를 입력하세요.',
                  icon: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.search),
                  ),
                ),
                keyboardType: TextInputType.text,
                onChanged: (text) {
                  _setResults(text);
                },
              ),
              const SizedBox(height: 16),
              Expanded(
                child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: FutureBuilder<List<String>>(
                      future: _fetchSearch(''),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: searchResult.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                title: Text(searchResult[index]),
                                onTap: () {
                                  _selectLocation(context, searchResult[index]);
                                },
                              );
                            },
                          );
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    )),
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
