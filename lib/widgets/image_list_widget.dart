import 'package:flutter/material.dart';
import 'package:urbanlink_project/database/storage_service.dart';
import 'package:urbanlink_project/models/posts.dart';

class ImageList extends StatefulWidget {
  const ImageList({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  State<ImageList> createState() => _ImageListState();
}

class _ImageListState extends State<ImageList> {
  bool isLoading = true;
  late List<String> images;

  static const double _imageHeight = 200;

  @override
  void initState() {
    super.initState();
    _fetchImages();
  }

  void _fetchImages() async {
    if (mounted) {
      var imgs = await StorageService.getImagesByPostId(widget.post.postId);

      if (mounted) {
        setState(() {
          images = imgs;
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const SizedBox(
        height: _imageHeight,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (images.isEmpty) {
      // return empty container
      return const SizedBox(
        height: 0,
      );
    }

    return SizedBox(
      height: _imageHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (context, index) {
          return SizedBox(
            width: 200,
            height: 200,
            child: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      child: Image.network(
                        images[index],
                        fit: BoxFit.contain,
                      ),
                    );
                  },
                );
              },
              child: Image.network(
                images[index],
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
