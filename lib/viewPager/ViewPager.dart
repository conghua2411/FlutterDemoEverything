import 'package:flutter/material.dart';

class ViewPagerDemo extends StatefulWidget {
  @override
  State createState() => ViewPagerState();
}

class ViewPagerState extends State<ViewPagerDemo>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ViewPager'),
      ),
      body: Center(
        child: TabBarView(
          controller: _tabController,
          children: <Widget>[
            Container(
              color: Colors.blue,
              child: Center(
                child: Text('1'),
              ),
            ),
            Container(
              color: Colors.red,
              child: Center(
                child: Text('2'),
              ),
            ),
            Container(
              color: Colors.white,
              child: Center(
                child: Text('3'),
              ),
            ),
            Container(
              color: Colors.yellow,
              child: Center(
                child: Text('4'),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: TabBar(
        tabs: [
          Tab(
            icon: Icon(Icons.home),
          ),
          Tab(
            icon: Icon(Icons.android),
          ),
          Tab(
            icon: Icon(Icons.star),
          ),
          Tab(
            icon: Icon(Icons.event),
          ),
        ],
        controller: _tabController,
        labelColor: Colors.yellow,
        unselectedLabelColor: Colors.black,
        indicatorColor: Colors.yellow,
      ),
    );
  }
}
