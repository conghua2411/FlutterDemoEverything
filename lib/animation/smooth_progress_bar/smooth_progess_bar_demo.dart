import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/animation/smooth_progress_bar/smooth_progress_bar.dart';

class SmoothProgressBarDemo extends StatefulWidget {
  @override
  _SmoothProgressBarDemoState createState() => _SmoothProgressBarDemoState();
}

class _SmoothProgressBarDemoState extends State<SmoothProgressBarDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      appBar: AppBar(
        title: Text(
          'SmoothProgressBarDemo',
        ),
      ),
      body: Center(
        child: ProgressCard(),
      ),
    );
  }
}

class ProgressCard extends StatefulWidget {
  @override
  _ProgressCardState createState() => _ProgressCardState();
}

class _ProgressCardState extends State<ProgressCard> {
  double progressPercent = 0;

  Timer _timer;

  DateTime start = DateTime.now();
  Duration duration = Duration(seconds: 2);

  bool playing = true;

  double calPercent({DateTime start}) {
    Duration played = DateTime.now().difference(start);
    return played.inMilliseconds / duration.inMilliseconds;
  }

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      if (playing == false)
        return;

      if (progressPercent >= 1) {
        playing = false;
        return;
      }

      setState(() {
        this.progressPercent = calPercent(
          start: start,
        );
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color foreground = Colors.red;

    Color background = foreground.withOpacity(0.2);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SmoothProgressBar(
              backgroundColor: background,
              foregroundColor: foreground,
              value: this.progressPercent,
            ),
          ),
        ),
        Text("${this.progressPercent * 100}%"),
        FlatButton(
          onPressed: () {
            setState(() {
              progressPercent = 0;
            });

            Future.delayed(Duration(seconds: 1), () {
              setState(() {
                start = DateTime.now();
                playing = true;
              });
            });
          },
          child: Text('Start'),
        ),
      ],
    );
  }
}
