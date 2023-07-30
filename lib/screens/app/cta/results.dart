import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tennis_app/components/cta/clash/clash_card.dart';
import 'package:tennis_app/dtos/category_dto.dart';
import 'package:tennis_app/dtos/clash_dtos.dart';
import 'package:tennis_app/services/list_clash.dart';

class ClashResults extends StatefulWidget {
  const ClashResults({
    super.key,
    required this.categories,
  });

  final List<CategoryDto> categories;

  @override
  State<ClashResults> createState() => _ClashResultsState();
}

class _ClashResultsState extends State<ClashResults> {
  List<ClashDto> _clashs = [];
  List<ClashDto> _filteredClash = [];

  String? selectedCategory;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  _getData() async {
    EasyLoading.show(status: "Cargando...");
    await _listClashResults();
    EasyLoading.dismiss();
  }

  _listClashResults() async {
    Map<String, String> query = {
      'isFinish': 'true',
    };

    final result = await listClash(query);

    if (result.isFailure) {
      EasyLoading.showError("Ha ocurrido un error");
      return;
    }

    setState(() {
      _clashs = result.getValue();
      _filteredClash = result.getValue();
    });
  }

  filterResults() {
    var filteredClash = _clashs;

    if (selectedCategory != null) {
      filteredClash.where(
          (ClashDto element) => element.categoryName == selectedCategory);
    }

    setState(() {
      _filteredClash = filteredClash;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(children: [
        SizedBox(
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.filter_list,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  const Text("Filtrar por:"),
                ],
              ),
              DropdownButton(
                value: selectedCategory,
                items: widget.categories
                    .map((CategoryDto e) => DropdownMenuItem(
                          value: e.name,
                          child: Text(e.name),
                        ))
                    .toList(),
                onChanged: (dynamic value) {
                  setState(() {
                    selectedCategory = value;
                  });
                  filterResults();
                },
                hint: const Text("Categoria"),
              ),
              TextButton(
                  onPressed: () {
                    setState(() {
                      selectedCategory = null;
                    });
                    filterResults();
                  },
                  child: const Text("Limpiar"))
            ],
          ),
        ),
        Expanded(
          child: ListView(
            children: _filteredClash
                .asMap()
                .entries
                .map(
                  (entry) => ClashCard(clash: entry.value),
                )
                .toList(),
          ),
        ),
      ]),
    );
  }
}
