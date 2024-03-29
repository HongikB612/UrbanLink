import 'dart:io';

import 'package:flutter/material.dart';

class ImageListBuilder extends StatefulWidget {
  const ImageListBuilder({
    Key? key,
    required this.images,
  }) : super(key: key);

  final List<File> images;

  @override
  State<ImageListBuilder> createState() => _ImageListBuilderState();
}

class _ImageListBuilderState extends State<ImageListBuilder> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.images.length,
            itemBuilder: (context, index) {
              return SizedBox(
                height: 100,
                width: 100,
                child: _ImageContainer(
                  image: widget.images[index],
                  onDelete: () {
                    // Remove the image from the list when the delete button is pressed
                    setState(() {
                      widget.images.removeAt(index);
                    });
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ImageContainer extends StatelessWidget {
  const _ImageContainer({
    Key? key,
    required this.image,
    required this.onDelete,
  }) : super(key: key);

  final File image;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Stack(
        children: [
          // Display the image with a square aspect ratio and fit it inside the container
          Positioned.fill(
            child: InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        child: Image.file(
                          image,
                          fit: BoxFit.cover,
                        ),
                      );
                    });
              },
              child: Image.file(
                image,
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
          ),
          // Display the delete button at the top right corner
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
    );
  }
}
