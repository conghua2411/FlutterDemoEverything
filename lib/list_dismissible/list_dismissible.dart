import 'package:flutter/material.dart';

class ListDismissibleView extends StatefulWidget {
  @override
  _ListDismissibleViewState createState() => _ListDismissibleViewState();
}

class _ListDismissibleViewState extends State<ListDismissibleView> {
  List<String> generateFake(int length) {
    return List.generate(length, (index) {
      return 'Item : ${index + 1} ---------- ';
    });
  }

  List<String> _listItem;

  @override
  void initState() {
    super.initState();
    _listItem = generateFake(100);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  color: Colors.blue[200],
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.amber[700],
                ),
              ),
            ],
          ),
          SafeArea(
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        borderRadius: BorderRadius.circular(100),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.arrow_back_ios),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'List Dismissible',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView(
                      children: _listItem.map((item) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Dismissible(
                            onDismissed: (direction) {
                              print('direction: $direction');
                              if (direction == DismissDirection.endToStart) {
                                setState(() {
                                  _listItem.remove(item);
                                });
                              }
                            },
                            background: Container(
                              color: Colors.green,
                              child: Icon(Icons.delete),
                            ),
                            key: ValueKey(item),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  width: 1,
                                  color: Color(0xffEAA221),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  '$item',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
