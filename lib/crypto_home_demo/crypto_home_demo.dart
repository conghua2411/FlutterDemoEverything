import 'package:flutter/material.dart';

class CryptoHomeDemo extends StatefulWidget {
  @override
  State createState() => CryptoHomeState();
}

class CryptoHomeState extends State<CryptoHomeDemo> {
  PageController _sliderCardController;

  @override
  void initState() {
    super.initState();
    _sliderCardController = PageController(viewportFraction: 0.8);
  }

  @override
  void dispose() {
    _sliderCardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFffff00),
        height: double.infinity,
        child: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                _buildHeader(),
                _buildSliderCard(),
                _buildEvent(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildHeader() {
    return Container(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 22, bottom: 22),
        child: Column(
          children: <Widget>[
            _buildTextHeader(),
            SizedBox(
              height: 24,
            ),
            _buildBadgeIssuedAndHolder(),
          ],
        ),
      ),
    );
  }

  _buildTextHeader() {
    return Row(
      children: <Widget>[
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: NetworkImage(
                  'https://crypto-badge-static-m1.s3.ap-southeast-1.amazonaws.com/protected/ap-southeast-1%3A31a7fecb-a07e-4ce3-90da-6931779e72a4/image_picker3995441942507456145.jpg'),
              fit: BoxFit.fill,
            ),
          ),
        ),
        SizedBox(
          width: 16,
        ),
        Expanded(
          child: Text(
            'You are the 909th citizen of the CryptoBadge Network',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              height: 1.44,
              letterSpacing: 0.39,
              color: Color(0xFF001563),
            ),
          ),
        ),
      ],
    );
  }

  _buildBadgeIssuedAndHolder() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            color: Color.fromRGBO(0, 0, 0, 0.1),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 18, right: 18, top: 10, bottom: 10),
              child: Column(
                children: <Widget>[
                  Text(
                    '3,817',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0086ff),
                    ),
                  ),
                  Text(
                    'Badges issued',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF545454),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          width: 16,
        ),
        Expanded(
          child: Container(
            color: Color.fromRGBO(0, 0, 0, 0.1),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 18, right: 18, top: 10, bottom: 10),
              child: Column(
                children: <Widget>[
                  Text(
                    '3,817',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0086ff),
                    ),
                  ),
                  Text(
                    'Badges issued',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF545454),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  _buildSliderCard() {
    return Stack(
      children: <Widget>[
        _buildBackgroundSliderCard(),
        _buildLayoutLayerCard(),
      ],
    );
  }

  _buildBackgroundSliderCard() {
    return Container(
      height: 260,
      child: Column(
        children: <Widget>[
          Flexible(
            child: Container(
              color: Color(0xFFffff00),
            ),
            flex: 1,
          ),
          Flexible(
            child: Container(
              color: Colors.white,
            ),
            flex: 3,
          ),
        ],
      ),
    );
  }

  _buildLayoutLayerCard() {
    return Container(
      height: 260,
      child: Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 12),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Activity',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF001563),
                  ),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(
                        left: 0, right: 16, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[(index + 1) * 100],
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.1),
                          blurRadius: 5,
                          offset: Offset(10, 10),
                        ),
                      ],
                    ),
                  );
                },
                itemCount: 4,
                controller: _sliderCardController,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildEvent() {
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            'EVENT',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Color(0xFF001563),
            ),
          ),
          Container(
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://crypto-badge-static-m1.s3.ap-southeast-1.amazonaws.com/protected/ap-southeast-1%3A31a7fecb-a07e-4ce3-90da-6931779e72a4/image_picker3995441942507456145.jpg'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: Colors.red,
          ),
          title: Container(),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.play_arrow,
            color: Colors.red,
          ),
          title: Container(),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.pause,
            color: Colors.red,
          ),
          title: Container(),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.settings,
            color: Colors.red,
          ),
          title: Container(),
        ),
      ],
    );
  }
}
