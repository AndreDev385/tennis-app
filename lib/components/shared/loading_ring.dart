import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingRing extends StatelessWidget {
  const LoadingRing({super.key,
    this.size = 25,
    this.lineWidth = 2,
  });

  final int size;
  final int lineWidth;

  @override
  Widget build(BuildContext context) {
    return SpinKitRing(
      color: Theme.of(context).brightness == Brightness.light
          ? Theme.of(context).colorScheme.primary
          : Theme.of(context).colorScheme.onPrimary,
      size: 25.0,
      lineWidth: 2,
    );
  }
}
