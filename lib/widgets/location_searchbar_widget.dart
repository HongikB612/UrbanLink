import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:urbanlink_project/database/community_database_service.dart';
import 'package:urbanlink_project/models/communities.dart';

class LocationSearchbar extends StatefulWidget {
  final ValueChanged<String> onChanged;

  const LocationSearchbar({Key? key, required this.onChanged})
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

  @override
  void initState() {
    super.initState();
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
