import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:tennis_app/domain/pdf_export.dart';
import 'package:tennis_app/dtos/player_tracker_dto.dart';

class PDFPreview extends StatelessWidget {
  const PDFPreview({
    super.key,
    required this.stats,
    required this.playerName,
    required this.range,
  });

  final PlayerTrackerDto stats;
  final String playerName;
  final String range;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: PdfPreview(
        build: (context) => buildPdf(
          playerName: playerName,
          rangeType: range,
          stats: stats,
        ),
      ),
    );
  }
}
