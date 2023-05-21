import 'package:flutter/material.dart';

class SideNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 327,
      height: 812,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 327,
            height: 172,
            color: Colors.transparent,
          ),
          SizedBox(height: 24),
          Container(
            width: 69,
            height: 69,
            margin: EdgeInsets.only(left: 22),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  spreadRadius: 2,
                  blurRadius: 4,
                ),
              ],
            ),
          ),
          SizedBox(height: 9),
          Text(
            'Jeniffer Winget',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontFamily: 'Avenir',
            ),
          ),
          SizedBox(height: 6),
          Text(
            '+91 123412349',
            style: TextStyle(
              fontSize: 12,
              color: Colors.black,
              fontFamily: 'Avenir',
            ),
          ),
          SizedBox(height: 45),
          SideNavItem(
            icon: Icons.home,
            title: 'Home',
          ),
          SideNavItem(
            icon: Icons.notifications,
            title: 'Notifications',
          ),
          SideNavItem(
            icon: Icons.calendar_today,
            title: 'Calendar',
          ),
          SideNavItem(
            icon: Icons.settings,
            title: 'Settings',
          ),
          SideNavItem(
            icon: Icons.help,
            title: 'Help',
          ),
          SideNavItem(
            icon: Icons.logout,
            title: 'Logout',
          ),
          SizedBox(height: 108),
          Text(
            'App Version - V2.00',
            style: TextStyle(
              fontSize: 12,
              color: Colors.black,
              fontFamily: 'Avenir',
            ),
          ),
        ],
      ),
    );
  }
}

class SideNavItem extends StatelessWidget {
  final IconData icon;
  final String title;

  const SideNavItem({
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 327,
      height: 25,
      color: Colors.transparent,
      margin: EdgeInsets.only(left: 22),
      child: Row(
        children: [
          Icon(icon, color: Colors.black),
          SizedBox(width: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.black,
              fontFamily: 'Avenir',
            ),
          ),
        ],
      ),
    );
  }
}
