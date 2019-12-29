import 'package:flutter/material.dart';
import 'package:restaurant/screens/dashboard.dart';
import 'package:restaurant/screens/introview_screen.dart';
import 'package:restaurant/screens/login.dart';
import 'package:restaurant/screens/login1.dart';
import 'package:restaurant/util/routes.dart';
import 'dart:async';

import 'package:restaurant/util/shared_pref_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _navigate();

    super.initState();
  }

  void _navigate() {
    Future.delayed(Duration(seconds: 2), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool _seen = (prefs.getBool('seen') ?? false);

      if (_seen) {
        if (await SharedPrefManager.getBool(keyIsLoggedIn)) {
          Routes.navigateReplacement(context, Dashboard());
        } else {
          Routes.navigateReplacement(context, Loginmain());
        }
      } else {
        prefs.setBool('seen', true); // ? true when fix introview
        Routes.navigateReplacement(context, Introview());
      }
    });
  }

  // Future<dynamic> _backgroundMessageHandler(
  //     Map<String, dynamic> message) async {
  //   return Future<void>.value();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/splash_logo.jpg',
          width: 140,
        ),
      ),
    );
  }
}
