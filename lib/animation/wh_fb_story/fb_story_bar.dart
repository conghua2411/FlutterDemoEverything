import 'package:flutter/material.dart';

import 'my_story_widget.dart';

class FbStoryBar extends StatefulWidget {
  @override
  _FbStoryBarState createState() => _FbStoryBarState();
}

class _FbStoryBarState extends State<FbStoryBar> {
  /// list view
  ///
  double itemWidth = 80;
  double itemHeight = 120;
  double itemPadding = 4;

  /// animation
  ///
  double percent = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: Stack(
        children: [
          NotificationListener<ScrollNotification>(
            onNotification: (scrollNotification) {
              if (scrollNotification.metrics.pixels >
                  (itemWidth + itemPadding * 2)) {
                setState(() {
                  percent = 1;
                });
                return false;
              }

              double scrollPixel = scrollNotification.metrics.pixels;
              if (scrollPixel < 0) scrollPixel = 0;

              setState(() {
                percent = scrollPixel / (itemWidth + itemPadding * 2);
              });

              return false;
            },
            child: ListView.builder(
              padding: EdgeInsets.only(
                left: itemPadding + itemWidth + itemPadding * 2,
                right: itemPadding,
              ),
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, index) {
                return StoryItem(
                  itemWidth: itemWidth,
                  itemHeight: itemHeight,
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: MyStoryWidget(
              imageUrl: 'https://picsum.photos/id/237/200/300',
              backgroundColor: Colors.blue,
              percent: percent,
              itemPadding: itemPadding,
              itemWidth: itemWidth,
              itemWidthCollapse: 54,
              itemHeight: itemHeight,
              itemHeightCollapse: 54,
              avatarPadding: 0,
              avatarPaddingCollapse: 6,
            ),
          ),
        ],
      ),
    );
  }
}

class StoryItem extends StatelessWidget {
  final double itemWidth;
  final double itemHeight;

  StoryItem({
    this.itemWidth = 80,
    this.itemHeight = 120,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 4,
      ),
      child: Container(
        width: itemWidth,
        height: itemHeight,
        color: Colors.red,
      ),
    );
  }
}
