import 'package:flutter/material.dart';

class LanguageDemo extends StatefulWidget {
  @override
  State createState() => LanguageDemoState();
}

class LanguageDemoState extends State<LanguageDemo> {

  Locale currentLocale;

  String timeZone;

  @override
  void initState() {
    super.initState();

    timeZone = DateTime.now().timeZoneName;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    currentLocale = Localizations.localeOf(context);
    print('asdasdasdas');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Language Demo'),
      ),
      body: Center(
        child: Text('language : ${currentLocale.languageCode}, timeZone: $timeZone'),
      ),
    );
  }
}
