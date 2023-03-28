import 'package:flutter/material.dart';
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
  String? _selectedLocation;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _selectedLocation = widget.selectedLocation;
  }

  @override
  void didUpdateWidget(covariant LocationSearchbar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedLocation != widget.selectedLocation) {
      setState(() {
        _selectedLocation = widget.selectedLocation;
      });
    }
  }



  void _showSearchDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Search Location'),
            content: Column(
              children: [
                TextField(
                  autofocus: true,
                  decoration: const InputDecoration(
                    hintText: 'Search Location',
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
                const SizedBox(height: 10),
                StreamBuilder<List<Community>>(
                  stream: CommunityDatabaseService.getCommunityByLocation(
                      _searchQuery),
                  builder: 
                  )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => _showSearchDialog(),
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
