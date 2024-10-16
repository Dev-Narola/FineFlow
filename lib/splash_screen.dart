import 'dart:async';

import 'package:fineflow0/bottom_bar.dart';
import 'package:fineflow0/constant/constant.dart';
import 'package:fineflow0/screens/authentication/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkIfUserIsLoggedIn();
    Timer(Duration(seconds: 5), _checkIfUserIsLoggedIn);
  }

  void _checkIfUserIsLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null && token.isNotEmpty) {
      Get.off(() => BottomBar());
    } else {
      Get.off(() => SigninScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Koffwhite,
      body: Center(
          child: Image.network(
        'https://play-lh.googleusercontent.com/NRFa0ykurSkdcQHcikVgkhL-MOJccFmXEnvV3KdwErdNAwE08ZihKZZpGtkCQdO6ud5J',
        fit: BoxFit.cover,
        // width: double.infinity,
        // height: double.infinity,
      )),
    );
  }
}
