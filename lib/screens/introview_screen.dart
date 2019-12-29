import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:restaurant/screens/login.dart';
import 'package:restaurant/screens/login1.dart';

class Introview extends StatelessWidget {
  
 //making list of pages needed to pass in IntroViewsFlutter constructor.
  final pages = [
    PageViewModel(
        pageColor: const Color(0xFF03A9F4),
        // iconImageAssetPath: 'assets/air-hostess.png',
      
        bubble: Icon(Icons.change_history,size: 13,),
        body: Text(
          'Description 1',
        ),
        title: Text(
          'Title 1',
        ),
        titleTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
        bodyTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
        mainImage: Image.asset(
          'assets/splash_logo.jpg',
          height: 285.0,
          width: 285.0,
          alignment: Alignment.center,
        )),
    PageViewModel(
      pageColor: const Color(0xFF8BC34A),
      bubble: Icon(Icons.change_history,size: 13,),
      body: Text(
          'Description 2',
        ),
        title: Text(
          'Title 2',
        ),
      mainImage: Image.asset(
        'assets/splash_logo.jpg',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      ),
      titleTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
      bodyTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
    ),
    PageViewModel(
      pageColor: const Color(0xFF607D8B),
     bubble: Icon(Icons.change_history,size: 13,),
    body: Text(
          'Description 3',
        ),
        title: Text(
          'Title 3',
        ),
      mainImage: Image.asset(
        'assets/splash_logo.jpg',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      ),
      titleTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
      bodyTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroViewsFlutter(
          pages,
          showNextButton: true,
          showBackButton: true,
          onTapDoneButton: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Loginmain(),
              ), //MaterialPageRoute
            );
          },
          pageButtonTextStyles: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ), //IntroViewsFlutter
    
    ); 
  }
}

