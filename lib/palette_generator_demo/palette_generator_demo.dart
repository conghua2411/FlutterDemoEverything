import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class PaletteGeneratorDemo extends StatefulWidget {
  @override
  State createState() => PaletteGeneratorDemoState();
}

class PaletteGeneratorDemoState extends State<PaletteGeneratorDemo> {
  Color color1, color2, color3;

  @override
  void initState() {
    super.initState();

    color1 = Colors.blue;
    color2 = Colors.blue;
    color3 = Colors.blue;

    print('init: ${DateTime.now()}');

//    calculatePaletteColor();
  }

  Future calculate() async {
//    for (int i = 0 ; i < )
  }

  @override
  Widget build(BuildContext context) {
    print('build: ${DateTime.now()}');
    return Scaffold(
      appBar: AppBar(
        title: Text('PaletteGeneratorDemo'),
      ),
      body: PageView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.red,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: color1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: color2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: color3,
            ),
          ),
        ],
      ),
    );
  }

  void calculatePaletteColor() {
    print('calculatePaletteColor: ${DateTime.now()}');
    for (int i = 1; i <= 3; i++) {
      var palette = PaletteGenerator.fromImageProvider(
          AssetImage("assets/bg/hinh$i.jpg"));
      palette.then((palette) {
        print('calculatePaletteColor: begin $i: ${DateTime.now()}');

        print('palette.dominantColor: ${palette.dominantColor}');

        setState(() {
          switch (i) {
            case 1:
              color1 = palette.dominantColor.color;
              break;
            case 2:
              color2 = palette.dominantColor.color;
              break;
            case 3:
              color3 = palette.dominantColor.color;
              break;
          }
        });

        print('calculatePaletteColor: end $i: ${DateTime.now()}');
      });
    }
  }
}
