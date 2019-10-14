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
      bottomNavigationBar: Container(
        height: 54,
        child: TabBar(
          tabs: [
            Tab(
              icon: Icon(Icons.home, size: 20,),
              text: 'aloo',
            ),
            Tab(
              icon: Icon(Icons.android, size: 20,),
              text: '12301230'
            ),
            Tab(
              icon: Icon(Icons.star, size: 20,),
              text: 'asdasdad',
            ),
            Tab(
              icon: Icon(Icons.event, size: 20,),
              text: 'kanflasf',
            ),
          ],
          controller: _tabController,
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.black,
          labelStyle: TextStyle(
            fontSize: 12
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 0
          ),
          indicatorSize: TabBarIndicatorSize.tab,
        ),
      ),
    );
  }
}
