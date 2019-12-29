import 'package:flutter/material.dart';
import 'package:restaurant/http/request.dart';
import 'package:restaurant/http/urls.dart';
import 'package:restaurant/res/string.dart';
import 'package:restaurant/screens/otp_screen.dart';
import 'package:restaurant/screens/ownerdetail.dart';
import 'package:restaurant/util/common.dart';
import 'package:restaurant/util/routes.dart';
import 'package:restaurant/util/shared_pref_manager.dart';

class Loginmain extends StatefulWidget {
  @override
  _LoginmainState createState() => _LoginmainState();
}

class _LoginmainState extends State<Loginmain> {
  String _mobileno = '';
  int _radioValue1 = -1;
  int correctScore = 0;
  String _loginType = 'Owner';
  @override
  void initState() {
    setState(() {
      _radioValue1 = 0;
    });
    super.initState();
  }

  void _handleRadioValueChange1(int value) {
    setState(() {
      _radioValue1 = value;

      switch (_radioValue1) {
        case 0:
          Common.toast(context, 'Owner');
          _loginType = "Owner";
          correctScore++;
          break;
        case 1:
          Common.toast(context, 'Manager');
          _loginType = "Manager";

          break;
      }
    });
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: new Text(
          'LOGIN',
          style: TextStyle(fontSize: 17),
        ),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Center(
        child: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(40),
                  child: Column(
                    children: <Widget>[
                      // new Row(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: <Widget>[
                      //       new Radio(
                      //         activeColor: Colors.deepOrangeAccent,
                      //         value: 0,
                      //         groupValue: _radioValue1,
                      //         onChanged: _handleRadioValueChange1,
                      //       ),
                      //       new Text(
                      //         'Owner',
                      //         style: new TextStyle(fontSize: 16.0),
                      //       ),
                      //       SizedBox(
                      //         width: 25,
                      //       ),
                      //       new Radio(
                      //         activeColor: Colors.deepOrangeAccent,
                      //         value: 1,
                      //         groupValue: _radioValue1,
                      //         onChanged: _handleRadioValueChange1,
                      //       ),
                      //       new Text(
                      //         'Manager',
                      //         style: new TextStyle(
                      //           fontSize: 16.0,
                      //         ),
                      //       ),
                      //     ]),
                      // SizedBox(
                      //   height: 25,
                      // ),
                      TextFormField(
                        autofocus: false,
                        obscureText: false,
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        onChanged: (value) => _mobileno = value,
                        validator: (value) {
                          if (value.trim().length < 10) {
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
                        height: 25,
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
                              if (_formKey.currentState.validate()) {
                                _apiGenerateOtp();
                                // Routes.navigateRemoveUntil(
                                //     context, Dashboard());
                              }
                            },
                            color: Colors.deepOrangeAccent),
                      ),
                   
                      // SizedBox(
                      //   height: 15,
                      // ),
                      // InkWell(
                      //   child: Text(
                      //     'Don\'t have a account? Register',
                      //     textAlign: TextAlign.center,
                      //     overflow: TextOverflow.ellipsis,
                      //     style: TextStyle(color: Colors.deepOrangeAccent),
                      //   ),
                      //   onTap: () {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) => Ownerdetails()),
                      //     );
                      //   },
                      // ),
                 
                   ],
                  ),
                ))),
      ),
    );
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
      "LoginType": "Manager"//_loginType.trim(),
    };
    Request request = Request(urlOtpGenerationForLogin, data);
    request.post().then((result) {
      if (result.data['OtpGenerationForLoginResult']['Status'] == '0') {
        Common.toast(
            context, result.data['OtpGenerationForLoginResult']['Message']);
      } else {
        _navigateToVerifyOtp(
            result.data['OtpGenerationForLoginResult']['tempUserId'],
            result.data['OtpGenerationForLoginResult']['Otp']);
            SharedPrefManager.setString(keyotp, result.data['OtpGenerationForLoginResult']['Otp'].toString());

      }
    }).catchError((error) {
      Common.toast(context, wrongMsg);
      Navigator.pop(context);
    });
  }

  void _navigateToVerifyOtp(String userId, String otp) {
    print(userId + otp);
    Routes.navigate(
        context,
        OtpScreen(
          otp: otp,
          userId: userId,
          firstname: '',
          lastname: '',
          restaurentname: '',
          countrycode: '',
          mobileno: _mobileno,
          email: '',
          logintype: _loginType,
        ));
  }
}
