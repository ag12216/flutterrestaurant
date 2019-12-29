import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant/screens/splash_screen.dart';


void main() async {
  
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.deepOrangeAccent,
    statusBarBrightness: Brightness.light
  ));
  runApp(MaterialApp(
    theme: new ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
  ));
}
