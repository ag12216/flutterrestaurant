import 'package:flutter/material.dart';
import 'package:restaurant/http/request.dart';
import 'package:restaurant/http/urls.dart';
import 'package:restaurant/res/string.dart';
import 'package:restaurant/res/style.dart';
import 'package:restaurant/screens/dashboard.dart';
import 'package:restaurant/util/common.dart';
import 'package:restaurant/util/routes.dart';
import 'package:restaurant/util/shared_pref_manager.dart';

class OtpScreen extends StatefulWidget {
  final String otp;
  final String userId;
  final String firstname;
  final String lastname;
  final String restaurentname;
  final String countrycode;
  final String mobileno;
  final String email;
  final String logintype;

  OtpScreen(
      {this.otp,
      this.userId,
      this.firstname,
      this.lastname,
      this.restaurentname,
      this.countrycode,
      this.mobileno,
      this.email,
      this.logintype});

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String otp = '';
  String userId = '';
  var txtotp = TextEditingController();

  @override
  void initState() {
    _assignValue();
    super.initState();
  }

  void _assignValue() async {
    txtotp.text = await SharedPrefManager.getString(keyotp);
    otp = txtotp.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(
          'Verify OTP',
          style: styleToolbar.copyWith(color: Colors.black),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            border: Border(top: BorderSide(width: 1, color: Colors.grey[200]))),
        padding: EdgeInsets.all(16),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'PLEASE ENTER OTP',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Regular',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              TextField(
                cursorColor: Colors.deepOrangeAccent[900],
                keyboardType: TextInputType.number,
                maxLength: 4,
                controller: txtotp,
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Regular',
                  color: Colors.black,
                ),
                maxLines: 1,
                decoration: InputDecoration(
                  labelText: 'Enter OTP',
                  labelStyle: TextStyle(
                    color: Colors.deepOrangeAccent,
                    fontFamily: 'Regular',
                    fontSize: 18,
                  ),
                ),
                onChanged: (value) => otp = value,
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                        child: Text(
                          "RESEND OTP",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                        onPressed: () {
                          _varifyLoginorReg();
                        },
                        color: Colors.deepOrangeAccent),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: RaisedButton(
                        child: Text(
                          "VERIFY",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                        onPressed: () {
                          if (otp.isEmpty) {
                            Common.toast(context, 'Otp can not be empty.');
                          } else {
                            _apiOtpVerify();
                          }
                        },
                        color: Colors.deepOrangeAccent),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              GestureDetector(
                child: Center(
                  child: Text(
                    'CHANGE MOBILE NUMBER',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        decoration: TextDecoration.underline),
                  ),
                ),
                onTap: () => Navigator.pop(context),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _varifyLoginorReg() {
    if (widget.logintype == null) {
      _apiGenerateOtp();
    } else {
      _apiOtpGenerationForOwner();
    }
  }

//! Common varify
  void _apiOtpVerify() async {
    if (await Common.isNetworkAvailable()) {
      Future.delayed(Duration.zero, () => Common.dialogLoader(context));
      String tempUserid;
      if (userId == '') {
        tempUserid = widget.userId;
      } else {
        tempUserid = userId;
      }
      otp = await SharedPrefManager.getString(keyotp);

      var data = {
        "Mobile": widget.mobileno,
        "OtpCode": otp,
        "UserId": tempUserid
      };
      Request request = Request(urlOtpVerify, data);
      request.post().then((result) {
        Navigator.pop(context);
        if (result.data['OtpVerificationResult']['Status'] == "0") {
          Common.toast(
              context, result.data['OtpVerificationResult']['Message']);
        } else {
          if (widget.logintype == null) {
            _apiAddOwnerDetails();
          } else {
            _loginApi();
          }
        }
      }).catchError((error) {
        Navigator.pop(context);
        Common.toast(context, wrongMsg);
      });
    }
  }

//! For Registration
  void _apiGenerateOtp() {
    Future.delayed(Duration.zero, () => Common.dialogLoader(context));

    var data = {
      "Mobile": widget.mobileno,
      "FirstName": widget.firstname + ' ' + widget.lastname
    };
    Request request = Request(urlOtpGenerationForOwner, data);
    request.post().then((result) {
      Navigator.pop(context);
      Common.toast(
          context, result.data['OtpGenerationForOwnerResult']['Message']);
      userId = result.data['OtpGenerationForOwnerResult']['tempUserId'];
      // ! remove after sms gateway working
      otp = result.data['OtpGenerationForOwnerResult']['Otp'];

      SharedPrefManager.setString(keyotp, otp.toString());
      _assignValue();
    }).catchError((error) {
      Common.toast(context, wrongMsg);
      Navigator.pop(context);
    });
  }

  void _apiAddOwnerDetails() async {
    if (await Common.isNetworkAvailable()) {
      Future.delayed(Duration.zero, () => Common.dialogLoader(context));
      var data = {
        "FirstName": widget.firstname.trim(),
        "LastName": widget.lastname.trim(),
        "RestName": widget.restaurentname.trim(),
        "CountryCode": widget.countrycode.trim(),
        "MobileNo": widget.mobileno.trim(),
        "EmailId": widget.email.trim(),
        "DeviceId": "123test"
      };
      Request request = Request(urlAddOwnerDetails, data);
      request.post().then((result) {
        Navigator.pop(context);
        if (result.data['AddOwnerDetailsResult']['Status'] == '0') {
          Common.toast(
              context, result.data['AddOwnerDetailsResult']['Message']);
        } else {
          int restid = result.data['AddOwnerDetailsResult']['RestId'];
          SharedPrefManager.setString(keyRestId, restid.toString());
          SharedPrefManager.setBool(keyIsLoggedIn, true);
          Routes.navigateRemoveUntil(context, Dashboard());
        }
      }).catchError((error) {
        Navigator.pop(context);
        Common.toast(context, wrongMsg);
      });
    }
  }

//! For login
  void _apiOtpGenerationForOwner() { 
    var data = {"Mobile": widget.mobileno, "LoginType": widget.logintype};
    Request request = Request(urlOtpGenerationForLogin, data);
    request.post().then((result) {
      Common.toast(
          context, result.data['OtpGenerationForLoginResult']['Message']);

      userId = result.data['OtpGenerationForLoginResult']['tempUserId'];
      // ! remove after sms gateway working
      otp = result.data['OtpGenerationForLoginResult']['Otp'];

      SharedPrefManager.setString(keyotp, otp.toString());
      _assignValue();
    }).catchError((error) {
      Common.toast(context, wrongMsg);
    });
  }

  void _loginApi() async {
    if (await Common.isNetworkAvailable()) {
      Future.delayed(Duration.zero, () => Common.dialogLoader(context));
      var data = {
        "LoginType":"Manager",//widget.logintype.trim()
        "MobileNo": widget.mobileno,
        "DeviceId": "123test"
      };
      Request request = Request(urlAdminAppLogin, data);
      request.post().then((result) {
        Navigator.pop(context);
        if (result.data['AdminAppLoginResult']['Status'] == '1') {
          int restid = result.data['AdminAppLoginResult']['RestId'];
          SharedPrefManager.setString(keyRestId, restid.toString());
          int branchId = result.data['AdminAppLoginResult']['BranchId'];
          SharedPrefManager.setString(keyBranchId, branchId.toString());

          String logintype = result.data['AdminAppLoginResult']['LoginType'];

          SharedPrefManager.setString(keyLoginType, logintype);
          SharedPrefManager.setBool(keyIsLoggedIn, true);

          SharedPrefManager.setString(keyfirstname, result.data['AdminAppLoginResult']['FirstName']);
          SharedPrefManager.setString(keylastname, result.data['AdminAppLoginResult']['LastName']);
          SharedPrefManager.setString(keyBranchName, result.data['AdminAppLoginResult']['BranchName']);
          SharedPrefManager.setString(keyProfileImage, result.data['AdminAppLoginResult']['ProfileImage']);
          SharedPrefManager.setString(keyRestName, result.data['AdminAppLoginResult']['RestName']);



          Routes.navigateRemoveUntil(context, Dashboard());
        } else {
          Common.toast(context, result.data['AdminAppLoginResult']['Message']);
        }
      }).catchError((error) {
        Navigator.pop(context);

        Common.toast(context, wrongMsg);
      });
    } else {
      Navigator.pop(context);

      Common.toast(context, noInternetMsg);
    }
  }
}
