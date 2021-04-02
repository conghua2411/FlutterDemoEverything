import 'package:flutter/material.dart';
import 'package:flutter_app/animation/wh_fb_story/fb_story_bar.dart';

class FacebookStoryDemo extends StatefulWidget {
  @override
  _FacebookStoryDemoState createState() => _FacebookStoryDemoState();
}

class _FacebookStoryDemoState extends State<FacebookStoryDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'FacebookStoryDemo',
        ),
      ),
      body: SafeArea(
        child: Center(
          child: FbStoryBar(),
        ),
      ),
    );
  }
}
