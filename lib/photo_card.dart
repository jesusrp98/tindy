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
        imageUrl: url,
        fit: BoxFit.cover,
        placeholder: (_, string) => Container(
              width: MediaQuery.of(context).size.width,
              child: Center(child: CircularProgressIndicator()),
            ),
        fadeOutDuration: const Duration(milliseconds: 0),
        fadeInDuration: const Duration(milliseconds: 0),
      ),
    );
  }
}
