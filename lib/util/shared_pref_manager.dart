import 'package:shared_preferences/shared_preferences.dart';

const String keyonlyfirsttimelaunch='onlyfirsttimelaunch';
const String keyIsLoggedIn = 'isLogin';
const String keyUserId = 'userId';
const String keyRestId = 'RestId';
const String keyfirstname= 'firstname';
const String keylastname= 'lastname';
const String keyBranchName= 'branchnm';
const String keyProfileImage= 'profileimage';
const String keyRestName= 'restname';

const String keyrestaurentname= 'restaurentname';
const String keycountrycode= 'countrycode';
const String keymobileno='mobileno';
const String keyemail='email';
const String keyBranchId = 'BranchId';
const String keyLoginType = 'LoginType';

const String keyotp = 'otp';

//? page 1 values
const String keybranchname = 'branchname';
const String keyaddress1 = 'address1';
const String keyaddress2 = 'address2';
const String keyfirstnm = 'firstnm';
const String keylastnm = 'lastnm';
const String keyemailaddress= 'emailaddress';
const String keylandlinenumber= 'landlinenumber';
const String keymobnumber= 'mobnumber';
const String keyassignuser= 'assignuser';
const String keyisstatuspage1= 'isstatuspage1';
//? page3
const String keytitlename= 'titlename';
//? page4
const String keynooftables= 'nooftables';
const String keyminposition= 'minposition';
const String keymaxposition= 'maxposition';
const String keyesttime= 'esttime';
const String keystatuspage4= 'statuspage4';




class SharedPrefManager {
  static Future<bool> getBool(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }

  static Future<bool> setBool(String key, bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(key, value);
  }

  static Future<String> getString(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? '';
  }

  static Future<bool> setString(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }




}

