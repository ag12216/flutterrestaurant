import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant/data/drawer/drawer_data.dart';
import 'package:restaurant/http/request.dart';
import 'package:restaurant/http/urls.dart';
import 'package:restaurant/res/color.dart';
import 'package:restaurant/res/string.dart';
import 'package:restaurant/screens/dashboard.dart';
import 'package:restaurant/screens/login.dart';
import 'package:restaurant/screens/login1.dart';
import 'package:restaurant/screens/manager_history.dart';
import 'package:restaurant/screens/page1.dart';
import 'package:restaurant/screens/page3.dart';
import 'package:restaurant/util/common.dart';
import 'package:restaurant/util/routes.dart';
import 'package:restaurant/util/shared_pref_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Page2 extends StatefulWidget {
  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  bool _isMonday = false;
  bool _isTuesday = false;
  bool _isWednesday = false;
  bool _isThursday = false;
  bool _isFriday = false;
  bool _isSaturday = false;
  bool _isSunday = false;

  String _monStart, _monEnd;
  String _tueStart, _tueEnd;
  String _wedStart, _wedEnd;
  String _thuStart, _thuEnd;
  String _friStart, _friEnd;
  String _satStart, _satEnd;
  String _sunStart, _sunEnd;

  List<String> _locations = [
    '12:00 AM',
    '12:30 AM',
    '1:00 AM',
    '1:30 AM',
    '2:00 AM',
    '2:30 AM',
    '3:00 AM',
    '3:30 AM',
    '4:00 AM',
    '4:30 AM',
    '5:00 AM',
    '5:30 AM',
    '6:00 AM',
    '6:30 AM',
    '7:00 AM',
    '7:30 AM',
    '8:00 AM',
    '8:30 AM',
    '9:00 AM',
    '9:30 AM',
    '10:00 AM',
    '10:30 AM',
    '11:00 AM',
    '11:30 AM',
  ]; // Option 2

  //? monday list
  List<String> _monStartList;
  List<String> _monEndList;

//? tuesday list
  List<String> _tueStartList;
  List<String> _tueEndList;

//? wednesday list
  List<String> _wedStartList;
  List<String> _wedEndList;

//? thursday list
  List<String> _thuStartList;
  List<String> _thuEndList;

//? friday list
  List<String> _friStartList;
  List<String> _friEndList;

//? saturday list
  List<String> _satStartList;
  List<String> _satEndList;

//? sunday list
  List<String> _sunStartList;
  List<String> _sunEndList;
//? 

  String _fullname= "";
  String  _branchname="";
  @override
  initState() {
    _startstatictime();
_assignValue();
    super.initState();
  }
