import 'package:flutter/material.dart';

class CustomDropDown extends StatefulWidget {
  @override
  _CustomDropDownState createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  bool isExpanded = false;
  double aniWidth = 0;
  double aniHeight = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CustomDropDown'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Center(child: Text('hello')),
                  ),
                  InkWell(
                    onTap: () {
                      print('sort');
                      setState(() {
                        if (isExpanded) {
                          aniHeight = 0;
                        } else {
                          aniHeight = 36 * 6.0;
                        }
                        isExpanded = !isExpanded;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.sort,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      print('filter');
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.filter_list,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    child: SingleChildScrollView(
                      child: Column(
                        children: List.generate(50, (index) {
                          return Container(
                            height: 50,
                            width: double.infinity,
                            color: Colors.primaries[index%10],
                          );
                        }),
                      ),
                    ),
                  ),
                  isExpanded
                      ? GestureDetector(
                          onTap: () {
                            setState(() {
                              if (isExpanded) {
                                aniHeight = 0;
                                isExpanded = false;
                              }
                            });
                          },
                          child: Container(
                            color: Colors.transparent,
                          ),
                        )
                      : Container(),
                  Positioned(
                    right: 40,
                    child: AnimatedContainer(
                      height: aniHeight,
                      duration: Duration(milliseconds: 500),
                      color: Colors.white,
                      child: SingleChildScrollView(
                        child: Column(
                          children: List.generate(6, (index) {
                            return Material(
                              type: MaterialType.transparency,
                              child: InkWell(
                                onTap: () {
                                  print('item on click');
                                  setState(() {
                                    isExpanded = false;
                                    aniHeight = 0;

                                    showDialog(context: context, builder: (ctx) {
                                      return AlertDialog(
                                        title: Text('Inventis Filter'),
                                        content: Text('select index: $index'),
                                      );
                                    });
                                  });
                                },
                                child: Container(
                                  height: 36,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Text('hello 123 123'),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
