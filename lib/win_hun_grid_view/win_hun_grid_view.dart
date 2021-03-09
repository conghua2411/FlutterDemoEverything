import 'dart:math';

import 'package:flutter/material.dart';

class WinHunGridView extends StatefulWidget {
  @override
  _WinHunGridViewState createState() => _WinHunGridViewState();
}

class _WinHunGridViewState extends State<WinHunGridView> {
  double _horizontalPadding = 16;

  Future<double> _paddingAdjust() {
    return showModalBottomSheet<double>(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Adjust padding',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop(_horizontalPadding);
                    },
                    child: Text(
                      'OK',
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: StatefulBuilder(
                builder: (context, setState) {
                  return Slider(
                    min: 0,
                    max: 150,
                    value: _horizontalPadding,
                    onChanged: (value) {
                      setState(() {
                        _horizontalPadding = value;
                      });
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WinHunGridView'),
        actions: [
          FlatButton(
            onPressed: () {
              _paddingAdjust().then((value) {
                if (value != null) {
                  setState(() {
                    _horizontalPadding = value;
                  });
                }
              });
            },
            child: Text(
              '${_horizontalPadding.toStringAsFixed(2)}',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 16,
            horizontal: _horizontalPadding,
          ),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (context, index) {
              return _buildItem();
            },
            itemCount: 51,
          ),
        ),
      ),
    );
  }

  Widget _buildItem() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: constraints.maxWidth,
                height: constraints.maxHeight - 14 * 1.3 * 3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://picsum.photos/id/237/200/300',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text(
                'asdas sada sdas d' * (Random().nextInt(20) + 1),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      },
    );
  }
}
