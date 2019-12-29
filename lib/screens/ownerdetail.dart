import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:restaurant/http/request.dart';
import 'package:restaurant/http/urls.dart';
import 'package:restaurant/res/string.dart';
import 'package:restaurant/screens/login.dart';
import 'package:restaurant/screens/login1.dart';
import 'package:restaurant/screens/otp_screen.dart';
import 'package:restaurant/screens/webview_screen.dart';
import 'package:restaurant/util/common.dart';
import 'package:restaurant/util/routes.dart';
import 'package:restaurant/util/shared_pref_manager.dart';

class Ownerdetails extends StatefulWidget {
  @override
  _OwnerdetailsState createState() => _OwnerdetailsState();
}

class _OwnerdetailsState extends State<Ownerdetails> {
  String _firstname = '';
  String _lastname = '';
  String _restaurentname = '';
  String _countrycode = '';
  String _mobileno = '';
  String _email = '';
  bool checkboxChecked = false;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => Login()),
            (Route<dynamic> route) => false),
            
        child: Scaffold(
          appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: new Text(
          'REGISTRATION',
          style: TextStyle(fontSize: 17),
        ),
        backgroundColor: Colors.deepOrangeAccent,
      ),
          backgroundColor: Colors.white,
          body: Center(
            child: SafeArea(
              child:    SingleChildScrollView(
                child: Form(
              key: _formKey,
              child: Container(
                  padding: EdgeInsets.all(40),
                  child: Center(
                    child: Column(
                      children: <Widget>[
                       
                        TextFormField(
                          autofocus: false,
                          obscureText: false,
                          textCapitalization: TextCapitalization.sentences,
                          keyboardType: TextInputType.text,
                          onChanged: (value) => _firstname = value,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Full name required';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: "FIRST NAME",
                              hintStyle: TextStyle(fontSize: 13.0),
                              contentPadding:
                                  EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                              labelStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: Colors.white,
                                      style: BorderStyle.solid))),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        TextFormField(
                          autofocus: false,
                          obscureText: false,
                          textCapitalization: TextCapitalization.sentences,
                          keyboardType: TextInputType.text,
                          onChanged: (value) => _lastname = value,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Last name required';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: "LAST NAME",
                              hintStyle: TextStyle(fontSize: 13.0),
                              contentPadding:
                                  EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                              labelStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: Colors.white,
                                      style: BorderStyle.solid))),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        TextFormField(
                          autofocus: false,
                          obscureText: false,
                          textCapitalization: TextCapitalization.sentences,
                          keyboardType: TextInputType.text,
                          onChanged: (value) => _restaurentname = value,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Restaurent name required';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: "RESTAURANT NAME",
                              hintStyle: TextStyle(fontSize: 13.0),
                              contentPadding:
                                  EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                              labelStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: Colors.white,
                                      style: BorderStyle.solid))),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        TextFormField(
                          textCapitalization: TextCapitalization.sentences,
                          autofocus: false,
                          obscureText: false,
                          keyboardType: TextInputType.text,
                          onChanged: (value) => _countrycode = value,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Country code required';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: "COUNTRY CODE",
                              hintStyle: TextStyle(fontSize: 13.0),
                              contentPadding:
                                  EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                              labelStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: Colors.white,
                                      style: BorderStyle.solid))),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        TextFormField(
                          autofocus: false,
                          obscureText: false,
                          keyboardType: TextInputType.phone,
                          maxLength: 10,
                          onChanged: (value) => _mobileno = value,
                          validator: (value) {
                            if (_mobileno.trim().length < 10) {
                              return 'Enter valid mobile number.';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: "MOBILE NO",
                              hintStyle: TextStyle(fontSize: 13.0),
                              contentPadding:
                                  EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                              labelStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: Colors.white,
                                      style: BorderStyle.solid))),
                        ),
                        SizedBox(
                          height: 13,
                        ),
                        TextFormField(
                          autofocus: false,
                          obscureText: false,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) => _email = value,
                          validator: (value) {
                            if (value.isEmpty ||
                                !RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value)) {
                              return 'Enter valid email address.';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: "EMAIL ID",
                              hintStyle: TextStyle(fontSize: 13.0),
                              contentPadding:
                                  EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                              labelStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: Colors.white,
                                      style: BorderStyle.solid))),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Checkbox(
                              value: checkboxChecked,
                              onChanged: (bool value) =>
                                  setState(() => checkboxChecked = value),
                            ),
                            RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                  text: 'I agree to the ',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Regular',
                                    fontSize: 13,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Terms & Conditions',
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Routes.navigate(
                                          context,
                                          WebviewScreen(
                                            title: 'Terms & Conditions',
                                            url: 'https://www.google.co.in',
                                          ));
                                    },
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 13,
                                    decoration: TextDecoration.underline,
                                  ),
                                )
                              ]),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: RaisedButton(
                              child: Text(
                                "SUBMIT",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                ),
                              ),
                              onPressed: () {
                                // Navigator.of(context).pushAndRemoveUntil(
                                //     MaterialPageRoute(
                                //         builder: (BuildContext context) =>
                                //             Dashboard()),
                                //     (Route<dynamic> route) => false); //Sea1#appa

                                //ownerregister(mobilenumber.text, password.text);

                                if (_formKey.currentState.validate()) {
                                  if (checkboxChecked) {
                                 
                                    _apiGenerateOtp();

                                  } else {
                                    Common.toast(
                                        context, 'Agree to Terms & Conditions');
                                  }
                                }
                              },
                              color: Colors.deepOrangeAccent),
                        ),
                      
                        SizedBox(
                          height: 15,
                        ),
                        InkWell(
                          child: Text(
                            'Back to Login ?',
                            style: TextStyle(color: Colors.deepOrangeAccent),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Loginmain()),
                            );
                          },
                        ),
                      ],
                    ),
                  )),
            )),
        
            ),
           ),
        ));
  }

  void _apiCheckStatus() async {
    if (await Common.isNetworkAvailable()) {
      Future.delayed(Duration.zero, () => Common.dialogLoader(context));
      var data = {
        'MobileNo': _mobileno.trim(),
      };
      Request request = Request(urlCheckStatus, data);
      request.post().then((result) {
        if (result.data['CheckUserStatusResult']['Status'] == '1') {
          Navigator.pop(context);
          Common.toast(context, 'Account already exits, please login.');
          Navigator.pop(context);
        } else {
          //Common.toast(result.data['CheckUserStatusResult']['Message']);
          _apiGenerateOtp();
        }
      }).catchError((error) {
        Navigator.pop(context);

        Common.toast(context, wrongMsg);
      });
    } else {
      Common.toast(context, noInternetMsg);
    }
  }

  void _apiGenerateOtp() {
    var data = {
      "Mobile": _mobileno.trim(),
      "FirstName": _firstname + ' ' + _lastname.trim()
    };
    Request request = Request(urlOtpGenerationForOwner, data);
    request.post().then((result) {
      if (result.data['OtpGenerationForOwnerResult']['Status'] == '0') {
        Common.toast(context, result.data['OtpGenerationForOwnerResult']['Message']);
      } else {
        _navigateToVerifyOtp(result.data['OtpGenerationForOwnerResult']['tempUserId'],
            result.data['OtpGenerationForOwnerResult']['Otp']);
            SharedPrefManager.setString(keyotp,   result.data['OtpGenerationForOwnerResult']['Otp'].toString());
      }
    }).catchError((error) {
      Common.toast(context, wrongMsg);
      Navigator.pop(context);
    });
  }

  void _navigateToVerifyOtp(String userId, String otp) {
    Routes.navigate(
        context,
        OtpScreen(
          otp: otp,
          userId: userId,
          firstname: _firstname,
          lastname: _lastname,
          restaurentname: _restaurentname,
          countrycode: _countrycode,
          mobileno: _mobileno,
          email: _email,
        ));
  }
}
