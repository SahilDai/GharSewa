import 'package:flutter/material.dart';

class ProviderHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Default Page'),
      ),
      body: Center(
        child: Text(
          'This is the default page.',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
