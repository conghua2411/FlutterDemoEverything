import 'package:flutter/material.dart';

class InventisFilter extends StatefulWidget {
  @override
  _InventisFilterState createState() => _InventisFilterState();
}

class _InventisFilterState extends State<InventisFilter> {
  List<String> filters = [
    'At a Glance',
    'Exteior',
    'Inteior',
    'Primary Safety',
    'Secondary Safety',
    'Engine & Transmossion',
    'Dimentions & Weights',
    'Equipment',
  ];

  List<String> selectedFilters = [];

  int selectedDropDown;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inventis filter'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 8,
                ),
                Text(
                  'Year',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Wrap(
                  children: filters.map(
                    (filter) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: selectedFilters.contains(filter)
                                ? Colors.blue
                                : Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: selectedFilters.contains(filter)
                                ? []
                                : [
                                    BoxShadow(
                                      color: Colors.black12,
                                      offset: Offset(2, 2),
                                      blurRadius: 1,
                                      spreadRadius: 1,
                                    ),
                                  ],
                          ),
                          child: Material(
                            type: MaterialType.transparency,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(8),
                              onTap: () {
                                setState(() {
                                  if (selectedFilters.contains(filter)) {
                                    selectedFilters.remove(filter);
                                  } else {
                                    selectedFilters.add(filter);
                                  }
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '$filter',
                                  style: TextStyle(
                                    color: selectedFilters.contains(filter)
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  'Model',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  child: DropdownButton(
                    isExpanded: true,
                    underline: Container(
                      color: Colors.transparent,
                    ),
                    value: selectedDropDown,
                    items: [
                      DropdownMenuItem(
                        child: Text(
                          '2020 KONA',
                        ),
                        value: 2020,
                      ),
                      DropdownMenuItem(
                        child: Text(
                          '2019 KONA',
                        ),
                        value: 2019,
                      ),
                      DropdownMenuItem(
                        child: Text(
                          '2018 KONA',
                        ),
                        value: 2018,
                      ),
                      DropdownMenuItem(
                        child: Text(
                          '2017 KONA',
                        ),
                        value: 2017,
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedDropDown = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
