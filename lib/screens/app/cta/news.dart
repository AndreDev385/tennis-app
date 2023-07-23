import 'package:flutter/material.dart';
import 'package:tennis_app/components/layout/header.dart';

class News extends StatefulWidget {
  const News({super.key});

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Center(
        child: Column(
          children: [Text("News")],
        ),
      ),
    );
  }
}
