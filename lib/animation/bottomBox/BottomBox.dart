import 'package:flutter/material.dart';

class BottomBoxScreen extends StatefulWidget {
  @override
  State createState() => BottomBoxState();
}

class BottomBoxState extends State<BottomBoxScreen> {
  double bottomBoxHeight = 240;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var maxWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('BottomBox'),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.blue,
          child: Stack(
            children: <Widget>[
              BottomViewColor(maxWidth, bottomBoxHeight, (background) {
                print('background : $background');
              }, (text) {
                print('text : $text');
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomViewColor extends StatefulWidget {
  final double width, height;

  final Function(String color) updateBackgroundColor;

  final Function(String color) updateTextColor;

  BottomViewColor(this.width, this.height, this.updateBackgroundColor, this.updateTextColor);

  @override
  State createState() => BottomViewColorState();
}

class BottomViewColorState extends State<BottomViewColor>
    with TickerProviderStateMixin {

  AnimationController _animationController;
  Animation<double> _animation;

  bool _isForward = true;

  TabController _tabController;

  bool _isBackgroundSelected = true;

  PageController _pageColorController;

  int _itemBackgroundSelected = 0;

  int _itemTextSelected = 0;

  Map<String, String> _backgroundColors, _textColors;

  List _listBackgroundColor, _listTextColor;

  BottomViewColorState() {
    _backgroundColors = {
      'blue4': '#3e00ff',
      'purple1': '#6300ff',
      'purple2': '#8c1dff',
      'purple3': '#c01dff',
      'pink1': '#ff00f4',
      'pink2': '#ff00a5',
      'bred1': '#ff0050',
      'bred2': '#f60606',
      'orange1': '#f66606',
      'orange2': '#ff9000',
      'yellow300': '#ffe300',
      'yellow800': '#fffd00',
      'green1': '#bdf400',
      'green2': '#00f406',
      'green3': '#00f498',
      'blue1': '#00efd9',
      'blue2': '#00e9ff',
      'blue3': '#00c7ff',
      'white': '#ffffff',
      'black': '#000000',
    };

    _listBackgroundColor = List.from({
      '#3e00ff', '#6300ff', '#8c1dff', '#c01dff', '#ff00f4', '#ff00a5', '#ff0050', '#f60606', '#f66606', '#ff9000' '#ffe300', '#fffd00',
      '#bdf400', '#00f406', '#00f498', '#00efd9', '#00e9ff', '#00c7ff', '#ffffff', '#000000'
    });

    _textColors = {
      'white': '#ffffff',
      'black': '#000000',
    };

    _listTextColor = List.from({
      '#ffffff', '#000000'
    });
  }

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    _animation = Tween<double>(begin: -widget.height * 2 / 3, end: 0)
        .animate(_animationController)
          ..addListener(() {
            setState(() {});
          });

    _tabController = TabController(length: 2, vsync: this);

    _tabController.addListener(() {
      setState(() {
        _isBackgroundSelected = _tabController.index == 0;
      });

      if (_isBackgroundSelected) {
        print('jump 0');
        _pageColorController.jumpToPage(0);
      } else {
        print('jump 1');
        _pageColorController.jumpToPage(1);
      }
    });

    _pageColorController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      height: widget.height,
      width: widget.width,
      bottom: _animation.value,
      child: Container(
        color: hexToColor('#f8f8f8'),
        child: Column(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_drop_up),
              onPressed: () {
                playAnimation();
              },
            ),
            Container(
              child: TabBar(
                indicatorColor: Colors.black,
                controller: _tabController,
                tabs: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Background Color',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: _isBackgroundSelected
                              ? FontWeight.bold
                              : FontWeight.normal),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Text Color',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: !_isBackgroundSelected
                              ? FontWeight.bold
                              : FontWeight.normal),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: widget.width,
              height: 150,
              child: PageView(
                controller: _pageColorController,
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  Container(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          children: List.generate(_listBackgroundColor.length, (index) {
                        return GestureDetector(
                          onTap: () => onItemBackgroundClick(index),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              margin: EdgeInsets.only(bottom: index == _itemBackgroundSelected ? 20.0 : 0.0),
                              decoration: BoxDecoration(
                                color: hexToColor(_listBackgroundColor[index]),
                                border: Border.all(
                                  color: Colors.white,
                                  width: index == _itemBackgroundSelected ? 2.0 : 0.0,
                                  style: BorderStyle.solid
                                )
                              ),
                              width: index == _itemBackgroundSelected ? 60 : 58,
                              height: index == _itemBackgroundSelected ? 60 : 58,
//                            color: Colors.amber[((index % 9) + 1) * 100],
                            ),
                          ),
                        );
                      })),
                    ),
                  ),
                  Container(
                    child: Row(
                      children: List.generate(_listTextColor.length, (index) {
                        return Flexible(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () => onItemTextClick(index),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                margin: EdgeInsets.only(bottom: index == _itemTextSelected ? 20.0 : 0.0),
                                height: 58,
                                decoration: BoxDecoration(
                                  color: hexToColor(_listTextColor[index]),
                                    border: Border.all(
                                        color: Colors.white,
                                        width: index == _itemTextSelected ? 2.0 : 0.0,
                                        style: BorderStyle.solid
                                    )
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void playAnimation() {
    if (_isForward) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    _isForward = !_isForward;
  }

  onItemBackgroundClick(int index) {
    widget.updateBackgroundColor('index : ${_listBackgroundColor[index]}');
    setState(() {
      _itemBackgroundSelected = index;
    });
  }

  onItemTextClick(int index) {
    widget.updateTextColor('index text: ${_listTextColor[index]}');
    setState(() {
      _itemTextSelected = index;
    });
  }

  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }
}
