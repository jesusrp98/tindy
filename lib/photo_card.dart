import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PhotoCard extends StatelessWidget {
  final String url;

  PhotoCard(this.url);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: CachedNetworkImage(
        useOldImageOnUrlChange: true,
        imageUrl: url,
        fit: BoxFit.cover,
        fadeOutDuration: const Duration(milliseconds: 500),
        fadeInCurve: Curves.elasticIn,
        fadeOutCurve: Curves.elasticOut,
        fadeInDuration: const Duration(milliseconds: 500),
      ),
    );
  }
}
