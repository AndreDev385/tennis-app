import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../domain/shared/utils.dart';
import '../../../dtos/clash_dtos.dart';
import '../../../dtos/player_dto.dart';
import '../../../screens/cta/tracker/tracker_cta.dart';
import '../../../services/match/create_matchs.dart';
import '../../../utils/format_player_name.dart';
import '../../shared/button.dart';
import '../../shared/toast.dart';
import 'match_preview.dart';

class ListMatchesPreview extends StatelessWidget {
  const ListMatchesPreview({
    super.key,
    required this.clash,
    required this.categoryWith5dobles,
    required this.goBack,
    required this.data,
    required this.players,
  });

  final bool categoryWith5dobles;
  final ClashDto clash;

  final List<PlayerDto> players;
  final Map<String, dynamic> data;
  final Function goBack;

  String findPlayerByFormatName(String name) {
    PlayerDto player =
        players.firstWhere((element) => formatPlayerDtoName(element) == name);

    return player.playerId;
  }

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
        player1: findPlayerByFormatName(data['doble1player1']),
        player2: data['doble1rival1'],
        player3: findPlayerByFormatName(data['doble1player2']),
        player4: data['doble1rival2'],
      );
      MatchRequest doble2 = MatchRequest(
        mode: GameMode.double,
        player1: findPlayerByFormatName(data['doble2player1']),
        player2: data['doble2rival1'],
        player3: findPlayerByFormatName(data['doble2player2']),
        player4: data['doble2rival2'],
      );
      MatchRequest doble3 = MatchRequest(
        mode: GameMode.double,
        player1: findPlayerByFormatName(data['doble3player1']),
        player2: data['doble3rival1'],
        player3: findPlayerByFormatName(data['doble3player2']),
        player4: data['doble3rival2'],
      );
      MatchRequest doble4 = MatchRequest(
        mode: GameMode.double,
        player1: findPlayerByFormatName(data['doble4player1']),
        player2: data['doble4rival1'],
        player3: findPlayerByFormatName(data['doble4player2']),
        player4: data['doble4rival2'],
      );

      final body = CreateMatchsRequest(
          address: clash.host,
          surface: data["surface"].toString().toLowerCase(),
          clashId: clash.clashId,
          matchs: [
            doble1,
            doble2,
            doble3,
            doble4,
            categoryWith5dobles
                ? MatchRequest(
                    mode: GameMode.double,
                    player1: findPlayerByFormatName(data['doble5player1']),
                    player3: findPlayerByFormatName(data['doble5player2']),
                    player2: data['doble5rival1'],
                    player4: data['doble5rival2'],
                  )
                : MatchRequest(
                    mode: GameMode.single,
                    player1: findPlayerByFormatName(data['singlePlayer']),
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
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => TrackerCTA(
              club: clash.team1.club,
            ),
          ),
        );
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
              player1: data['doble1player1'],
              rival1: data['doble1rival1'],
              isDoble: true,
              player2: data['doble1player2'],
              rival2: data['doble1rival2'],
            ),
            MatchPreview(
              title: "Doble 2",
              player1: data['doble2player1'],
              rival1: data['doble2rival1'],
              isDoble: true,
              player2: data['doble2player2'],
              rival2: data['doble2rival2'],
            ),
            MatchPreview(
              title: "Doble 3",
              player1: data['doble3player1'],
              rival1: data['doble3rival1'],
              isDoble: true,
              player2: data['doble3player2'],
              rival2: data['doble3rival2'],
            ),
            MatchPreview(
              title: "Doble 4",
              player1: data['doble4player1'],
              rival1: data['doble4rival1'],
              isDoble: true,
              player2: data['doble4player2'],
              rival2: data['doble4rival2'],
            ),
            if (categoryWith5dobles)
              MatchPreview(
                title: "Doble 5",
                player1: data['doble5player1'],
                rival1: data['doble5rival1'],
                isDoble: true,
                player2: data['doble5player2'],
                rival2: data['doble5rival2'],
              ),
            if (!categoryWith5dobles)
              MatchPreview(
                title: "Single",
                player1: data['singlePlayer'],
                rival1: data['singleRival'],
                isDoble: false,
              ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(top: 32),
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
                      text: "Crear",
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
