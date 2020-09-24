import 'package:flutter/material.dart';
import 'package:flutter_app/animation/flare/mail_open/mail_open.dart';
import 'package:flutter_app/animation/flare/smile_splash/smile_splash.dart';

class ListFlareView extends StatefulWidget {
  @override
  _ListFlareViewState createState() => _ListFlareViewState();
}

class _ListFlareViewState extends State<ListFlareView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Flare Demo'),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            _buildItemFlare(
              title: 'SMILE SPLASH',
              onClick: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => SmileSplash(),
                  ),
                );
              },
            ),
            _buildItemFlare(
              title: 'MAIL OPEN',
              onClick: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => MailOpen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemFlare({
    String title,
    Color color = Colors.amber,
    Function onClick,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: color,
            width: 2,
          ),
        ),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: onClick,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  '$title',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
