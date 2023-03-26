import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: const Alignment(-1.0, 0.0),
      margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.5), offset: const Offset(0, 3))
        ],
        color: Colors.white24,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextButton.icon(
        label: const Text(
          '카페 검색하기',
          style: TextStyle(fontSize: 19),
        ),
        icon: const Icon(Icons.search, size: 22),
        style: TextButton.styleFrom(
          alignment: Alignment.centerLeft,
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SearchScreen()));
        },
      ),
    );
  }
}
