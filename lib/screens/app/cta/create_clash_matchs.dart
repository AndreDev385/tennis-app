import 'package:flutter/material.dart';
import 'package:tennis_app/components/cta/create_matchs/step_manager.dart';
import 'package:tennis_app/dtos/clash_dtos.dart';
import 'package:tennis_app/screens/app/cta/home.dart';

class CreateClashMatchsArgs {
  final ClashDto clash;

  const CreateClashMatchsArgs(this.clash);
}

class CreateClashMatchs extends StatefulWidget {
  const CreateClashMatchs({super.key});

  static const route = '/create-clash-matchs';

  @override
  State<CreateClashMatchs> createState() => _CreateClashMatchsState();
}

class _CreateClashMatchsState extends State<CreateClashMatchs> {
  @override
  Widget build(BuildContext context) {
    final CreateClashMatchsArgs args =
        ModalRoute.of(context)!.settings.arguments as CreateClashMatchsArgs;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Crear partidos"),
        leading: FilledButton(
          child: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushNamed(CtaHomePage.route);
          },
        ),
        centerTitle: true,
      ),
      body: Container(
        height: double.maxFinite,
        margin: const EdgeInsets.all(16),
        child: StepManager(
          clash: args.clash,
        ),
      ),
    );
  }
}
