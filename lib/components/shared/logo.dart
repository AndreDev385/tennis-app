import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Logo extends StatelessWidget {
  final bool? isLightTheme;

  const Logo({
    super.key,
    this.isLightTheme,
  });

  @override
  Widget build(BuildContext context) {
    bool lightTheme() {
      if (isLightTheme == null) {
        return Theme.of(context).brightness == Brightness.light;
      }
      return isLightTheme!;
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: lightTheme()
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
