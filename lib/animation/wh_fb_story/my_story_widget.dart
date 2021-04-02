import 'package:flutter/material.dart';

class MyStoryWidget extends StatefulWidget {
  final String imageUrl;

  final Color backgroundColor;

  final double percent;
  final double itemWidth;
  final double itemHeight;

  final double itemWidthCollapse;
  final double itemHeightCollapse;

  final double itemPadding;

  final double avatarPadding;
  final double avatarPaddingCollapse;

  MyStoryWidget({
    this.imageUrl,
    this.backgroundColor = Colors.white,
    this.percent,
    this.itemWidth,
    this.itemHeight,
    this.itemWidthCollapse,
    this.itemHeightCollapse,
    this.itemPadding,
    this.avatarPadding,
    this.avatarPaddingCollapse,
  });

  @override
  _MyStoryWidgetState createState() => _MyStoryWidgetState();
}

class _MyStoryWidgetState extends State<MyStoryWidget> {
  double myStoryBorderTopLeft = 10;
  double myStoryBorderTopRight = 10;
  double myStoryBorderBottomLeft = 10;
  double myStoryBorderBottomRight = 10;

  double myStoryBorderTopLeftEnd = 0;
  double myStoryBorderTopRightEnd = 50;
  double myStoryBorderBottomLeftEnd = 0;
  double myStoryBorderBottomRightEnd = 50;

  double myStoryWidth = 110;
  double myStoryCollapseWidth = 50;

  double myStoryHeight = 100;
  double myStoryCollapseHeight = 50;

  bool showContainerLeft = false;

  double avatarPadding = 0;

  double avatarBorderTop = 10;
  double avatarBorderBottom = 0;

  double fontSize = 12;

  double textPadding = 4;

  double calculatePercentValue({
    double start,
    double end,
    double percent,
  }) {
    return (end - start) * percent + start;
  }

  @override
  Widget build(BuildContext context) {
    myStoryBorderTopLeft = calculatePercentValue(
      start: 10,
      end: myStoryBorderTopLeftEnd,
      percent: widget.percent,
    );

    myStoryBorderTopRight = calculatePercentValue(
      start: 10,
      end: myStoryBorderTopRightEnd,
      percent: widget.percent,
    );

    myStoryBorderBottomLeft = calculatePercentValue(
      start: 10,
      end: myStoryBorderBottomLeftEnd,
      percent: widget.percent,
    );

    myStoryBorderBottomRight = calculatePercentValue(
      start: 10,
      end: myStoryBorderBottomRightEnd,
      percent: widget.percent,
    );

    myStoryWidth = calculatePercentValue(
      start: widget.itemWidth,
      end: widget.itemWidthCollapse,
      percent: widget.percent,
    );

    myStoryHeight = calculatePercentValue(
      start: widget.itemHeight,
      end: widget.itemHeightCollapse,
      percent: widget.percent,
    );

    if (widget.percent >= 1) {
      showContainerLeft = true;
    } else {
      showContainerLeft = false;
    }

    avatarPadding = calculatePercentValue(
      start: widget.avatarPadding,
      end: widget.avatarPaddingCollapse,
      percent: widget.percent,
    );

    avatarBorderTop = calculatePercentValue(
      start: 10,
      end: 50,
      percent: widget.percent,
    );

    avatarBorderBottom = calculatePercentValue(
      start: 0,
      end: 50,
      percent: widget.percent,
    );

    fontSize = calculatePercentValue(
      start: 20,
      end: 0,
      percent: widget.percent,
    );

    if (fontSize > 14) fontSize = 14;

    textPadding = calculatePercentValue(
      start: 4,
      end: -2,
      percent: widget.percent,
    );

    if (textPadding < 0) textPadding = 0;

    return Row(
      children: [
        Container(
          width: widget.itemPadding * 2,
          height: myStoryHeight,
          color:
              showContainerLeft ? widget.backgroundColor : Colors.transparent,
        ),
        Padding(
          padding: EdgeInsets.only(
            right: widget.itemPadding,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                  myStoryBorderTopLeft,
                ),
                topRight: Radius.circular(
                  myStoryBorderTopRight,
                ),
                bottomLeft: Radius.circular(
                  myStoryBorderBottomLeft,
                ),
                bottomRight: Radius.circular(
                  myStoryBorderBottomRight,
                ),
              ),
              child: Container(
                width: myStoryWidth,
                height: myStoryHeight,
                decoration: BoxDecoration(
                  color: widget.backgroundColor,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        child: Padding(
                          padding: EdgeInsets.all(
                            avatarPadding,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(
                                avatarBorderTop,
                              ),
                              topRight: Radius.circular(
                                avatarBorderTop,
                              ),
                              bottomLeft: Radius.circular(
                                avatarBorderBottom,
                              ),
                              bottomRight: Radius.circular(
                                avatarBorderBottom,
                              ),
                            ),
                            child: Image.network(
                              widget.imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: textPadding,
                        horizontal: 4,
                      ),
                      child: Text(
                        'Create a Story',
                        style: TextStyle(
                          fontSize: fontSize,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
