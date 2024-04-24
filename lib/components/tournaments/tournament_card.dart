import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:tennis_app/utils/format_date.dart';

import '../../dtos/tournaments/tournament.dart';
import '../../screens/tournaments/tournament_page.dart';

class TournamentCard extends StatelessWidget {
  final Tournament tournament;

  const TournamentCard({
    super.key,
    required this.tournament,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CachedNetworkImage(
          imageUrl: tournament.image,
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
                        tournament.name.toUpperCase(),
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "${formatDate(tournament.startDate)} - ${formatDate(tournament.endDate)}",
                        style: TextStyle(color: Colors.black),
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
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => TournamentPage(
                              tournament: tournament,
                            ),
                          ),
                        );
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
