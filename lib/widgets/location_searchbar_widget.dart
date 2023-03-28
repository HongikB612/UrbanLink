import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:urbanlink_project/database/community_database_service.dart';
import 'package:urbanlink_project/models/communities.dart';

class LocationSearchbar extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String? selectedLocation;

  const LocationSearchbar(
      {Key? key, required this.onChanged, this.selectedLocation})
      : super(key: key);

  @override
  State<LocationSearchbar> createState() => _LocationSearchbarState();
}

class _LocationSearchbarState extends State<LocationSearchbar> {
  final TextEditingController _searchQueryController = TextEditingController();
  FocusNode focusNode = FocusNode();
  String _searchQuery = '';
  BehaviorSubject<List<Community>> _communitiesStream =
      BehaviorSubject<List<Community>>.seeded([]);

  String _selectedLocation = '';

  List<String> fakeLocations = [
    "대한민국 서울 마포구 창전동",
    "대한민국 서울 마포구 동교동",
    "대한민국 서울 서대문구 창천동",
    "대한민국 서울 마포구 서강동",
    "대한민국 서울 마포구 노고산동",
    "대한민국 서울 마포구 서교동",
    "대한민국 서울 마포구 상수동",
    "대한민국 서울 마포구 신수동",
    "대한민국 서울 마포구 하중동",
    "대한민국 서울 마포구 신정동",
    "대한민국 서울 마포구 대흥동",
    "대한민국 서울 마포구 현석동",
    "대한민국 서울 마포구 당인동",
    "대한민국 서울 마포구 용강동",
    "대한민국 서울 서대문구 대현동",
    "대한민국 서울 서대문구 신촌동",
    "대한민국 서울 마포구 염리동",
    "대한민국 서울 서대문구 대신동",
    "대한민국 서울 마포구 토정동",
    "대한민국 서울 마포구 망원제1동",
    "대한민국 서울 마포구 합정동",
    "대한민국 서울 마포구 성산제1동",
    "대한민국 서울 서대문구 남가좌제1동",
    "대한민국 서울 마포구 마포동",
    "대한민국 서울 마포구 도화동",
    "대한민국 서울 마포구 아현동",
    "대한민국 서울 마포구 성산제2동",
    "대한민국 서울 마포구 망원제2동",
    "대한민국 서울 마포구 성산동",
    "대한민국 서울 서대문구 북아현동",
    "대한민국 서울 서대문구 충현동",
    "대한민국 서울 서대문구 남가좌동",
    "대한민국 서울 마포구 망원동",
    "대한민국 서울 서대문구 봉원동",
    "대한민국 서울 마포구 신공덕동",
    "대한민국 서울 용산구 청암동",
    "대한민국 서울 마포구 공덕동",
    "대한민국 서울 서대문구 남가좌제2동",
    "대한민국 서울 마포구 중동",
    "대한민국 서울 서대문구 북가좌제1동",
    "대한민국 서울 영등포구 여의도동",
    "대한민국 서울 용산구 산천동",
    "대한민국 서울용산구 도원동",
    "대한민국 서울 용산구 원효로제2동",
    "대한민국 서울 서대문구 홍은제2동",
    "대한민국 서울 영등포구 당산동",
    "대한민국 서울 용산구 용문동",
    "대한민국 서울 서대문구 충정로3가",
    "대한민국 서울 용산구 신창동",
    "대한민국 서울 용산구 원효로4가",
    "대한민국 서울 중구 만리동2가",
    "대한민국 서울 서대문구 현저동",
    "대한민국 서울 중구 중림동",
    "대한민국 서울 서대문구 영천동",
    "대한민국 서울 영등포구 당산동6가",
    "대한민국 서울 서대문구 옥천동",
    "대한민국 서울 용산구 효창동",
    "대한민국 서울 서대문구 북가좌동",
    "대한민국 서울 영등포구 당산제2동",
    "대한민국 서울 서대문구 천연동",
    "대한민국 서울 서대문구 냉천동",
    "대한민국 서울 서대문구 충정로2가",
    "대한민국 서울 용산구 원효로3가",
    "대한민국 서울 용산구 서계동",
    "대한민국 서울 중구 만리동1가",
    "대한민국 서울 서대문구 합동",
    "대한민국 서울 용산구 청파동2가",
    "대한민국 서울 용산구 청파동1가",
    "대한민국 서울 영등포구 양평제2동",
    "대한민국 서울 서대문구 북가좌제2동",
    "대한민국 서울 영등포구 당산동5가",
    "대한민국 서울 종로구 교북동",
    "대한민국 서울 영등포구 양평동4가",
    "대한민국 서울 영등포구 영등포동8가",
    "대한민국 서울 종로구 교남동",
    "대한민국 서울 서대문구 미근동",
    "대한민국 서울 용산구 청파동3가",
    "대한민국 서울 종로구 무악동",
    "대한민국 서울 영등포구 양화동",
    "대한민국 서울 용산구 원효로2가",
    "대한민국 서울 영등포구 양평동5가",
    "대한민국 서울 종로구 홍파동",
    "대한민국 서울 중구 의주로2가",
    "대한민국 서울 종로구 송월동",
    "대한민국 서울 종로구 평동",
    "대한민국 서울 종로구 행촌동",
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

  @override
  void dispose() {
    _searchQueryController.dispose();
    super.dispose();
  }

  void _showSearchDialog(BuildContext context) {
    _communitiesStream.addStream(
        CommunityDatabaseService.getCommunitiesByQuery(_searchQuery));
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Search Communities'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'Enter search query',
                ),
              ),
              StreamBuilder<List<Community>>(
                  stream: _communitiesStream.stream,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Text('No communities found');
                    } else {
                      return Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title:
                                    Text(snapshot.data![index].communityName),
                                onTap: () {
                                  _selectLocation(
                                      context, snapshot.data![index].location);
                                  Navigator.pop(context);
                                },
                              );
                            }),
                      );
                    }
                  }),
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
