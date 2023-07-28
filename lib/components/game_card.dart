import 'package:flutter/material.dart';

class GameCard extends StatelessWidget {
  const GameCard({
    super.key,
    required this.index,
    required this.title,
  });

  final int index;
  final String title;

  @override
  Widget build(BuildContext context) {
    String place = "Lugar";

    String time = "1:23";

    return Container(
      margin: const EdgeInsets.only(top: 12, bottom: 12),
      child: Card(
        color: Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 5,
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      child: Row(
                        children: [
                          const Icon(Icons.location_on_outlined),
                          Text(place),
                        ],
                      ),
                    ),
                    SizedBox(
                      child: Row(
                        children: [
                          const Icon(Icons.timer_outlined),
                          Text("Duracion: $time"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        "Nombre y Apellido",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    ListView.builder(
                      itemCount: 3,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          width: 32,
                          child: Center(
                            child: Text(
                              "$index",
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 40,
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        "Nombre y Apellido",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    ListView.builder(
                      itemCount: 3,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          width: 32,
                          child: Center(
                            child: Text(
                              "$index",
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
