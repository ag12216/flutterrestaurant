import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String title;
  final Function onClick;

  ButtonWidget({@required this.title, @required this.onClick})
      : assert(title != null);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      child: FlatButton(
        color: Colors.deepOrangeAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        splashColor: Colors.white,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(
              title,
              style: TextStyle(
                fontFamily: 'Regular',
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
        onPressed: onClick,
      ),
    );
  }
}
