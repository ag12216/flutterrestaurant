import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant/data/drawer/drawer_data.dart';
import 'package:restaurant/res/color.dart';
import 'package:restaurant/screens/Page5.dart';
import 'package:restaurant/screens/dashboard.dart';
import 'package:restaurant/screens/login.dart';
import 'package:restaurant/screens/login1.dart';
import 'package:restaurant/screens/manager_history.dart';
import 'package:restaurant/screens/page1.dart';
import 'package:restaurant/screens/page7.dart';
import 'package:restaurant/util/routes.dart';
import 'package:restaurant/util/shared_pref_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<String> globalselectedTypeArr = [];
List<String> globalselectedDaysArr = [];
List<String> globalselectedStartTimeArr = [];
List<String> globalselectedToTimeArr = [];
List<String> globalselectedCostValue = [];
int globalRowsCreated = 0;

class Page6 extends StatefulWidget {
  @override
  _Page6State createState() => _Page6State();
}

class _Page6State extends State<Page6> {
  List<TextEditingController> _controllers = [];

  List<String> _selectedTypeArr = [];
  final StreamController<int> _stateControllerType =
      StreamController.broadcast();
  List<String> _locations = ['1P', '2P', '3P', '5P']; // Option 2
  String _selectedLocation; // Op
String _fullname= "";
  String  _branchname="";
  List<String> _selectedDaysArr = [];
  final StreamController<int> _stateControllerDays =
      StreamController.broadcast();
  List<String> _locations111 = [
    'MONDAY',
    'TUESDAY',
    'WEDNESDAY',
    'THURSDAY',
    'FRIDAY',
    'SATURDAY',
    'SUNDAY'
  ]; //days
  String _selectedLocation111; // Op

  List<String> _selectedStartTimeArr = [];
  final StreamController<int> _stateControllerTimeFrom =
      StreamController.broadcast();
  List<String> _starttime = [
    '04:00 PM',
    '04:30 PM',
    '05:00 PM',
    '05:30 PM',
    '06:00 PM',
    '06:30 PM',
    '07:00 PM'
  ]; //starttime
  String _stime; // Op

  var _myCreatelist = List<Widget>();

  //To time
  List<String> _selectedToTimeArr = [];
  final StreamController<int> _stateControllerTimeTo =
      StreamController.broadcast();

  //ROWS
  int _index = 0;
  final StreamController<String> _stateControllerRows =
      StreamController.broadcast();

