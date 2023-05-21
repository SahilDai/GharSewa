import 'package:day35/helper/side_nav_bar.dart';
import 'package:flutter/material.dart';

class ProviderHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Default Page'),
      ),
      body: Row(
        children: [
          // SideNavBar(), // Add the SideNavBar widget here
          Expanded(
            child: Center(
              child: Text(
                'This is the default page.',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
