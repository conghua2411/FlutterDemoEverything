import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class MailOpen extends StatefulWidget {
  @override
  _MailOpenState createState() => _MailOpenState();
}

class _MailOpenState extends State<MailOpen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FlareActor(
          'assets/flare/mail_open.flr',
          fit: BoxFit.none,
          animation: 'Mail opening',
        ),
      ),
    );
  }
}
