import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:restaurant/screens/dashboard.dart';
import 'package:restaurant/screens/login1.dart';
import 'package:restaurant/util/routes.dart';
import 'package:toast/toast.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController password = new TextEditingController();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(40),
            child: Center(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    autofocus: false,
                    controller: password,
                    textCapitalization: TextCapitalization.sentences,
                    obscureText: _obscureText,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        labelText: "Password",
                        hintText: "Password",
                        suffixIcon: new GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                          child: new Icon(_obscureText
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                        hintStyle: TextStyle(
                          fontSize: 13.0,
                        ),
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide: BorderSide(
                                width: 1,
                                color: Colors.white,
                                style: BorderStyle.solid))),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: RaisedButton(
                        child: Text(
                          "Submit",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                        onPressed: () {
                          //  Navigator.of(context).pushAndRemoveUntil(
                          // MaterialPageRoute(builder: (BuildContext context) => Dashboard()),
                          // (Route<dynamic> route) => false);Sea1#appa
                          
                          if (password.text == "") {
                            Routes.navigateRemoveUntil(context, Loginmain());
                          } else {
                            Toast.show('Please enter valid password', context,
                                duration: Toast.LENGTH_LONG,
                                gravity: Toast.BOTTOM);
                          }
                        },
                        color: Colors.deepOrangeAccent),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
