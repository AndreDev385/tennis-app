import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tennis_app/components/cta/create_matchs/match_preview.dart';
import 'package:tennis_app/components/shared/button.dart';
import 'package:tennis_app/components/shared/toast.dart';
import 'package:tennis_app/domain/game_rules.dart';
import 'package:tennis_app/dtos/clash_dtos.dart';
import 'package:tennis_app/dtos/player_dto.dart';
import 'package:tennis_app/screens/app/cta/home.dart';
import 'package:tennis_app/services/create_matchs.dart';

class CreateMatchsStepFour extends StatelessWidget {
  const CreateMatchsStepFour({
    super.key,
    required this.clash,
    required this.categoryWith5dobles,
    required this.goBack,
    //required this.submit,
    required this.data,
    required this.players,
  });

  final bool categoryWith5dobles;
  final ClashDto clash;

  final List<PlayerDto> players;
  final Map<String, dynamic> data;
  //final Function submit;
  final Function goBack;

  String getPlayerName(String playerId) {
    final player =
        players.firstWhere((element) => element.playerId == playerId);

    return "${player.user.firstName} ${player.user.lastName}";
  }

  @override
  Widget build(BuildContext context) {
    submit() {
      MatchRequest doble1 = MatchRequest(
        mode: GameMode.double,
        player1: data['doble1player1'],
        player2: data['doble1rival1'],
        player3: data['doble1player2'],
        player4: data['doble1rival2'],
      );
      MatchRequest doble2 = MatchRequest(
        mode: GameMode.double,
        player1: data['doble2player1'],
        player2: data['doble2rival1'],
        player3: data['doble2player2'],
        player4: data['doble2rival2'],
      );
      MatchRequest doble3 = MatchRequest(
        mode: GameMode.double,
        player1: data['doble3player1'],
        player2: data['doble3rival1'],
        player3: data['doble3player2'],
        player4: data['doble3rival2'],
      );
      MatchRequest doble4 = MatchRequest(
        mode: GameMode.double,
        player1: data['doble4player1'],
        player2: data['doble4rival1'],
        player3: data['doble4player2'],
        player4: data['doble4rival2'],
      );

      final body = CreateMatchsRequest(
          address: clash.host,
          surface: Surfaces.hard,
          clashId: clash.clashId,
          matchs: [
            doble1,
            doble2,
            doble3,
            doble4,
            categoryWith5dobles
                ? MatchRequest(
                    mode: GameMode.double,
                    player1: data['doble5player1'],
                    player3: data['doble5player2'],
                    player2: data['doble5rival1'],
                    player4: data['doble5rival2'],
                  )
                : MatchRequest(
                    mode: GameMode.single,
                    player1: data['singlePlayer'],
                    player2: data['singleRival'],
                  )
          ]);

      EasyLoading.show(status: "Creando partidos...");
      createMatchs(body).then((value) {
        EasyLoading.dismiss();
        if (value.isFailure) {
          showMessage(
            context,
            value.error ?? "Ha ocurrido un error",
            ToastType.error,
          );
          return;
        }
        showMessage(context, "Partidos creados", ToastType.success);
        Navigator.of(context).pushNamed(CtaHomePage.route);
      }).catchError((e) {
        EasyLoading.dismiss();
        showMessage(context, "Ha ocurrido un error", ToastType.error);
      });
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            MatchPreview(
              title: "Doble 1",
              player1: getPlayerName(data['doble1player1']),
              rival1: data['doble1rival1'],
              isDoble: true,
              player2: getPlayerName(data['doble1player2']),
              rival2: data['doble1rival2'],
            ),
            MatchPreview(
              title: "Doble 2",
              player1: getPlayerName(data['doble2player1']),
              rival1: data['doble2rival1'],
              isDoble: true,
              player2: getPlayerName(data['doble2player2']),
              rival2: data['doble2rival2'],
            ),
            MatchPreview(
              title: "Doble 3",
              player1: getPlayerName(data['doble3player1']),
              rival1: data['doble3rival1'],
              isDoble: true,
              player2: getPlayerName(data['doble3player2']),
              rival2: data['doble3rival2'],
            ),
            MatchPreview(
              title: "Doble 4",
              player1: getPlayerName(data['doble4player1']),
              rival1: data['doble4rival1'],
              isDoble: true,
              player2: getPlayerName(data['doble4player2']),
              rival2: data['doble4rival2'],
            ),
            if (categoryWith5dobles)
              MatchPreview(
                title: "Doble 5",
                player1: getPlayerName(data['doble5player1']),
                rival1: data['doble5rival1'],
                isDoble: true,
                player2: getPlayerName(data['doble5player2']),
                rival2: data['doble5rival2'],
              ),
            if (!categoryWith5dobles)
              MatchPreview(
                title: "Single",
                player1: getPlayerName(data['singlePlayer']),
                rival1: data['singleRival'],
                isDoble: false,
              ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: MyButton(
                      onPress: () => goBack(),
                      text: "Volver",
                      block: false,
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: MyButton(
                      text: "Continuar",
                      onPress: () => submit(),
                      block: false,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
