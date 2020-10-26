import 'package:flutter/material.dart';
import 'package:flutter_app/provider/demos/consumer_demo.dart';
import 'package:flutter_app/provider/demos/future_provider_demo.dart';
import 'package:flutter_app/provider/demos/selector_demo.dart';
import 'package:flutter_app/provider/demos/stream_provider_demo.dart';

class ProviderDemo extends StatefulWidget {
  @override
  _ProviderDemoState createState() => _ProviderDemoState();
}

class _ProviderDemoState extends State<ProviderDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Provider Screen'),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            _buildProviderItem(
              text: 'FutureProvider',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => FutureProviderDemo(),
                  ),
                );
              },
            ),
            _buildProviderItem(
              text: 'ConsumerDemo',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ConsumerDemo(),
                  ),
                );
              },
            ),
            _buildProviderItem(
              text: 'SelectorDemo',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => SelectorDemo(),
                  ),
                );
              },
            ),
            _buildProviderItem(
              text: 'StreamProviderDemo',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => StreamProviderDemo(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProviderItem({
    String text,
    VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 24,
        right: 24,
        top: 8,
      ),
      child: FlatButton(
        color: Colors.blue,
        textColor: Colors.white,
        child: Text('$text'),
        onPressed: onTap,
      ),
    );
  }
}
