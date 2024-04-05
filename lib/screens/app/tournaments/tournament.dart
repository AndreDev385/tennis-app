import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';

class TournamentPage extends StatefulWidget {
  const TournamentPage({super.key});

  @override
  State<StatefulWidget> createState() => _TournamentPage();

  static const route = "tournament-detail";
}

class _TournamentPage extends State<TournamentPage>
    with SingleTickerProviderStateMixin {
  late GroupButtonController _contestButtonGroup;
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _contestButtonGroup = GroupButtonController(
      selectedIndex: 0,
      onDisablePressed: (index) {
        print(
          "$index, ${_contestButtonGroup.selectedIndexes} ${_contestButtonGroup.disabledIndexes}",
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Copa Colores",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child:
                /* select category */
                Center(
              child: Container(
                constraints: BoxConstraints(maxWidth: 512),
                padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                child: Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                ),
                              ),
                              child: ListView(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 16),
                                    child: Text(
                                      "Selecciona una competencia",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    child: const Text('Close BottomSheet'),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Row(
                        children: [
                          Text(
                            "3ra Femenina",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(Icons.arrow_drop_down)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            /* end select category */
          ),
          SliverToBoxAdapter(
            child:
                /* tabbar */
                Center(
              child: Container(
                constraints: BoxConstraints(maxWidth: 512),
                padding: EdgeInsets.symmetric(vertical: 16),
                child: TabBar(
                  controller: _tabController,
                  labelStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  dividerColor: Colors.grey,
                  dividerHeight: 1,
                  indicatorSize: TabBarIndicatorSize.tab,
                  unselectedLabelColor: Colors.grey,
                  unselectedLabelStyle: TextStyle(),
                  indicatorWeight: 3,
                  tabs: [
                    Tab(text: "Participantes"),
                    Tab(text: "Partidos"),
                    Tab(text: "Draw"),
                  ],
                ),
              ),
            ),
            /* end tabbar */
          ),
          SliverFillRemaining(
            child: Center(
              child: Container(
                constraints: BoxConstraints(maxWidth: 512),
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: _tabController,
                  children: [
                    /* players */
                    Container(
                      padding: EdgeInsets.only(
                        left: 16,
                        right: 16,
                        bottom: 32,
                      ),
                      child: Column(
                        children: [
                          Card(
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? Colors.white
                                    : Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              width: double.maxFinite,
                              height: 80,
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 16),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Nombre Apellido",
                                          ),
                                          Text(
                                            "Nro. 1",
                                            style: TextStyle(fontSize: 11),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? Colors.white
                                    : Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              width: double.maxFinite,
                              height: 80,
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 16),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Nombre Apellido",
                                          ),
                                          Text(
                                            "Nro. 1",
                                            style: TextStyle(fontSize: 11),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    /* end players */
                    Container(
                      padding: EdgeInsets.only(
                        left: 16,
                        right: 16,
                        bottom: 32,
                      ),
                      child: Column(
                        children: [
                          Card(
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? Colors.white
                                    : Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              width: double.maxFinite,
                              height: 100,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 8),
                                              child: Text("Nombre Apellido"),
                                            ),
                                            Icon(Icons.check),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            ListView.builder(
                                              itemCount: 3,
                                              scrollDirection: Axis.horizontal,
                                              shrinkWrap: true,
                                              itemBuilder: (context, idx) {
                                                return SizedBox(
                                                  width: 28,
                                                  child: Center(
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "1",
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 8),
                                              child: Text("Nombre Apellido"),
                                            ),
                                            Icon(Icons.check),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            ListView.builder(
                                              itemCount: 3,
                                              scrollDirection: Axis.horizontal,
                                              shrinkWrap: true,
                                              itemBuilder: (context, idx) {
                                                return SizedBox(
                                                  width: 28,
                                                  child: Center(
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "1",
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text("3"),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
