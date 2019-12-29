import 'package:flutter/cupertino.dart';
import 'package:page_transition/page_transition.dart';

class Routes {
  static void navigate(BuildContext context, Widget child) => Navigator.push(
      context,
      PageTransition(type: PageTransitionType.rightToLeft, child: child));

  static void navigateReplacement(BuildContext context, Widget child) =>
      Navigator.pushReplacement(context,
          PageTransition(type: PageTransitionType.rightToLeft, child: child));

  static void navigateRemoveUntil(BuildContext context, Widget child) =>
      Navigator.pushAndRemoveUntil(
          context,
          PageTransition(type: PageTransitionType.rightToLeft, child: child),
          (Route<dynamic> route) => false);
}
