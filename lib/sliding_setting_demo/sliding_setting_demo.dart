import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'color_picker/color_picker.dart';
import 'color_picker/custom_slide_color_bar.dart';

enum ColorSettingState { CB_PALETTE, CUSTOM }

class SlidingSettingDemo extends StatefulWidget {
  @override
  State createState() => SlidingSettingState();
}

class SlidingSettingState extends State<SlidingSettingDemo> {
  StreamController<bool> isShowSlidingSettingStream = StreamController();
  bool isShowSlidingSetting = false;

  BehaviorSubject<ColorSettingState> bsSettingState = BehaviorSubject();

  BehaviorSubject<int> bsColorIndexSelected = BehaviorSubject();

  BehaviorSubject<int> bsTextColorIndexSelected = BehaviorSubject();

  BehaviorSubject<Color> bsBackgroundColor = BehaviorSubject();

  BehaviorSubject<Color> bsRealBackgroundColor = BehaviorSubject();

  TextEditingController _colorHexText = TextEditingController();

  BehaviorSubject<Color> bsRealTextColor = BehaviorSubject();

  TextStyle selectedTextStyle = TextStyle(
    color: Colors.black,
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );

  TextStyle unselectedTextStyle = TextStyle(
    color: Color(0xffadadad),
    fontSize: 14,
  );

  @override
  void initState() {
    super.initState();

    bsRealBackgroundColor.listen((color) {
      _colorHexText.text = color.value.toRadixString(16);
    });
  }