  void _add() {
    _fillMoreDummyOnAddMore();
    int keyValue = _index;
    _controllers.add(new TextEditingController());

    _myCreatelist = List.from(_myCreatelist)
      ..add(Column(
        key: Key("$keyValue"),
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 5),
            color: Colors.grey[200],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      StreamBuilder<int>(
                          stream: _stateControllerType.stream,
                          builder: (context, snapshot) {
                            return Container(
                              padding: EdgeInsets.fromLTRB(5, 0, 5, 3),
                              color: Colors.grey[200],
                              child: DropdownButton(
                                isExpanded: true,
                                hint: Text(
                                  'Select',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 11),
                                ),
                                // Not necessary for Option 1
                                value: _selectedTypeArr[keyValue],
                                onChanged: (newValue) {
                                  _selectedTypeArr[keyValue] = newValue;
                                  _stateControllerType.sink.add(keyValue);

//                                  String v = _selectedLocation;
//                                  Common.toast(context, v);

//                                  setState(() {
//                                    _selectedLocation = newValue;
//                                    String v = _selectedLocation;
//                                    Common.toast(context, v);
//                                  });
                                },
                                items: _locations.map((location) {
                                  return DropdownMenuItem(
                                    child: new Text(
                                      location,
                                      style: TextStyle(fontSize: 11),
                                    ),
                                    value: location,
                                  );
                                }).toList(),
                              ),
                            );
                          }),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      StreamBuilder<int>(
                          stream: _stateControllerDays.stream,
                          builder: (context, snapshot) {
                            return Container(
                              padding: EdgeInsets.fromLTRB(5, 0, 5, 3),
                              color: Colors.grey[200],
                              child: DropdownButton(
                                isExpanded: true,
                                hint: Text(
                                  'Select',
                                  style: TextStyle(fontSize: 11),
                                ),
                                // Not necessary for Option 1
                                value: _selectedDaysArr[keyValue],
                                onChanged: (newValue) {
                                  _selectedDaysArr[keyValue] = newValue;
                                  _stateControllerDays.sink.add(keyValue);

//                            setState(() {
//                              _selectedLocation111 = newValue;
//                            });
                                },
                                items: _locations111.map((loc) {
                                  return DropdownMenuItem(
                                    child: new Text(
                                      loc,
                                      style: TextStyle(fontSize: 11),
                                    ),
                                    value: loc,
                                  );
                                }).toList(),
                              ),
                            );
                          }),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      StreamBuilder<int>(
                          stream: _stateControllerTimeFrom.stream,
                          builder: (context, snapshot) {
                            return Container(
                              padding: EdgeInsets.fromLTRB(5, 0, 5, 3),
                              color: Colors.grey[200],
                              child: DropdownButton(
                                isExpanded: true,
                                hint: Text(
                                  'Select',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 11,
                                  ),
                                ),
                                // Not necessary for Option 1
                                value: _selectedStartTimeArr[keyValue],
                                onChanged: (newValue) {
                                  _selectedStartTimeArr[keyValue] = newValue;
                                  _stateControllerTimeFrom.sink.add(keyValue);

//                                setState(() {
//                                  _stime = newValue;
//                                });
                                },
                                items: _starttime.map((stime) {
                                  return DropdownMenuItem(
                                    child: new Text(
                                      stime,
                                      style: TextStyle(fontSize: 11),
                                    ),
                                    value: stime,
                                  );
                                }).toList(),
                              ),
                            );
                          }),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      StreamBuilder<int>(
                          stream: _stateControllerTimeTo.stream,
                          builder: (context, snapshot) {
                            return Container(
                              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                              color: Colors.grey[200],
                              child: DropdownButton(
                                isExpanded: true,
                                hint: Text(
                                  'Select',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 11),
                                ),
                                // Not necessary for Option 1
                                value: _selectedToTimeArr[keyValue],
                                onChanged: (newValue) {
                                  _selectedToTimeArr[keyValue] = newValue;
                                  _stateControllerTimeTo.sink.add(keyValue);

//                                setState(() {
//                                  _stime = newValue;
//                                });
                                },
                                items: _starttime.map((stime) {
                                  return DropdownMenuItem(
                                    child: new Text(
                                      stime,
                                      style: TextStyle(fontSize: 11),
                                    ),
                                    value: stime,
                                  );
                                }).toList(),
                              ),
                            );
                          }),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        color: Colors.grey[200],
                        padding: EdgeInsets.fromLTRB(15, 0, 1, 0),
                        child: TextFormField(
                          controller: _controllers[keyValue],
                          keyboardType: TextInputType.number,
                          autofocus: false,
                          style: new TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.grey),
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0.0)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ListTile(
          //   leading: Text('Pet $_index : '),
          //   title: TextField(
          //     onChanged: (val) => _formdata['pet${keyValue - 1}'] = val,
          //   ),
          // ),
        ],
      ));

