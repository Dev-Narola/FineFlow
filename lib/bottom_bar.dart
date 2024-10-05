// ignore_for_file: depend_on_referenced_packages

import 'package:fineflow0/constant/constant.dart';
import 'package:fineflow0/screens/dashboard/dashboard_page.dart';
import 'package:fineflow0/screens/settings/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    DashboardPage(),
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        height: 60.h,
        decoration: BoxDecoration(
          color: Kwhite,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
          ),
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(LineIcons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(LineIcons.cog),
              label: 'Settings',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Kdark,
          onTap: _onItemTapped,
          unselectedItemColor: Kgray,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
    );
  }
}
