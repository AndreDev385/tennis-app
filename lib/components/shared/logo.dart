import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Theme.of(context).brightness == Brightness.light
          ? SvgPicture.asset(
              'assets/logo_light_bg.svg',
              width: 250,
              height: 100,
            )
          : SvgPicture.asset(
              'assets/logo_dark_bg.svg',
              width: 250,
              height: 100,
            ),
    );
  }
}
