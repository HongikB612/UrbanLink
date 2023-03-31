import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urbanlink_project/database/community_database_service.dart';
import 'package:urbanlink_project/models/community/community.dart';
import 'package:urbanlink_project/services/auth.dart';

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
  final ValueNotifier<String> _searchQuery = ValueNotifier<String>('');

  @override
  void initState() {
    super.initState();
    _selectedLocation = widget.selectedLocation;
  }

  void _showSearchDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Search Location'),
            content: SingleChildScrollView(
                child: Column(
              children: [
                TextField(
                  autofocus: true,
                  decoration: const InputDecoration(
                    hintText: 'Search Location',
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery.value = value;
                    });
                  },
                ),
                const SizedBox(height: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ValueListenableBuilder(
                      valueListenable: _searchQuery,
                      builder: (context, value, child) => StreamBuilder<
                              List<Community>>(
                          stream: CommunityDatabaseService
                              .getCommunityStreamByLocation(_searchQuery.value),
                          builder: ((context, snapshot) {
                            if (snapshot.hasError) {
                              logger.e(snapshot.error ?? 'Unknown error');
                              return Center(
                                child: Text(
                                    'Error: ${snapshot.error ?? 'Unknown error'}'),
                              );
                            } else if (snapshot.hasData) {
                              final List<Community> communities =
                                  snapshot.data!;
                              return SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.5,
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: ListView.builder(
                                  itemCount: communities.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Text(
                                          communities[index].communityName),
                                      onTap: () {
                                        setState(() {
                                          _selectedLocation =
                                              communities[index].communityName;
                                        });
                                        widget.onChanged(_selectedLocation!);
                                        Navigator.of(context).pop();
                                      },
                                    );
                                  },
                                ),
                              );
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          })),
                    ),
                  ],
                )
              ],
            )),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            try {
              _showSearchDialog();
            } on FlutterError catch (e) {
              Get.snackbar('Error: Cannot open the widget', 'Error: $e');
              logger.e(e);
            } catch (e) {
              Get.snackbar('Error: Cannot open the widget', 'Error: $e');
              logger.e(e);
            }
          },
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
