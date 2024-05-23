import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CardSlider extends StatelessWidget {
  final List<Widget> cards;
  final double viewport;
  final double height;

  const CardSlider({
    super.key,
    required this.cards,
    this.viewport = 1 / 2,
    this.height = 150,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: CarouselSlider(
        options: CarouselOptions(
          height: height,
          enlargeCenterPage: false,
          autoPlay: true, //should be dinamic
          autoPlayCurve: Curves.fastOutSlowIn,
          autoPlayInterval: Duration(seconds: 4),
          viewportFraction: viewport,
          padEnds: false,
          enableInfiniteScroll: cards.length > 2,
          autoPlayAnimationDuration: const Duration(
            milliseconds: 600,
          ),
        ),
        items: cards,
      ),
    );
  }
}
