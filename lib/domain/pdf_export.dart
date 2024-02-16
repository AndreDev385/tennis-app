import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:tennis_app/dtos/player_tracker_dto.dart';
import 'package:tennis_app/utils/calculate_percent.dart';
import 'package:tennis_app/utils/format_date.dart';

Widget paddedText(
  final String text, {
  final TextAlign align = TextAlign.left,
}) {
  return Padding(
    padding: EdgeInsets.all(2),
    child: Text(text, textAlign: align),
  );
}

Future<Uint8List> buildPdf({
  required PlayerTrackerDto stats,
  required String playerName,
  required String rangeType,
}) async {
  final imageLogo = MemoryImage(
    (await rootBundle.load('assets/logo_light_bg.png')).buffer.asUint8List(),
  );

  var myTheme = ThemeData.withFont(
    base: Font.ttf(await rootBundle.load("assets/fonts/Poppins-Regular.ttf")),
    bold: Font.ttf(await rootBundle.load("assets/fonts/Poppins-Regular.ttf")),
    italic: Font.ttf(await rootBundle.load("assets/fonts/Poppins-Regular.ttf")),
    boldItalic:
        Font.ttf(await rootBundle.load("assets/fonts/Poppins-Regular.ttf")),
  );

  final pdf = Document(
    theme: myTheme,
  );

  int totalServDone =
      stats.firstServIn + stats.secondServIn + stats.dobleFaults;

  pdf.addPage(
    Page(
      build: (Context context) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Nombre: $playerName"),
                    Text("Rango de datos: $rangeType"),
                    Text(
                      "Tipo de partido: ${stats.isDouble ? 'Doble' : 'Single'}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text("Fecha: ${formatDate(DateTime.now())}"),
                  ],
                ),
                SizedBox(height: 150, width: 200, child: Image(imageLogo))
              ],
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 4)),
            Table(
              border: TableBorder.all(color: PdfColors.black),
              children: [
                TableRow(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(4),
                        child: Text(
                          "SERVICIO",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Expanded(
                      flex: 2,
                      child: paddedText(
                        "Aces",
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: paddedText(
                        "${stats.aces}",
                        align: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Expanded(
                      flex: 2,
                      child: paddedText("Doble faltas"),
                    ),
                    Expanded(
                      flex: 1,
                      child: paddedText(
                        "${stats.dobleFaults}",
                        align: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Expanded(
                      flex: 2,
                      child: paddedText("1er Servicio In"),
                    ),
                    Expanded(
                      flex: 1,
                      child: paddedText(
                        "${stats.firstServIn}/$totalServDone (${calculatePercent(stats.firstServIn, totalServDone)}%)",
                        align: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Expanded(
                      flex: 2,
                      child: paddedText("1er Saque ganador"),
                    ),
                    Expanded(
                      flex: 1,
                      child: paddedText(
                        "${stats.firstServWon}",
                        align: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Expanded(
                      flex: 2,
                      child: paddedText("Puntos ganados con el 1er servicio"),
                    ),
                    Expanded(
                      flex: 1,
                      child: paddedText(
                        "${stats.pointsWinnedFirstServ}/${stats.firstServIn} (${calculatePercent(stats.pointsWinnedFirstServ, stats.firstServIn)}%)",
                        align: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Expanded(
                      flex: 2,
                      child: paddedText("2do Servicio In"),
                    ),
                    Expanded(
                      flex: 1,
                      child: paddedText(
                        "${stats.secondServIn}/${stats.secondServIn + stats.dobleFaults} (${calculatePercent(stats.secondServIn, stats.secondServIn + stats.dobleFaults)}%)",
                        align: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Expanded(
                      flex: 2,
                      child: paddedText("2do saque ganador"),
                    ),
                    Expanded(
                      flex: 1,
                      child: paddedText(
                        "${stats.secondServWon}",
                        align: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Expanded(
                      flex: 2,
                      child: paddedText("Puntos ganados con el 2do servicio"),
                    ),
                    Expanded(
                      flex: 1,
                      child: paddedText(
                        "${stats.pointsWinnedSecondServ}/${stats.secondServIn} (${calculatePercent(stats.pointsWinnedSecondServ, stats.secondServIn)}%)",
                        align: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Expanded(
                      flex: 2,
                      child: paddedText("Break points salvados"),
                    ),
                    Expanded(
                      flex: 1,
                      child: paddedText(
                        "${stats.breakPtsSaved}/${stats.saveBreakPtsChances} (${calculatePercent(stats.breakPtsSaved, stats.saveBreakPtsChances)}%)",
                        align: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Expanded(
                      flex: 2,
                      child: paddedText("Games ganados con el servicio"),
                    ),
                    Expanded(
                      flex: 1,
                      child: paddedText(
                        "${stats.gamesWonServing}/${stats.gamesWonServing + stats.gamesLostServing} (${calculatePercent(stats.gamesWonServing, stats.gamesWonServing + stats.gamesLostServing)}%)",
                        align: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(4),
                        child: Text(
                          "DEVOLUCIÓN",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Expanded(
                      flex: 2,
                      child: paddedText("1era devolución in"),
                    ),
                    Expanded(
                      flex: 1,
                      child: paddedText(
                        "${stats.firstReturnIn}/${stats.firstReturnIn + stats.firstReturnOut} (${calculatePercent(stats.firstReturnIn, stats.firstReturnIn + stats.firstReturnOut)}%)",
                        align: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Expanded(
                      flex: 2,
                      child: paddedText("1era devolución ganadora"),
                    ),
                    Expanded(
                      flex: 1,
                      child: paddedText(
                        "${stats.firstReturnWon}",
                        align: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Expanded(
                      flex: 2,
                      child: paddedText("Winner con 1era devolución"),
                    ),
                    Expanded(
                      flex: 1,
                      child: paddedText(
                        "${stats.firstReturnWinner}",
                        align: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Expanded(
                      flex: 2,
                      child:
                          paddedText("Puntos ganados con la 1era devolución"),
                    ),
                    Expanded(
                      flex: 1,
                      child: paddedText(
                        "${stats.pointsWinnedFirstReturn}/${stats.firstReturnIn + stats.firstReturnOut} (${calculatePercent(stats.pointsWinnedFirstReturn, stats.firstReturnIn + stats.firstReturnOut)}%)",
                        align: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Expanded(
                      flex: 2,
                      child: paddedText("2da devolución in"),
                    ),
                    Expanded(
                      flex: 1,
                      child: paddedText(
                        "${stats.secondReturnIn}/${stats.secondReturnIn + stats.secondReturnOut} (${calculatePercent(stats.secondReturnIn, stats.secondReturnIn + stats.secondReturnOut)}%)",
                        align: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Expanded(
                      flex: 2,
                      child: paddedText("2da devolución ganadora"),
                    ),
                    Expanded(
                      flex: 1,
                      child: paddedText(
                        "${stats.secondReturnWon}",
                        align: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Expanded(
                      flex: 2,
                      child: paddedText("Winner con 2da devolución ganadora"),
                    ),
                    Expanded(
                      flex: 1,
                      child: paddedText(
                        "${stats.secondReturnWinner}",
                        align: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Expanded(
                      flex: 2,
                      child: paddedText("Puntos ganados con la 2da devolución"),
                    ),
                    Expanded(
                      flex: 1,
                      child: paddedText(
                        "${stats.pointsWinnedSecondReturn}/${stats.secondReturnIn + stats.secondReturnOut} (${calculatePercent(stats.pointsWinnedSecondReturn, stats.secondReturnIn + stats.secondReturnOut)}%)",
                        align: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(4),
                        child: Text(
                          "PELOTA EN JUEGO",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Expanded(
                      flex: 2,
                      child: paddedText("Puntos ganados en malla"),
                    ),
                    Expanded(
                      flex: 1,
                      child: paddedText(
                        "${stats.meshPointsWon}/${stats.meshPointsWon + stats.meshPointsLost} (${calculatePercent(stats.meshPointsWon, stats.meshPointsWon + stats.meshPointsLost)}%)",
                        align: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Expanded(
                      flex: 2,
                      child: paddedText("Winners en malla"),
                    ),
                    Expanded(
                      flex: 1,
                      child: paddedText(
                        "${stats.meshWinner}",
                        align: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Expanded(
                      flex: 2,
                      child: paddedText("Erorres en malla"),
                    ),
                    Expanded(
                      flex: 1,
                      child: paddedText(
                        "${stats.meshError}",
                        align: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Expanded(
                      flex: 2,
                      child: paddedText("Puntos ganados en fondo/approach"),
                    ),
                    Expanded(
                      flex: 1,
                      child: paddedText(
                        "${stats.bckgPointsWon}/${stats.bckgPointsWon + stats.bckgPointsLost} (${calculatePercent(stats.bckgPointsWon, stats.bckgPointsWon + stats.bckgPointsLost)}%)",
                        align: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Expanded(
                      flex: 2,
                      child: paddedText("Winners en fondo/approach"),
                    ),
                    Expanded(
                      flex: 1,
                      child: paddedText(
                        "${stats.bckgWinner}",
                        align: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Expanded(
                      flex: 2,
                      child: paddedText("Errores en fondo/approach"),
                    ),
                    Expanded(
                      flex: 1,
                      child: paddedText(
                        "${stats.bckgError}",
                        align: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Expanded(
                      flex: 2,
                      child: paddedText("Total winners"),
                    ),
                    Expanded(
                      flex: 1,
                      child: paddedText(
                        "${stats.winners}",
                        align: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Expanded(
                      flex: 2,
                      child: paddedText("Total errores no forzados"),
                    ),
                    Expanded(
                      flex: 1,
                      child: paddedText(
                        "${stats.noForcedErrors}",
                        align: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    ),
  );

  return pdf.save();
}
