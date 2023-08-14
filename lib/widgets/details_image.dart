import 'package:flutter/material.dart';

import '../constants.dart';

class DetailsImage extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  const DetailsImage(
      {super.key,
      required this.imageUrl,
      required this.width,
      required this.height});

  @override
  Widget build(BuildContext context) {
    return imageUrl.isNotEmpty
        ? Image.network(
            '$imageBaseUrl$imageUrl',
            width: width,
            height: height,
            fit: BoxFit.fitHeight,
          )
        : Image.asset(
            'images/placeholder_image.png',
            width: width,
            height: height,
          );
  }
}