//    setState(() => ++_index);

    _index = _index + 1;
    _stateControllerRows.sink.add("");
  }

  void _addIfDataAlreadyPresent(int index) {
    _fillMoreDummyOnAddMore();
    int keyValue = index;
    //_controllers.add(new TextEditingController());

    _myCreatelist = List.from(_myCreatelist)
      ..add(Column(
        key: Key("$keyValue"),
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 5),
            color: Colors.grey[200],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      StreamBuilder<int>(
                          stream: _stateControllerType.stream,
                          builder: (context, snapshot) {
                            return Container(
                              padding: EdgeInsets.fromLTRB(5, 0, 5, 3),
                              color: Colors.grey[200],
                              child: DropdownButton(
                                isExpanded: true,
                                hint: Text(
                                  'Select',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 11),
                                ),
                                // Not necessary for Option 1
                                value: _selectedTypeArr[keyValue],
                                onChanged: (newValue) {
                                  _selectedTypeArr[keyValue] = newValue;
                                  _stateControllerType.sink.add(keyValue);

//                                  String v = _selectedLocation;
//                                  Common.toast(context, v);

//                                  setState(() {
//                                    _selectedLocation = newValue;
//                                    String v = _selectedLocation;
//                                    Common.toast(context, v);
//                                  });
                                },
                                items: _locations.map((location) {
                                  return DropdownMenuItem(
                                    child: new Text(
                                      location,
                                      style: TextStyle(fontSize: 11),
                                    ),
                                    value: location,
                                  );
                                }).toList(),
                              ),
                            );
                          }),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      StreamBuilder<int>(
                          stream: _stateControllerDays.stream,
                          builder: (context, snapshot) {
                            return Container(
                              padding: EdgeInsets.fromLTRB(5, 0, 5, 3),
                              color: Colors.grey[200],
                              child: DropdownButton(
                                isExpanded: true,
                                hint: Text(
                                  'Select',
                                  style: TextStyle(fontSize: 11),
                                ),
                                // Not necessary for Option 1
                                value: _selectedDaysArr[keyValue],
                                onChanged: (newValue) {
                                  _selectedDaysArr[keyValue] = newValue;
                                  _stateControllerDays.sink.add(keyValue);

//                            setState(() {
//                              _selectedLocation111 = newValue;
//                            });
                                },
                                items: _locations111.map((loc) {
                                  return DropdownMenuItem(
                                    child: new Text(
                                      loc,
                                      style: TextStyle(fontSize: 11),
                                    ),
                                    value: loc,
                                  );
                                }).toList(),
                              ),
                            );
                          }),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      StreamBuilder<int>(
                          stream: _stateControllerTimeFrom.stream,
                          builder: (context, snapshot) {
                            return Container(
                              padding: EdgeInsets.fromLTRB(5, 0, 5, 3),
                              color: Colors.grey[200],
                              child: DropdownButton(
                                isExpanded: true,
                                hint: Text(
                                  'Select',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 11,
                                  ),
                                ),
                                // Not necessary for Option 1
                                value: _selectedStartTimeArr[keyValue],
                                onChanged: (newValue) {
                                  _selectedStartTimeArr[keyValue] = newValue;
                                  _stateControllerTimeFrom.sink.add(keyValue);

//                                setState(() {
//                                  _stime = newValue;
//                                });
                                },
                                items: _starttime.map((stime) {
                                  return DropdownMenuItem(
                                    child: new Text(
                                      stime,
                                      style: TextStyle(fontSize: 11),
                                    ),
                                    value: stime,
                                  );
                                }).toList(),
                              ),
                            );
                          }),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      StreamBuilder<int>(
                          stream: _stateControllerTimeTo.stream,
                          builder: (context, snapshot) {
                            return Container(
                              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                              color: Colors.grey[200],
                              child: DropdownButton(
                                isExpanded: true,
                                hint: Text(
                                  'Select',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 11),
                                ),
                                // Not necessary for Option 1
                                value: _selectedToTimeArr[keyValue],
                                onChanged: (newValue) {
                                  _selectedToTimeArr[keyValue] = newValue;
                                  _stateControllerTimeTo.sink.add(keyValue);

//                                setState(() {
//                                  _stime = newValue;
//                                });
                                },
                                items: _starttime.map((stime) {
                                  return DropdownMenuItem(
                                    child: new Text(
                                      stime,
                                      style: TextStyle(fontSize: 11),
                                    ),
                                    value: stime,
                                  );
                                }).toList(),
                              ),
                            );
                          }),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        color: Colors.grey[200],
                        padding: EdgeInsets.fromLTRB(15, 0, 1, 0),
                        child: TextFormField(
                          controller: _controllers[keyValue],
                          keyboardType: TextInputType.number,
                          autofocus: false,
                          style: new TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.grey),
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0.0)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ListTile(
          //   leading: Text('Pet $_index : '),
          //   title: TextField(
          //     onChanged: (val) => _formdata['pet${keyValue - 1}'] = val,
          //   ),
          // ),
        ],
      ));

//    setState(() => ++_index);
  }

  @override
  void initState() {
     _assignValue();
    _fillDummyValues();
    super.initState();
  }
