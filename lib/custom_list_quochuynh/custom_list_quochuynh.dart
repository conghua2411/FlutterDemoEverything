import 'package:flutter/material.dart';

import 'chart_item.dart';

class CustomListQuocHuynh extends StatefulWidget {
  @override
  State createState() => CustomListQuocHuynhState();
}

class CustomListQuocHuynhState extends State<CustomListQuocHuynh> {
  @override
  Widget build(BuildContext context) {
    print('width1 : ${MediaQuery.of(context).size.width}');

    return Scaffold(
      appBar: AppBar(
        title: Text('CustomListQuocHuynh'),
      ),
      body: Container(
        color: Colors.blue,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: HappinessChartWidget(
              height: 200,
              width: MediaQuery.of(context).size.width - 32,
              listChart: [
                ChartItem(average: 4 / 7, time: 1546300800),
                ChartItem(average: 2 / 7, time: 1548979200),
                ChartItem(average: 3 / 7, time: 1551398400),
                ChartItem(average: 4 / 7, time: 1554076800),
                ChartItem(average: 0, time: 1556668800),
                ChartItem(average: 1, time: 1559347200),
                ChartItem(average: 5 / 7, time: 1561939200),
                ChartItem(average: 0.4, time: 1564617600),
                ChartItem(average: 0.8, time: 1567296000),
                ChartItem(average: 0.8, time: 1567296000),
                ChartItem(average: 0.3, time: 1567296000),
                ChartItem(average: 0.2, time: 1567296000),
                ChartItem(average: 0.8, time: 1567296000),
                ChartItem(average: 0.8, time: 1567296000),
                ChartItem(average: 0.8, time: 1567296000),
                ChartItem(average: 0.9, time: 1567296000),
                ChartItem(average: 0.8, time: 1567296000),
                ChartItem(average: 0.7, time: 1567296000),
              ],
              listEmotion: [
                [0 / 7, 'assets/ic_loading.png'],
                [1 / 7, 'assets/line_test.png'],
                [2 / 7, 'assets/bg/hinh1.jpg'],
                [3 / 7, 'assets/bg/hinh2.jpg'],
                [4 / 7, 'assets/bg/hinh3.jpg'],
                [5 / 7, 'assets/ic_loading.png'],
                [6 / 7, 'assets/bg/hinh1.jpg'],
                [7 / 7, 'assets/ic_loading.png'],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HappinessChartWidget extends StatefulWidget {
  final double width;
  final double height;

  final List<dynamic> listEmotion;
  final List<ChartItem> listChart;

  HappinessChartWidget({
    this.width,
    this.height,
    this.listEmotion,
    this.listChart,
  });

  @override
  State createState() => HappinessChartWidgetState();
}

class HappinessChartWidgetState extends State<HappinessChartWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        color: Color(0xfff9e9dc),
        borderRadius: BorderRadius.circular(4),
      ),
      child: ListView.builder(
        reverse: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Column(
            children: <Widget>[
              Container(
                child: HappinessItem(
                  height: widget.height * 0.6,
                  width: widget.width / 7,
                  item: widget.listChart[index],
                  itemLeft: index != 0 ? widget.listChart[index - 1] : null,
                  itemRight: index != widget.listChart.length - 1
                      ? widget.listChart[index + 1]
                      : null,
                  emotion: _getEmotion(widget.listChart[index].average),
                ),
                width: widget.width / 7,
              ),
              _buildDate(widget.height * 0.3, widget.listChart[index].time),
              SizedBox(
                width: 16,
              ),
            ],
          );
        },
        itemCount: widget.listChart.length,
      ),
    );
  }

  _buildDate(double height, double timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp.toInt() * 1000);
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            _convertWeekDay(date.weekday),
            style: TextStyle(color: Color(0xff939399), fontSize: 14),
          ),
          Text(
            '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}',
            style: TextStyle(
              color: Color(0xffbebec2),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  String _convertWeekDay(int weekDay) {
    switch (weekDay) {
      case 1:
        return 'MON';
      case 2:
        return 'TUE';
      case 3:
        return 'WED';
      case 4:
        return 'THU';
      case 5:
        return 'FRI';
      case 6:
        return 'SAT';
      case 7:
        return 'SUN';
      default:
        return 'MON';
    }
  }

  String _getEmotion(double average) {
    for (int i = 0; i < widget.listEmotion.length; i++) {
      if (average <= widget.listEmotion[i][0]) {
        return widget.listEmotion[i][1];
      }
    }
    return widget.listEmotion[0][1];
  }
}

class HappinessItem extends StatefulWidget {
  final double height;
  final double width;

  final ChartItem item;
  final ChartItem itemLeft;
  final ChartItem itemRight;

  final String emotion;

  HappinessItem({
    this.height,
    this.width,
    this.item,
    this.itemLeft,
    this.itemRight,
    this.emotion,
  });

  @override
  State createState() => HappinessItemState();
}

class HappinessItemState extends State<HappinessItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              top: 16,
              bottom: 16,
            ),
            child: Container(
              width: double.infinity,
              height: widget.height,
              child: CustomPaint(
                foregroundPainter: HappinessItemPainter(
                  item: widget.item,
                  itemLeft: widget.itemRight,
                  itemRight: widget.itemLeft,
                ),
              ),
            ),
          ),
          Positioned(
            top: (widget.height - 32) * (1 - widget.item.average) + 18,
            left: widget.width / 2 - 12,
            child: Container(
              child: Container(
                child: Image.asset(
                  widget.emotion,
                  width: 24,
                  height: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HappinessItemPainter extends CustomPainter {
  final ChartItem item;
  final ChartItem itemLeft;
  final ChartItem itemRight;

  HappinessItemPainter({
    this.item,
    this.itemLeft,
    this.itemRight,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Size realSize = Size(size.width, size.height - 24);

    Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    double posYItem = realSize.height * (1 - item.average) + 12;

    if (itemLeft != null) {
      double posYItemLeft = realSize.height *
              (((1 - item.average) + (1 - itemLeft.average)) / 2) +
          12;
      canvas.drawLine(
          Offset(realSize.width / 2, posYItem), Offset(0, posYItemLeft), paint);
    }

    if (itemRight != null) {
      double posYItemRight = realSize.height *
              (((1 - item.average) + (1 - itemRight.average)) / 2) +
          12;
      canvas.drawLine(Offset(realSize.width / 2, posYItem),
          Offset(realSize.width, posYItemRight), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
