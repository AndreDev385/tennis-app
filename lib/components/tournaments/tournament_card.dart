import 'dart:ui';

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tennis_app/screens/app/tournaments/tournament.dart';

class TournamentCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CachedNetworkImage(
          imageUrl:
              "https://images.pexels.com/photos/5739161/pexels-photo-5739161.jpeg",
          imageBuilder: (context, imageProvider) => AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [],
              ),
            ),
          ),
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: BlurryContainer(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            color: Colors.white.withOpacity(.5),
            borderRadius: BorderRadius.circular(15),
            height: 80,
            width: double.maxFinite,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaY: 1, sigmaX: 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Copa Colores".toUpperCase(),
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "4 Abril - 6 Abril 2024",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    constraints: BoxConstraints(maxHeight: 40, maxWidth: 40),
                    child: IconButton(
                      color: Theme.of(context).colorScheme.onPrimary,
                      onPressed: () {
                        Navigator.of(context).pushNamed(TournamentPage.route);
                      },
                      icon: Icon(Icons.arrow_forward),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
