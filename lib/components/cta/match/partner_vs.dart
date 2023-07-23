import 'package:flutter/material.dart';
import 'package:tennis_app/components/cta/match/partner_vs_table.dart';
import 'package:tennis_app/dtos/match_dtos.dart';

class PartnerVs extends StatefulWidget {
  const PartnerVs({
    super.key,
    required this.match,
    required this.showMore,
  });

  final MatchDto match;
  final bool showMore;

  @override
  State<PartnerVs> createState() => _PartnerVsState();
}

class _PartnerVsState extends State<PartnerVs> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: [
        !widget.showMore
            ? const Column(
                children: [
                  SizedBox(
                    height: 48,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Puntos ganados con el servicio",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )
            : PartnerVsTable(match: widget.match),
      ],
    );
  }
}
