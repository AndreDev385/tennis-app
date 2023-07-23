import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tennis_app/components/layout/header.dart';
import 'package:tennis_app/dtos/category_dto.dart';
import 'package:tennis_app/dtos/user_dto.dart';
import 'package:tennis_app/screens/app/cta/create_clash.dart';
import 'package:tennis_app/screens/app/cta/live.dart';
import 'package:tennis_app/screens/app/cta/news.dart';
import 'package:tennis_app/screens/app/cta/profile.dart';
import 'package:tennis_app/screens/app/cta/results.dart';
import 'package:tennis_app/screens/app/cta/teams.dart';
import 'package:tennis_app/services/list_categories.dart';
import 'package:tennis_app/services/list_seasons.dart';
import 'package:tennis_app/styles.dart';

class CtaHomePage extends StatefulWidget {
  const CtaHomePage({super.key});

  static const route = "/cta";

  @override
  State<CtaHomePage> createState() => _CtaHomePage();
}

class _CtaHomePage extends State<CtaHomePage> {
  bool _loading = true;
  int _selectedIndex = 1;
  List<CategoryDto> _categories = [];
  UserDto? user;

  @override
  void initState() {
    EasyLoading.show(status: "Cargando...");
    _getData();
    super.initState();
  }

  _getData() async {
    SharedPreferences storage = await SharedPreferences.getInstance();

    await _getCategories(storage);
    await _getCurrentSeason(storage);
    await _getUser();
    EasyLoading.dismiss();
  }

  _getCategories(SharedPreferences storage) async {
    String? categoriesJson = storage.getString("categories");

    if (categoriesJson != null) {
      List<dynamic> rawList = jsonDecode(categoriesJson);
      setState(() {
        _categories = rawList.map((e) => CategoryDto.fromJson(e)).toList();
        _loading = false;
      });
      return;
    }

    final result = await listCategories({});

    if (result.isFailure) {
      return;
    }

    List<CategoryDto> list = result.getValue();

    setState(() {
      _categories = list;
      _loading = false;
    });
  }

  _getUser() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    String? user = storage.getString("user");
    if (user == null) {
      return;
    }
    setState(() {
      this.user = UserDto.fromJson(jsonDecode(user));
    });
  }

  _getCurrentSeason(SharedPreferences storage) async {
    String? seasonJson = storage.getString("season");

    if (seasonJson == null) {
      await listSeasons({});
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Header(),
      appBar: AppBar(
        centerTitle: true,
        title: Title(color: Colors.white, child: const Text("CTA")),
        actions: [
          if (user != null && user!.canTrack)
            FilledButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(CreateClash.route);
                },
                child: const Icon(Icons.add))
        ],
      ),
      body: SizedBox(
        child: (_loading && _categories.isNotEmpty)
            ? null
            : renderPages(_categories).elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            label: 'Novedades',
            backgroundColor: MyTheme.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.live_tv),
            label: 'Live',
            backgroundColor: MyTheme.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.document_scanner),
            label: 'Resultados',
            backgroundColor: MyTheme.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Equipos',
            backgroundColor: MyTheme.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
            backgroundColor: MyTheme.purple,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: MyTheme.yellow,
        onTap: _onItemTapped,
        unselectedItemColor: Colors.white70,
      ),
    );
  }
}

List<Widget> renderPages(List<CategoryDto> categories) {
  const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  return [
    const News(),
    Live(categories: categories),
    const ClashResults(),
    Teams(categories: categories),
    Profile(),
  ];
}
