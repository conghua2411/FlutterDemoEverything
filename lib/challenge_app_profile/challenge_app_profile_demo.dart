import 'package:flutter/material.dart';

import 'challenge_gallery.dart';

const String imageUrl =
    'https://cdna.artstation.com/p/assets/images/images/021/207/158/large/alexandre-ferra-visualhelmet-02-by-alexandre-ferra.jpg?1570782671';

class ChallengeAppProfileDemo extends StatefulWidget {
  @override
  State createState() => ChallengeAppProfileState();
}

class ChallengeAppProfileState extends State<ChallengeAppProfileDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text('ChallengeAppProfileDemo'),
      ),
      body: _buildProfile(),
    );
  }

  _buildProfile() {
    double profileHeight = 300;
    double imageHeight = 100;

    return Container(
      height: profileHeight,
      width: double.infinity,
      color: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                height: profileHeight * 2 / 5,
                color: Colors.blue,
              ),
              Container(
                height: profileHeight * 3 / 5,
                color: Colors.white,
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Container(
                height: imageHeight / 2,
                width: double.infinity,
                color: Colors.transparent,
              ),
              // user data
              Container(
                height: profileHeight - imageHeight / 2,
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.2),
                            offset: Offset(0, 2),
                            spreadRadius: 2,
                          )
                        ]),
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment(0, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                InkWell(
                  onTap: _openGallery,
                  child: Container(
                    height: 100,
                    width: 100,
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        image: DecorationImage(
                            image: NetworkImage(imageUrl), fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ),
                Text('Username'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.phone,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Text(
                      '0123456789',
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.person_pin,
                      ),
                      Expanded(
                        child: Text(
                          'asdasd asd asd asd asd sad asda asd asd asd asd asd asd qwd qwd',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.2),
                              offset: Offset(0, 2),
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Icon(
                            Icons.edit,
                            size: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Text('Exp'),
                            SizedBox(
                              height: 4,
                            ),
                            Text('0.345'),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Text('Reputation'),
                            SizedBox(
                              height: 4,
                            ),
                            Icon(Icons.cancel),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Text('Win'),
                            SizedBox(
                              height: 4,
                            ),
                            Text('120 challenge'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: InkWell(
                    onTap: () {
                      print('asd asd asd asd asd as asd');
                    },
                    child: Container(
                      width: 200,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: Text(
                          'CREATE CHALLENGE',
                          style: TextStyle(),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _openGallery() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => ChallengeGallery()));
  }
}
