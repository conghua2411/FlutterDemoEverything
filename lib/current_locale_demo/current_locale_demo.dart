import 'dart:async';

import 'package:flutter/material.dart';

class CurrentLocaleDemo extends StatefulWidget {

  @override
  State createState() => CurrentLocaleState();
}

class CurrentLocaleState extends State<CurrentLocaleDemo> {

  Locale myLocale;

  StreamController<String> localeStream;

  @override
  void initState() {
    super.initState();

    localeStream = StreamController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    myLocale = Localizations.localeOf(context);

    localeStream.add('CountryCode - ${myLocale.countryCode}\n'
        'languageCode - ${myLocale.languageCode}\n'
        'scriptCode - ${myLocale.scriptCode}\n'
        'toLanguageTag - ${myLocale.toLanguageTag()}');
  }

  @override
  void dispose() {
    localeStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CurrentLocaleDemo'),
      ),
      body: Center(
        child: StreamBuilder<String>(
          initialData: '',
          stream: localeStream.stream,
          builder: (context, snapshot) {
            return Text(snapshot.data);
          }
        ),
      ),
    );
  }
}