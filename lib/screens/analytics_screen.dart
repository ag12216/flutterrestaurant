import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:restaurant/data/drawer/drawer_data.dart';
import 'package:restaurant/http/request.dart';
import 'package:restaurant/http/urls.dart';
import 'package:restaurant/res/color.dart';
import 'package:restaurant/res/string.dart';
import 'package:restaurant/screens/dashboard.dart';
import 'package:restaurant/screens/login1.dart';
import 'package:restaurant/screens/manager_history.dart';
import 'package:restaurant/screens/page1.dart';
import 'package:restaurant/util/common.dart';
import 'package:restaurant/util/routes.dart';
import 'package:restaurant/util/shared_pref_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Analytics extends StatefulWidget {
  @override
  _AnalyticsState createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {
  Future<bool> backPress() {
    Routes.navigateRemoveUntil(context, Dashboard());

    return Future.value(false);
  }

  String _beginDate, _endDate;
  String _totalnoofbooking = "";
  String _totalrevenue = "";
  String _totalcommision = "";
  String _begindt = "";
  String _enddt = "";
  String _fullname = "";
  String _branchname = "";

  @override
  void initState() {
    _assignValue();
    _apiAnalyticsScreen();
    super.initState();
  }

  void _assignValue() async {
    _fullname = await SharedPrefManager.getString(keyfirstname) +
        " " +
        await SharedPrefManager.getString(keylastname);
    _branchname = await SharedPrefManager.getString(keyBranchName);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: backPress,
        child: Scaffold(
            drawer: SafeArea(
                child: Drawer(
                    child: ListView(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    color: Colors.deepOrangeAccent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: Image(
                            image: AssetImage(
                              'assets/nvuser.png',
                            ),
                            color: Colors.white,
                            width: 35,
                            height: 35,
                          ),
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              _fullname,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              _branchname,
                              style:
                                  TextStyle(fontSize: 13, color: Colors.white),
                            )
                          ],
                        )
                      ],
                    )),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                  itemCount: DrawerData.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Row(
                          children: <Widget>[
                            // Image.asset(
                            //   DrawerData.data[index].imagePath,
                            //   width: 30,
                            // ),
                            // SizedBox(
                            //   width: 16,
                            // ),
                            Text(
                              DrawerData.data[index].title,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () =>
                          _drawerNavigation(DrawerData.data[index].title),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(),
                ),
              ],
            ))),
            backgroundColor: Colors.grey[200],
            appBar: AppBar(
              centerTitle: true,
              elevation: 0,
              title: new Text(
                'ANALYTICS',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17),
              ),
              actions: <Widget>[
                new IconButton(
                  icon: new Icon(Icons.date_range),
                  tooltip: 'Time filter',
                  onPressed: () {
                    showPickerDateRange(context);
                  },
                ),
              ],
              backgroundColor: Colors.deepOrangeAccent,
              leading: Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    tooltip:
                        MaterialLocalizations.of(context).openAppDrawerTooltip,
                  );
                },
              ),
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
              color: Colors.grey[200],
              width: MediaQuery.of(context).size.width,
              child: ListView(
                shrinkWrap: false,
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text('Begin ',
                                style: TextStyle(color: Colors.black,  fontWeight: FontWeight.bold,)),
                            SizedBox(
                              height: 9,
                            ),
                            Text(
                              ': ' + _begindt,
                              style: TextStyle(color: Colors.black,  fontWeight: FontWeight.bold,),
                            ),
                          ],
                        ),
                        Row(children: <Widget>[
                          Text('End ', style: TextStyle(color: Colors.black,  fontWeight: FontWeight.bold,)),
                          SizedBox(
                            height: 9,
                          ),
                          Text(
                            ': ' + _enddt,
                            style: TextStyle(color: Colors.black,  fontWeight: FontWeight.bold,),
                          )
                        ])
                      ],
                    ),
                  ),
                  Container(
                    height: 450,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              child: Text(
                                "TOTAL NO OF BOOKINGS",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 2, 0, 15),
                              child: Text(
                                _totalnoofbooking,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              child: Text(
                                "TOTAL REVENUE",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 2, 0, 15),
                              child: Text(
                                _totalrevenue,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              child: Text(
                                "TOTAL COMMISION",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 2, 0, 15),
                              child: Text(
                                _totalcommision,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )));
  }

  void _drawerNavigation(String title) {
    Navigator.pop(context);
    switch (title.toLowerCase()) {
      case 'overview':
        Routes.navigate(context, Dashboard());
        break;
      case 'add restaurant':
        Routes.navigate(context, Page1());
        break;
      case 'booking history':
        Routes.navigate(context, ManagerHistory());
        break;

      case 'sign out':
        _signOutDialog();
        break;
    }
  }

  void _signOutDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        titlePadding: EdgeInsets.all(0),
        title: Container(
          color: colorWhite,
          height: 150,
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Sign Out',
                style: TextStyle(
                  fontSize: 20,
                  color: colorBlack,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 40),
                child: Text(
                  'Are you sure want to exit?',
                  style: TextStyle(
                    fontSize: 18,
                    color: colorBlack,
                  ),
                ),
              ),
              Expanded(child: SizedBox()),
              Row(
                children: <Widget>[
                  GestureDetector(
                    child: Text(
                      'NO,STAY IN!',
                      style: TextStyle(
                        fontSize: 14,
                        color: colorPrimary,
                      ),
                    ),
                    onTap: () => Navigator.pop(context),
                  ),
                  Expanded(
                    child: SizedBox(),
                  ),
                  GestureDetector(
                    child: Text('YES,SIGN OUT!',
                        style: TextStyle(
                          fontSize: 14,
                          color: colorPrimary,
                        )),
                    onTap: () async {
                      Navigator.pop(context);
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      preferences.clear();
                      Routes.navigateRemoveUntil(context, Loginmain());
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  showPickerDateRange(BuildContext context) {
    print("canceltext: ${PickerLocalizations.of(context).cancelText}");

    Picker ps = new Picker(
        hideHeader: true,
        adapter: new DateTimePickerAdapter(type: PickerDateTimeType.kYMD),
        onConfirm: (Picker picker, List value) {
          var date = DateTime.parse(
              (picker.adapter as DateTimePickerAdapter).value.toString());
          var formattedDate = "${date.day}-${date.month}-${date.year}";
          _beginDate = formattedDate;
          print(_beginDate);
        });

    Picker pe = new Picker(
        hideHeader: true,
        adapter: new DateTimePickerAdapter(type: PickerDateTimeType.kYMD),
        onConfirm: (Picker picker, List value) {
          var date = DateTime.parse(
              (picker.adapter as DateTimePickerAdapter).value.toString());
          var formattedDate = "${date.day}-${date.month}-${date.year}";
          _endDate = formattedDate;

          print(_endDate);
        });

    List<Widget> actions = [
      FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: new Text(PickerLocalizations.of(context).cancelText)),
      FlatButton(
          onPressed: () {
            Navigator.pop(context);
            ps.onConfirm(ps, ps.selecteds);
            pe.onConfirm(pe, pe.selecteds);
            _apiAnalyticsScreen();
          },
          child: new Text(PickerLocalizations.of(context).confirmText))
    ];

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text("Select Date Range"),
            actions: actions,
            content: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("Begin:"),
                  ps.makePicker(),
                  Text("End:"),
                  pe.makePicker()
                ],
              ),
            ),
          );
        });
  }

  void _apiAnalyticsScreen() async {
    if (await Common.isNetworkAvailable()) {
      Future.delayed(Duration.zero, () => Common.dialogLoader(context));

      var currentDate = new DateTime.now();
      var date = DateTime.parse(currentDate.toString());
      var formattedcurrentDate = "${date.day}-${date.month}-${date.year}";

      DateTime sevenDaysAgo = currentDate.subtract(new Duration(days: 7));
      var previousdate = DateTime.parse(sevenDaysAgo.toString());
      var formattedseendayDate =
          "${previousdate.day}-${previousdate.month}-${previousdate.year}";

      var data;
      if (_beginDate == null && _endDate == null) {
        data = {
          "BranchId": int.parse(await SharedPrefManager.getString(keyBranchId)),
          "DateFrom": formattedseendayDate,
          "DateTo": formattedcurrentDate
        };
      } else {
        data = {
          "BranchId": int.parse(await SharedPrefManager.getString(keyBranchId)),
          "DateFrom": _beginDate,
          "DateTo": _endDate
        };
      }

      Request request = Request(urlAnalyticsScreen, data);
      request.post().then((result) {
        Navigator.pop(context);
        setState(() {
          _totalnoofbooking =
              result.data['AnalyticsScreenResult']['TotalBooking'];
          _totalrevenue = result.data['AnalyticsScreenResult']['TotalRevenue'];
          _totalcommision =
              result.data['AnalyticsScreenResult']['TotalCommision'];
          _begindt = result.data['AnalyticsScreenResult']['DateFrom'];
          _enddt = result.data['AnalyticsScreenResult']['DateTo'];
        });
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