void _assignValue() async {

   _fullname = await SharedPrefManager.getString(keyfirstname) +
        " " +
        await SharedPrefManager.getString(keylastname);
    _branchname = await SharedPrefManager.getString(keyBranchName);
}
  String _selectedLocation; // Op

  Future<bool> backPress() {
    Routes.navigateRemoveUntil(context, Page1());
    return Future.value(false);
  }












  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: backPress,
      child: Scaffold(
          drawer:  SafeArea(
              child: Drawer(
                  child: ListView(
            children: <Widget>[

             Container(
               padding: EdgeInsets.symmetric(vertical: 15,horizontal: 10),
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
                          color: Colors.white,width: 35,height: 35,
                        ),
                      ),
                    SizedBox(width: 7,),
                 Column(
                                           crossAxisAlignment: CrossAxisAlignment.start,

                   children: <Widget>[

                 Text(_fullname,style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),),
                  SizedBox(height: 3,),
                 Text(_branchname,style: TextStyle(fontSize: 13,color: Colors.white),)

                 ],)
                 
                 
                 ],)),



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
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            title: new Text(
              'ADD RESTAURANT DETAILS',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 17),
            ),
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
            color: Colors.grey[200],
            child: Stack(
              children: <Widget>[
                ListView(
                  children: <Widget>[
                    Container(
                        color: Colors.grey[200],
                        padding: EdgeInsets.fromLTRB(5, 15, 5, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    "1",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.deepOrangeAccent,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(0, 2, 0, 15),
                                  child: Text(
                                    "Branch Info",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 9),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    "2",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.deepOrangeAccent,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(0, 2, 0, 15),
                                  child: Text(
                                    "Opening Hrs",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 9),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    "3",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(0, 2, 0, 15),
                                  child: Text(
                                    "Photos / Menus",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 9),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    "4",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(0, 2, 0, 15),
                                  child: Text(
                                    "Inventory",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 9),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    "5",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(0, 2, 0, 15),
                                  child: Text(
                                    "Table Info",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 9),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    "6",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(0, 2, 0, 15),
                                  child: Text(
                                    "Table Info",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 9),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    "7",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(0, 2, 0, 15),
                                  child: Text(
                                    "Additional",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 9),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                    Container(
                      color: Colors.grey[200],
                      padding: EdgeInsets.fromLTRB(15, 10, 15, 5),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                  child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Switch(
                                      value: _isMonday,
                                      onChanged: (value) {
                                        setState(() {
                                          _isMonday = !_isMonday;
                                        });
                                      },
                                      activeTrackColor: Colors.blue,
                                      activeColor: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: Text(
                                        "MONDAY",
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 13),
                                      ))
                                ],
                              )),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Visibility(
                                visible: _isMonday,
                                child: Container(
                                    child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        color: Colors.grey[200],
                                        child: DropdownButton(
                                          isExpanded: true,
                                          hint: Text(
                                            'Select',
                                            style: TextStyle(fontSize: 11),
                                          ), // Not necessary for Option 1
                                          value: _monStart,
                                          onChanged: (newValue) {
                                            setState(() {
                                              _monStart = newValue;
                                            });
                                          },
                                          items: _monStartList?.map((monstart) {
                                                return DropdownMenuItem(
                                                  child: new Text(
                                                    monstart,
                                                    style:
                                                        TextStyle(fontSize: 11),
                                                  ),
                                                  value: monstart,
                                                );
                                              })?.toList() ??
                                              [],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 25,
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        color: Colors.grey[200],
                                        child: DropdownButton(
                                          isExpanded: true,
                                          hint: Text(
                                            'Select',
                                            style: TextStyle(fontSize: 11),
                                          ), // Not necessary for Option 1
                                          value: _monEnd,
                                          onChanged: (newValue) {
                                            setState(() {
                                              _monEnd = newValue;
                                            });
                                          },
                                          items: _monEndList?.map((monend) {
                                                return DropdownMenuItem(
                                                  child: new Text(
                                                    monend,
                                                    style:
                                                        TextStyle(fontSize: 11),
                                                  ),
                                                  value: monend,
                                                );
                                              })?.toList() ??
                                              [],
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.grey[200],
                      padding: EdgeInsets.fromLTRB(15, 10, 15, 5),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                  child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Switch(
                                      value: _isTuesday,
                                      onChanged: (value) {
                                        setState(() {
                                          _isTuesday = !_isTuesday;
                                        });
                                      },
                                      activeTrackColor: Colors.blue,
                                      activeColor: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: Text(
                                        "TUESDAY",
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 13),
                                      ))
                                ],
                              )),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Visibility(
                                visible: _isTuesday,
                                child: Container(
                                    child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        color: Colors.grey[200],
                                        child: DropdownButton(
                                          isExpanded: true,
                                          hint: Text(
                                            'Select',
                                            style: TextStyle(fontSize: 11),
                                          ), // Not necessary for Option 1
                                          value: _tueStart,
                                          onChanged: (newValue) {
                                            setState(() {
                                              _tueStart = newValue;
                                            });
                                          },
                                          items: _tueStartList?.map((tuestart) {
                                                return DropdownMenuItem(
                                                  child: new Text(
                                                    tuestart,
                                                    style:
                                                        TextStyle(fontSize: 11),
                                                  ),
                                                  value: tuestart,
                                                );
                                              })?.toList() ??
                                              [],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 25,
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        color: Colors.grey[200],
                                        child: DropdownButton(
                                          isExpanded: true,
                                          hint: Text(
                                            'Select',
                                            style: TextStyle(fontSize: 11),
                                          ), // Not necessary for Option 1
                                          value: _tueEnd,
                                          onChanged: (newValue) {
                                            setState(() {
                                              _tueEnd = newValue;
                                            });
                                          },
                                          items: _tueEndList?.map((tueEnd) {
                                                return DropdownMenuItem(
                                                  child: new Text(
                                                    tueEnd,
                                                    style:
                                                        TextStyle(fontSize: 11),
                                                  ),
                                                  value: tueEnd,
                                                );
                                              })?.toList() ??
                                              [],
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.grey[200],
                      padding: EdgeInsets.fromLTRB(15, 10, 15, 5),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                  child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Switch(
                                      value: _isWednesday,
                                      onChanged: (value) {
                                        setState(() {
                                          _isWednesday = !_isWednesday;
                                        });
                                      },
                                      activeTrackColor: Colors.blue,
                                      activeColor: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: Text(
                                        "WEDNESDAY",
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 13),
                                      ))
                                ],
                              )),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Visibility(
                                visible: _isWednesday,
                                child: Container(
                                    child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        color: Colors.grey[200],
                                        child: DropdownButton(
                                          isExpanded: true,
                                          hint: Text(
                                            'Select',
                                            style: TextStyle(fontSize: 11),
                                          ), // Not necessary for Option 1
                                          value: _wedStart,
                                          onChanged: (newValue) {
                                            setState(() {
                                              _wedStart = newValue;
                                            });
                                          },
                                          items: _wedStartList?.map((wedstart) {
                                                return DropdownMenuItem(
                                                  child: new Text(
                                                    wedstart,
                                                    style:
                                                        TextStyle(fontSize: 11),
                                                  ),
                                                  value: wedstart,
                                                );
                                              })?.toList() ??
                                              [],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 25,
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        color: Colors.grey[200],
                                        child: DropdownButton(
                                          isExpanded: true,
                                          hint: Text(
                                            'Select',
                                            style: TextStyle(fontSize: 11),
                                          ), // Not necessary for Option 1
                                          value: _wedEnd,
                                          onChanged: (newValue) {
                                            setState(() {
                                              _wedEnd = newValue;
                                            });
                                          },
                                          items: _wedEndList?.map((wedend) {
                                                return DropdownMenuItem(
                                                  child: new Text(
                                                    wedend,
                                                    style:
                                                        TextStyle(fontSize: 11),
                                                  ),
                                                  value: wedend,
                                                );
                                              })?.toList() ??
                                              [],
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.grey[200],
                      padding: EdgeInsets.fromLTRB(15, 10, 15, 5),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                  child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Switch(
                                      value: _isThursday,
                                      onChanged: (value) {
                                        setState(() {
                                          _isThursday = !_isThursday;
                                        });
                                      },
                                      activeTrackColor: Colors.blue,
                                      activeColor: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: Text(
                                        "THURSDAY",
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 13),
                                      ))
                                ],
                              )),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Visibility(
                                visible: _isThursday,
                                child: Container(
                                    child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        color: Colors.grey[200],
                                        child: DropdownButton(
                                          isExpanded: true,
                                          hint: Text(
                                            'Select',
                                            style: TextStyle(fontSize: 11),
                                          ), // Not necessary for Option 1
                                          value: _thuStart,
                                          onChanged: (newValue) {
                                            setState(() {
                                              _thuStart = newValue;
                                            });
                                          },
                                          items: _thuStartList?.map((thuStart) {
                                                return DropdownMenuItem(
                                                  child: new Text(
                                                    thuStart,
                                                    style:
                                                        TextStyle(fontSize: 11),
                                                  ),
                                                  value: thuStart,
                                                );
                                              })?.toList() ??
                                              [],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 25,
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        color: Colors.grey[200],
                                        child: DropdownButton(
                                          isExpanded: true,
                                          hint: Text(
                                            'Select',
                                            style: TextStyle(fontSize: 11),
                                          ), // Not necessary for Option 1
                                          value: _thuEnd,
                                          onChanged: (newValue) {
                                            setState(() {
                                              _thuEnd = newValue;
                                            });
                                          },
                                          items: _thuEndList?.map((thuEnd) {
                                                return DropdownMenuItem(
                                                  child: new Text(
                                                    thuEnd,
                                                    style:
                                                        TextStyle(fontSize: 11),
                                                  ),
                                                  value: thuEnd,
                                                );
                                              })?.toList() ??
                                              [],
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.grey[200],
                      padding: EdgeInsets.fromLTRB(15, 10, 15, 5),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                  child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Switch(
                                      value: _isFriday,
                                      onChanged: (value) {
                                        setState(() {
                                          _isFriday = !_isFriday;
                                        });
                                      },
                                      activeTrackColor: Colors.blue,
                                      activeColor: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: Text(
                                        "FRIDAY",
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 13),
                                      ))
                                ],
                              )),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Visibility(
                                visible: _isFriday,
                                child: Container(
                                    child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        color: Colors.grey[200],
                                        child: DropdownButton(
                                          isExpanded: true,
                                          hint: Text(
                                            'Select',
                                            style: TextStyle(fontSize: 11),
                                          ), // Not necessary for Option 1
                                          value: _friStart,
                                          onChanged: (newValue) {
                                            setState(() {
                                              _friStart = newValue;
                                            });
                                          },
                                          items: _friStartList?.map((friStart) {
                                                return DropdownMenuItem(
                                                  child: new Text(
                                                    friStart,
                                                    style:
                                                        TextStyle(fontSize: 11),
                                                  ),
                                                  value: friStart,
                                                );
                                              })?.toList() ??
                                              [],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 25,
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        color: Colors.grey[200],
                                        child: DropdownButton(
                                          isExpanded: true,
                                          hint: Text(
                                            'Select',
                                            style: TextStyle(fontSize: 11),
                                          ), // Not necessary for Option 1
                                          value: _friEnd,
                                          onChanged: (newValue) {
                                            setState(() {
                                              _friEnd = newValue;
                                            });
                                          },
                                          items: _friEndList?.map((friEnd) {
                                                return DropdownMenuItem(
                                                  child: new Text(
                                                    friEnd,
                                                    style:
                                                        TextStyle(fontSize: 11),
                                                  ),
                                                  value: friEnd,
                                                );
                                              })?.toList() ??
                                              [],
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.grey[200],
                      padding: EdgeInsets.fromLTRB(15, 10, 15, 5),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                  child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Switch(
                                      value: _isSaturday,
                                      onChanged: (value) {
                                        setState(() {
                                          _isSaturday = !_isSaturday;
                                        });
                                      },
                                      activeTrackColor: Colors.blue,
                                      activeColor: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: Text(
                                        "SATURDAY",
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 13),
                                      ))
                                ],
                              )),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Visibility(
                                visible: _isSaturday,
                                child: Container(
                                    child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        color: Colors.grey[200],
                                        child: DropdownButton(
                                          isExpanded: true,
                                          hint: Text(
                                            'Select',
                                            style: TextStyle(fontSize: 11),
                                          ), // Not necessary for Option 1
                                          value: _satStart,
                                          onChanged: (newValue) {
                                            setState(() {
                                              _satStart = newValue;
                                            });
                                          },
                                          items: _satStartList?.map((satStart) {
                                                return DropdownMenuItem(
                                                  child: new Text(
                                                    satStart,
                                                    style:
                                                        TextStyle(fontSize: 11),
                                                  ),
                                                  value: satStart,
                                                );
                                              })?.toList() ??
                                              [],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 25,
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        color: Colors.grey[200],
                                        child: DropdownButton(
                                          isExpanded: true,
                                          hint: Text(
                                            'Select',
                                            style: TextStyle(fontSize: 11),
                                          ), // Not necessary for Option 1
                                          value: _satEnd,
                                          onChanged: (newValue) {
                                            setState(() {
                                              _satEnd = newValue;
                                            });
                                          },
                                          items: _satEndList.map((satEnd) {
                                            return DropdownMenuItem(
                                              child: new Text(
                                                satEnd,
                                                style: TextStyle(fontSize: 11),
                                              ),
                                              value: satEnd,
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.grey[200],
                      padding: EdgeInsets.fromLTRB(15, 10, 15, 5),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                  child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Switch(
                                      value: _isSunday,
                                      onChanged: (value) {
                                        setState(() {
                                          _isSunday = !_isSunday;
                                        });
                                      },
                                      activeTrackColor: Colors.blue,
                                      activeColor: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: Text(
                                        "SUNDAY",
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 13),
                                      ))
                                ],
                              )),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Visibility(
                                visible: _isSunday,
                                child: Container(
                                    child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        color: Colors.grey[200],
                                        child: DropdownButton(
                                          isExpanded: true,
                                          hint: Text(
                                            'Select',
                                            style: TextStyle(fontSize: 11),
                                          ), // Not necessary for Option 1
                                          value: _sunStart,
                                          onChanged: (newValue) {
                                            setState(() {
                                              _sunStart = newValue;
                                            });
                                          },
                                          items: _sunStartList?.map((sunStart) {
                                                return DropdownMenuItem(
                                                  child: new Text(
                                                    sunStart,
                                                    style:
                                                        TextStyle(fontSize: 11),
                                                  ),
                                                  value: sunStart,
                                                );
                                              })?.toList() ??
                                              [],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 25,
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        color: Colors.grey[200],
                                        child: DropdownButton(
                                          isExpanded: true,
                                          hint: Text(
                                            'Select',
                                            style: TextStyle(fontSize: 11),
                                          ), // Not necessary for Option 1
                                          value: _sunEnd,
                                          onChanged: (newValue) {
                                            setState(() {
                                              _sunEnd = newValue;
                                            });
                                          },
                                          items: _sunEndList?.map((sunEnd) {
                                                return DropdownMenuItem(
                                                  child: new Text(
                                                    sunEnd,
                                                    style:
                                                        TextStyle(fontSize: 11),
                                                  ),
                                                  value: sunEnd,
                                                );
                                              })?.toList() ??
                                              [],
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            color: Colors.grey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Expanded(
                  child: Container(
                      width: 150,
                      color: Colors.grey,
                      height: 50,
                      padding: EdgeInsets.all(10),
                      child: Container(
                        child: RaisedButton(
                            child: Text(
                              "PREVIOUS",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            ),
                            onPressed: () {
                              Routes.navigate(context, Page1());
                            },
                            color: Colors.white),
                      )),
                ),
                Expanded(
                  child: Container(
                      width: 150,
                      color: Colors.grey,
                      height: 50,
                      padding: EdgeInsets.all(10),
                      child: Container(
                        child: RaisedButton(
                            child: Text(
                              "NEXT",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            ),
                            onPressed: () {
                              // _apiAddRestaurantStep2();
                              Routes.navigate(context, Page3());
                            },
                            color: Colors.white),
                      )),
                )
              ],
            ),
          )),
    );
  }

  void _startstatictime() {
    List<String> _startTimeList = [
      '12:00 AM',
      '12:30 AM',
      '1:00 AM',
      '1:30 AM',
      '2:00 AM',
      '2:30 AM',
      '3:00 AM',
      '3:30 AM',
      '4:00 AM',
      '4:30 AM',
      '5:00 AM',
      '5:30 AM',
      '6:00 AM',
      '6:30 AM',
      '7:00 AM',
      '7:30 AM',
      '8:00 AM',
      '8:30 AM',
      '9:00 AM',
      '9:30 AM',
      '10:00 AM',
      '10:30 AM',
      '11:00 AM',
      '11:30 AM',
    ]; // Option 2

    List<String> _endTimeList = [
      '12:00 PM',
      '12:30 PM',
      '1:00 PM',
      '1:30 PM',
      '2:00 PM',
      '2:30 PM',
      '3:00 PM',
      '3:30 PM',
      '4:00 PM',
      '4:30 PM',
      '5:00 PM',
      '5:30 PM',
      '6:00 PM',
      '6:30 PM',
      '7:00 PM',
      '7:30 PM',
      '8:00 PM',
      '8:30 PM',
      '9:00 PM',
      '9:30 PM',
      '10:00 PM',
      '10:30 PM',
      '11:00 PM',
      '11:30 PM',
    ]; // Option 2

    _monStartList = _startTimeList;
    _monEndList = _endTimeList;

    _tueStartList = _startTimeList;
    _tueEndList = _endTimeList;

    _wedStartList = _startTimeList;
    _wedEndList = _endTimeList;

    _thuStartList = _startTimeList;
    _thuEndList = _endTimeList;

    _friStartList = _startTimeList;
    _friEndList = _endTimeList;

    _satStartList = _startTimeList;
    _satEndList = _endTimeList;

    _sunStartList = _startTimeList;
    _sunEndList = _endTimeList;
    // print(new DateFormat.yMMMd().format(new DateTime.now()));
  }

  void _apiAddRestaurantStep2() async {
    if (await Common.isNetworkAvailable()) {
      String _newmonStart = "";
      String _newmonEnd = "";
      //
      String _newtueStart = "";
      String _newtueEnd = "";
      //
      String _newwedStart = "";
      String _newwedEnd = "";
      //
      String _newthuStart = "";
      String _newthuEnd = "";
      //
      String _newfriStart = "";
      String _newfriEnd = "";
      //
      String _newsatStart = "";
      String _newsatEnd = "";
      //
      String _newsunStart = "";
      String _newsunEnd = "";
      Future.delayed(Duration.zero, () => Common.dialogLoader(context));

      if (_isMonday == true) {
        _newmonStart = _monStart;
        _newmonEnd = _monEnd;
      }
      if (_isTuesday == true) {
        _newtueStart = _tueStart;
        _newtueEnd = _tueEnd;
      }
      if (_isWednesday == true) {
        _newwedStart = _wedStart;
        _newwedEnd = _wedEnd;
      }
      if (_isThursday == true) {
        _newthuStart = _thuStart;
        _newthuEnd = _thuEnd;
      }
      if (_isFriday == true) {
        _newfriStart = _friStart;
        _newfriEnd = _friEnd;
      }
      if (_isSaturday == true) {
        _newsatStart = _satStart;
        _newsatEnd = _satEnd;
      }
      if (_isSunday == true) {
        _newsunStart = _sunStart;
        _newsunEnd = _sunEnd;
      }
      var data = {
        "step": 2,
        "BranchId": int.parse(await SharedPrefManager.getString(keyBranchId)),
        "HotelierId": int.parse(await SharedPrefManager.getString(keyRestId)),
        "RestCategoryId": 0,
        "RestName": "",
        "FoodType": "",
        "TimeZoneName": "",
        "Address1": "",
        "Address2": "",
        "Latitude": "",
        "Longitude": "",
        "FirstName": "",
        "LastName": "",
        "Email": "",
        "Landline": "",
        "Mobile": "",
        "AssignUser": "",
        "IsActive": "",
        "IsMonday": _isMonday.toString(),
        "MonStart": _newmonStart,
        "MonEnd": _newmonEnd,
        "IsTuesday": _isTuesday.toString(),
        "TueStart": _newtueStart,
        "TueEnd": _newtueEnd,
        "IsWednesday": _isWednesday.toString(),
        "WedStart": _newwedStart,
        "WedEnd": _newwedEnd,
        "IsThursday": _isThursday.toString(),
        "ThuStart": _newthuStart,
        "ThuEnd": _newthuEnd,
        "IsFriday": _isFriday.toString(),
        "FriStart": _newfriStart,
        "FriEnd": _newfriEnd,
        "IsSaturday": _isSaturday.toString(),
        "SatStart": _newsatStart,
        "SatEnd": _newsatEnd,
        "IsSunday": _isSunday.toString(),
        "SunStart": _newsunStart,
        "SunEnd": _newsunEnd,
        "TableTypeInventory": "",
        "NoOfTable": "",
        "MinPosition": "",
        "MaxPosition": "",
        "EstTime": "",
        "InventoryStatus": "",
        "TableNo": "",
        "TableTypeFetch": "",
        "TableView": "",
        "Status": ""
      };
      Request request = Request(urlAddRestaurant, data);
      request.post().then((result) {
        Navigator.pop(context);

        if (result.data['AddRestaurantResult']['BranchId'].toString() != "") {
          Routes.navigate(context, Page3());
        }
      }).catchError((error) {
        Common.toast(context, wrongMsg);
        Navigator.pop(context);
      });
    } else {
      Navigator.pop(context);
      Common.toast(context, noInternetMsg);
    }
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
}