  @override
  void dispose() {
    isShowSlidingSettingStream.close();
    bsSettingState.close();
    bsColorIndexSelected.close();
    bsTextColorIndexSelected.close();
    bsBackgroundColor.close();
    bsRealBackgroundColor.close();
    bsRealTextColor.close();

    _colorHexText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: StreamBuilder<Color>(
            initialData: Colors.white,
            stream: bsRealTextColor,
            builder: (context, snapshot) {
              return IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: snapshot.data,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  });
            }),
        title: StreamBuilder<Color>(
            initialData: Colors.white,
            stream: bsRealTextColor,
            builder: (context, snapshot) {
              return Text(
                'SlidingSettingDemo',
                style: TextStyle(
                  color: snapshot.data,
                ),
              );
            }),
      ),
      body: Stack(
        children: <Widget>[
          StreamBuilder<Color>(
              initialData: Colors.amber,
              stream: bsRealBackgroundColor,
              builder: (context, snapshot) {
                return Container(
                  color: snapshot.data,
                  child: Center(
                    child: Text("This is the Widget behind the sliding panel"),
                  ),
                );
              }),
          StreamBuilder<bool>(
              initialData: isShowSlidingSetting,
              stream: isShowSlidingSettingStream.stream,
              builder: (context, snapshot) {
                if (snapshot.data) {
                  return SlidingUpPanel(
//                    isDraggable: false,
                    color: Colors.transparent,
                    minHeight: 200,
                    panel: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 32,
                              height: 4,
                              decoration: BoxDecoration(
                                color: Color(0xFFdcdcdc),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 16,
                              right: 16,
                              top: 8,
                              bottom: 8,
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Background Color',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 16,
                              right: 16,
                              top: 8,
                              bottom: 8,
                            ),
                            child: StreamBuilder<ColorSettingState>(
                              initialData: ColorSettingState.CB_PALETTE,
                              stream: bsSettingState,
                              builder: (context, snapshot) {
                                return Row(
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        bsSettingState
                                            .add(ColorSettingState.CB_PALETTE);
                                      },
                                      child: Container(
                                        child: Text(
                                          'CB PALETTE',
                                          style: snapshot.data ==
                                                  ColorSettingState.CB_PALETTE
                                              ? selectedTextStyle
                                              : unselectedTextStyle,
                                        ),
                                        decoration: snapshot.data ==
                                                ColorSettingState.CB_PALETTE
                                            ? BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                    color: Colors.black,
                                                    width: 2,
                                                  ),
                                                ),
                                              )
                                            : BoxDecoration(),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 24,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        bsSettingState
                                            .add(ColorSettingState.CUSTOM);
                                      },
                                      child: Container(
                                        child: Text(
                                          'CUSTOM',
                                          style: snapshot.data ==
                                                  ColorSettingState.CB_PALETTE
                                              ? unselectedTextStyle
                                              : selectedTextStyle,
                                        ),
                                        decoration: snapshot.data ==
                                                ColorSettingState.CB_PALETTE
                                            ? BoxDecoration()
                                            : BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                    color: Colors.black,
                                                    width: 2,
                                                  ),
                                                ),
                                              ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          StreamBuilder<ColorSettingState>(
                            initialData: ColorSettingState.CB_PALETTE,
                            stream: bsSettingState,
                            builder: (context, snapshot) {
                              if (snapshot.data ==
                                  ColorSettingState.CB_PALETTE) {
                                return StreamBuilder<int>(
                                  initialData: 0,
                                  stream: bsColorIndexSelected,
                                  builder: (context, snapshot) {
                                    return _buildCBPalette(snapshot.data);
                                  },
                                );
                              } else {
                                return _buildCustom();
                              }
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 16,
                              right: 16,
                              top: 8,
                              bottom: 8,
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Text Color',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          StreamBuilder<int>(
                            initialData: 0,
                            stream: bsTextColorIndexSelected,
                            builder: (context, snapshot) {
                              return _buildTextColor(snapshot.data);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              })
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          isShowSlidingSetting = !isShowSlidingSetting;
          isShowSlidingSettingStream.add(isShowSlidingSetting);

//          _testModelBottomSheet();
        },
      ),
    );
  }

  _buildCBPalette(int selectedItem) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(
            10,
            (index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    bsColorIndexSelected.add(index);
                    bsRealBackgroundColor
                        .add(Colors.amber[(index % 9 + 1) * 100]);
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.amber[(index % 8 + 2) * 100], width: 1),
                    ),
                    child: Padding(
                      padding: selectedItem == index
                          ? const EdgeInsets.all(6)
                          : const EdgeInsets.all(0),
                      child: Container(
                        color: Colors.amber[(index % 9 + 1) * 100],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  _buildCustom() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 34,
        right: 34,
        top: 16,
        bottom: 16,
      ),
      child: Column(
        children: <Widget>[
          Container(
            color: Color.fromRGBO(0, 0, 0, 0.2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                CircleColorPicker(
                  radius: 80,
                  initialColor: Color(0xffffff00),
                  thumbColor: Color(0xffffff00),
                  thumbRadius: 10,
                  colorListener: (int value) {
                    print('ColorPicker: $value');
                    bsBackgroundColor.add(Color(value));
                  },
                ),
                StreamBuilder<Color>(
                  initialData: Colors.black,
                  stream: bsBackgroundColor,
                  builder: (context, snapshot) {
                    return BarColorPicker(
                      width: 160,
                      initialColor: snapshot.data,
                      pickMode: PickMode.Specific_Color,
                      colorListener: (value) {
                        print('BarColorPicker 123: $value');
                        bsRealBackgroundColor.add(Color(value));
                      },
                      horizontal: false,
                      bsSpecificColor: bsBackgroundColor,
                      thumbColor: Colors.white,
                    );
                  },
                ),
//        _buildCustomSlider(),
              ],
            ),
          ),
          Container(
            width: 110,
            child: Row(
              children: <Widget>[
                Text(
                  'Hex',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextField(
                    enabled: false,
                    controller: _colorHexText,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildCustomSlider() {
    return StreamBuilder<Color>(
      initialData: Colors.white,
      stream: bsRealBackgroundColor,
      builder: (context, snapshot) {
        return CustomSlideColorBar(
          colorMain: snapshot.data,
        );
      },
    );
  }

  _buildTextColor(int selectedItem) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              2,
              (index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      bsTextColorIndexSelected.add(index);
                      bsRealTextColor
                          .add(index == 0 ? Colors.white : Colors.black);
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: index == 0
                                ? selectedItem == index
                                    ? Colors.black
                                    : Color(0xffdcdcdc)
                                : Colors.black),
                      ),
                      child: Padding(
                        padding: selectedItem == index
                            ? const EdgeInsets.all(6)
                            : const EdgeInsets.all(0),
                        child: Container(
                          color: index == 0 ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _testModelBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Container(
          height: 250,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Sup bro',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextField(
                  controller: _colorHexText,
                  decoration: InputDecoration(hintText: 'asdadasd'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