void _assignValue() async {
   _fullname = await SharedPrefManager.getString(keyfirstname) +
        " " +
        await SharedPrefManager.getString(keylastname);
    _branchname = await SharedPrefManager.getString(keyBranchName);
}

  Future<bool> backPress() {
    Routes.navigateRemoveUntil(context, Page5());
    return Future.value(false);
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
            child: ListView(
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
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 9),
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
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 9),
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
                                  color: Colors.deepOrangeAccent,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 2, 0, 15),
                              child: Text(
                                "Photos / Menus",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 9),
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
                                  color: Colors.deepOrangeAccent,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 2, 0, 15),
                              child: Text(
                                "Inventory",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 9),
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
                                  color: Colors.deepOrangeAccent,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 2, 0, 15),
                              child: Text(
                                "Table Info",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 9),
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
                                  color: Colors.deepOrangeAccent,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 2, 0, 15),
                              child: Text(
                                "Table Info",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 9),
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
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 9),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
                Container(
                  padding: EdgeInsets.fromLTRB(15, 15, 15, 5),
                  color: Colors.grey[200],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                              color: Colors.grey[200],
                              child: Text(
                                "TABLE TYPE",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 11),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                              color: Colors.grey[200],
                              child: Text(
                                "DAYS",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                              color: Colors.grey[200],
                              child: Text(
                                "TIME FROM",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                              color: Colors.grey[200],
                              child: Text(
                                "TIME TO",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 11),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                              color: Colors.grey[200],
                              child: Text(
                                "COST",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 11),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 7,
                ),
                StreamBuilder<String>(
                    stream: _stateControllerRows.stream,
                    builder: (context, snapshot) {
                      return Container(
                        child: ListView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: _myCreatelist,
                        ),
                      );
                    }),
                Container(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 5),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: FlatButton(
                        onPressed: _add,
                        child: Text('ADD MORE',
                            style: TextStyle(color: Colors.grey, fontSize: 13)),
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Colors.grey,
                                width: 1,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(0)),
                      ),
                    )),
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
                              // ! when back press then state maintain all previous dropdown

                              List<String> tableTypestringList = [
                                "1p",
                                "2p",
                                "3p",
                                "6p"
                              ];

                              Routes.navigate(
                                  context,
                                  Page5(
                                    newtabletypelist: tableTypestringList,
                                    sum: 7,
                                  ));
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
                              _onNextPressed();
                              Routes.navigateRemoveUntil(context, Page7());
                            },
                            color: Colors.white),
                      )),
                )
              ],
            ),
          )),
    );
  }

  _fillDummyValues() {
    if (globalRowsCreated != 0) {
      _selectedTypeArr = globalselectedTypeArr;
      _selectedDaysArr = globalselectedDaysArr;
      _selectedStartTimeArr = globalselectedStartTimeArr;
      _selectedToTimeArr = globalselectedToTimeArr;
//      globalselectedCostValue = costValue;
      _index = globalRowsCreated;

      _controllers = [];
      for (int i = 0; i < _index; i++) {
        TextEditingController controller = TextEditingController();
        controller.text = globalselectedCostValue[i];
        _controllers.add(controller);
        _addIfDataAlreadyPresent(i);
      }
    } else {
      for (int i = 0; i < _index; i++) {
        _selectedTypeArr.add(_locations.first);
        _selectedDaysArr.add(_locations111.first);
        _selectedStartTimeArr.add(_starttime.first);
        _selectedToTimeArr.add(_starttime.first);
      }
      _add();
    }
  }

  _fillMoreDummyOnAddMore() {
    _selectedTypeArr.add(_locations.first);
    _selectedDaysArr.add(_locations111.first);
    _selectedStartTimeArr.add(_starttime.first);
    _selectedToTimeArr.add(_starttime.first);
  }

  _onNextPressed() {
    List<String> results = [];
    List<String> costValue = [];

    for (int i = 0; i < _index; i++) {
      results.add(
          "${_selectedTypeArr[i]}|${_selectedDaysArr[i]}|${_selectedStartTimeArr[i]}|${_selectedToTimeArr[i]}|${_controllers[i].text}");
      costValue.add(_controllers[i].text);
    }

    globalselectedTypeArr = _selectedTypeArr;
    globalselectedDaysArr = _selectedDaysArr;
    globalselectedStartTimeArr = _selectedStartTimeArr;
    globalselectedToTimeArr = _selectedToTimeArr;
    globalselectedCostValue = costValue;
    globalRowsCreated = _index;

    print(results);
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
