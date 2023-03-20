import 'package:address_search_field/address_search_field.dart';
import 'package:flutter/material.dart';

class AddressSearchBar extends StatefulWidget {
  const AddressSearchBar({super.key});

  @override
  State<AddressSearchBar> createState() => _AddressSearchBarState();
}

class _AddressSearchBarState extends State<AddressSearchBar> {
  final GeoMethods geoMethods = GeoMethods(
    googleApiKey: 'AIzaSyCA6eLlZg1DQdmgWzQ3KfN7GtaY48iW9Zc',
    language: 'kr',
    countryCode: 'kr',
    countryCodes: ['us', 'kr'],
    country: 'Korea',
    city: 'Seoul',
  );
  TextEditingController controller = TextEditingController();
  late Address destinationAddress;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onTap: () => showDialog(
          context: context,
          builder: (BuildContext context) {
            return AddressSearchDialog.custom(
                geoMethods: geoMethods,
                builder: (
                  BuildContext context,
                  AsyncSnapshot<List<Address>> snapshot,
                  Future<void> Function() searchAddress,
                  Future<Address> Function(Address address) getGeometry,
                  void Function() dismiss,
                ) {
                  return MyCustomWidget(
                    snapshot: snapshot,
                    searchAddress: searchAddress,
                    getGeometry: getGeometry,
                    dismiss: dismiss,
                    controller: controller,
                    address: destinationAddress,
                  );
                });
          }),
    );
    ;
  }
}
