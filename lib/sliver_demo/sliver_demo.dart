import 'package:flutter/material.dart';

class SliverDemo extends StatefulWidget {
  @override
  State createState() => SliverDemoState();
}

class SliverDemoState extends State<SliverDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SliverDemo'),
      ),
      body: Container(
        child: CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    width: double.infinity,
                    height: 200,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Container(
                    width: double.infinity,
                    height: 100.0,
                    child: Center(
                      child: Text(
                        'index: $index',
                        style: TextStyle(
                          color: Colors.amber[(index % 9 + 1) * 100],
                        ),
                      ),
                    ),
                  );
                },
                childCount: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildContainer1() {
    return SliverToBoxAdapter(
      child: Container(
        width: double.infinity,
        height: 200,
        color: Colors.blue,
      ),
    );
  }

  _buildContainer2() {
    return SliverToBoxAdapter(
      child: Container(
        width: double.infinity,
        height: 300,
        color: Colors.grey,
        child: CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Container(
                    width: double.infinity,
                    height: 100,
                    color: Colors.amber[(index % 9 + 1) * 100],
                  );
                },
                childCount: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
