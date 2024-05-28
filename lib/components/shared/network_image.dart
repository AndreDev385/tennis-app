import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../styles.dart';

class NetWorkImage extends StatelessWidget {
  final String url;
  final double? height;

  const NetWorkImage({
    required this.url,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, imageProvider) => Container(
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(MyTheme.cardBorderRadius),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.fill,
          ),
        ),
        width: double.infinity,
      ),
      placeholder: (context, url) => Container(),
      errorWidget: (context, url, error) => Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                "Error al cargar la imagen",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            ),
            Icon(
              Icons.error,
              color: Theme.of(context).colorScheme.error,
            )
          ],
        ),
      ),
    );
  }
}
