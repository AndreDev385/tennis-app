import 'package:flutter/material.dart';
import 'package:tennis_app/styles.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonBar(
                children: [
                  ElevatedButton(
                      onPressed: () {}, child: Text("Ultimos 3 partidos")),
                  ElevatedButton(onPressed: () {}, child: Text("Temporada")),
                  ElevatedButton(onPressed: () {}, child: Text("Todos")),
                ],
              )
            ],
          ),
          Container(
            decoration: const BoxDecoration(
              color: MyTheme.purple,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: TabBar(
              indicatorWeight: 4,
              indicatorColor: Colors.yellow,
              controller: _tabController,
              tabs: const [
                Tab(text: "Graficas"),
                Tab(text: "Tabla"),
              ],
            ),
          ),
          SizedBox(
            height: 470,
            width: double.maxFinite,
            child: TabBarView(
              controller: _tabController,
              children: [
                ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: [],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
