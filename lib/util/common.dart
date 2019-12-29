import 'dart:io';
import 'package:flutter/material.dart';
import 'package:restaurant/library/loader/double_bounce.dart';

import 'package:toast/toast.dart';

class Common {
  static Future<bool> isNetworkAvailable() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }

  static void toast(BuildContext context, String msg) {
    Toast.show(msg, context,
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
  }

  static void dialogLoader(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        contentPadding: EdgeInsets.only(top: 10.0),
        content: Container(
          width: 40,
          height: 120,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SpinKitDoubleBounce(
                color: Colors.deepOrangeAccent,
                size: 40,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Please wait...',
                style: TextStyle(
                  color: Colors.deepOrangeAccent,
                  fontFamily: 'Regular',
                  fontSize: 18,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }



}
