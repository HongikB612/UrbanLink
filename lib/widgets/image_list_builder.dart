import 'dart:io';

import 'package:flutter/material.dart';

class ImageListBuilder extends StatefulWidget {
  const ImageListBuilder({
    super.key,
    required this.images,
  });

  final List<File> images;

  @override
  State<ImageListBuilder> createState() => _ImageListBuilderState();
}

class _ImageListBuilderState extends State<ImageListBuilder> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: widget.images.length,
      itemBuilder: (context, index) {
        return _ImageContainer(
          image: widget.images[index],
          onDelete: () {
            setState(() {
              widget.images.removeAt(index);
            });
          },
        );
      },
    );
  }
}

class _ImageContainer extends StatelessWidget {
  const _ImageContainer({
    required this.image,
    required this.onDelete,
  });

  final File image;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 120,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.file(
                image,
                alignment: Alignment.center,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: onDelete,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
