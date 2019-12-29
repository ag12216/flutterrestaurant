import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant/data/drawer/drawer_data.dart';
import 'package:restaurant/http/request.dart';
import 'package:restaurant/http/urls.dart';
import 'package:restaurant/pojo/getTableViewListName.dart';
import 'package:restaurant/res/color.dart';
import 'package:restaurant/screens/Page6.dart';
import 'package:restaurant/screens/dashboard.dart';
import 'package:restaurant/screens/login.dart';
import 'package:restaurant/screens/login1.dart';
import 'package:restaurant/screens/manager_history.dart';
import 'package:restaurant/screens/page1.dart';
import 'package:restaurant/screens/page4.dart';
import 'package:restaurant/util/common.dart';
import 'package:restaurant/util/routes.dart';
import 'package:restaurant/util/shared_pref_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum DataResponse { DataRecieved, DataError, DataLoading }

List<String> globalSelectedTypeArr = [];
List<TableViewList> globalSelectedViewArr = [];
List<TableViewList> globalTableViewList = [];

class Page5 extends StatefulWidget {
  final List<String> newtabletypelist;
  final int sum;
  Page5({this.newtabletypelist, this.sum});

  @override
  _Page5State createState() => _Page5State();
}

class _Page5State extends State<Page5> {
  //OLD
  String _selectedtabletype;
  TableViewList _selectedtableView;

  //NEW

  List<String> _selectedTypeArr = [];
  final StreamController<int> _stateControllerType =
      StreamController.broadcast();

  List<TableViewList> _tableViewList = [];
  List<TableViewList> _selectedViewArr = [];
  final StreamController<int> _stateControllerView =
      StreamController.broadcast();
  final StreamController<DataResponse> _stateControllerTableViewRes =
      StreamController.broadcast();
String _fullname= "";
  String  _branchname="";
  @override
  void initState() {
        _assignValue();

    _prefillDummyValues();
    _apiGetTableViewListName();
    super.initState();
  }
void _assignValue() async {
   _fullname = await SharedPrefManager.getString(keyfirstname) +
        " " +
        await SharedPrefManager.getString(keylastname);
    _branchname = await SharedPrefManager.getString(keyBranchName);
}
  Future<bool> backPress() {
    Routes.navigateRemoveUntil(context, Page4());
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
            child:    ListView(
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
                 ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.fromLTRB(10, 15, 10, 5),
                        itemCount: widget.sum,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            color: Colors.grey[200],
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        color: Colors.grey[200],
                                        padding:
                                            EdgeInsets.fromLTRB(15, 15, 15, 5),
                                        child: Text(
                                          "TABLE NO",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 13),
                                        ),
                                      ),
                                      Container(
                                        width: 100,
                                        color: Colors.grey[200],
                                        padding:
                                            EdgeInsets.fromLTRB(15, 5, 15, 5),
                                        child: Container(
                                          padding: const EdgeInsets.all(10.0),
                                          decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            border:
                                                Border.all(color: Colors.grey),
                                          ), //       <--- BoxDecoration here
                                          child: Center(
                                            child: new Text(
                                              (index + 1).toString(), // index+1
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        color: Colors.grey[200],
                                        padding:
                                            EdgeInsets.fromLTRB(15, 15, 15, 5),
                                        child: Text(
                                          "TYPE",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 13),
                                        ),
                                      ),
                                      Container(
                                        color: Colors.grey[200],
                                        child: StreamBuilder<int>(
                                            initialData: index,
                                            stream: _stateControllerType.stream,
                                            builder: (context, snapshot) {
                                              return DropdownButton(
                                                hint: Text(
                                                    'Select'), // Not necessary for Option 1
                                                value:
                                                    _selectedTypeArr[index] ??
                                                        "",
                                                onChanged: (newValue) {
                                                  _selectedTypeArr[index] =
                                                      newValue;
                                                  _stateControllerType.sink
                                                      .add(index);

//                                        setState(() {
//                                          _selectedtabletype = newValue;
//                                        });
                                                },
                                                items: widget.newtabletypelist
                                                        ?.map((ttype) {
                                                      return DropdownMenuItem(
                                                        child: new Text(ttype),
                                                        value: ttype,
                                                      );
                                                    })?.toList() ??
                                                    [],
                                              );
                                            }),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        color: Colors.grey[200],
                                        padding:
                                            EdgeInsets.fromLTRB(15, 15, 15, 5),
                                        child: Text(
                                          "VIEW",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 13),
                                        ),
                                      ),
                                      StreamBuilder<DataResponse>(
                                          stream: _stateControllerTableViewRes
                                              .stream,
                                          initialData: DataResponse.DataLoading,
                                          builder: (context, snapshot) {
                                            if (snapshot.data ==
                                                DataResponse.DataLoading) {
                                              return Container();
                                            }

                                            return Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  15, 0, 15, 0),
                                              color: Colors.grey[200],
                                              child: StreamBuilder<int>(
                                                  initialData: index,
                                                  stream: _stateControllerView
                                                      .stream,
                                                  builder: (context, snapshot) {
                                                    return DropdownButton(
                                                      isExpanded: true,
                                                      hint: Text(
                                                          'Select'), // Not necessary for Option 1
                                                      value: _selectedViewArr[
                                                          index],
                                                      onChanged: (newValue) {
                                                        _selectedViewArr[
                                                            index] = newValue;
                                                        _stateControllerView
                                                            .sink
                                                            .add(index);

//                                            setState(() {
//                                              _selectedtableView = newValue;
//                                              //  int   _selectedtableViewid =_selectedtableView.id;
//                                            });
                                                      },
                                                      items: _tableViewList
                                                              ?.map(
                                                                  (tableView) {
                                                            return DropdownMenuItem(
                                                              child: new Text(
                                                                tableView
                                                                    .tableView,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        11),
                                                              ),
                                                              value: tableView,
                                                            );
                                                          })?.toList() ??
                                                          [],
                                                    );
                                                  }),
                                            );
                                          }),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        }
                        //  =>
                        //     _buildTableListview(
                        //         context, widget.sum,widget.newtabletypelist),

                        ),
                    SizedBox(
                      height: 5,
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
                              Routes.navigateRemoveUntil(context, Page4());
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
                              Routes.navigateRemoveUntil(context, Page6());
                            },
                            color: Colors.white),
                      )),
                )
              ],
            ),
          )),
    );
  }

  void _apiGetTableViewListName() async {
    if (await Common.isNetworkAvailable()) {
      Request request = Request(urlGetTableViewListName, {});
      request.post().then((result) {
        //setState(() {
        var resp = result.data['TableViewList'] as List;
        _tableViewList = resp
            .map<TableViewList>((json) => TableViewList.fromJson(json))
            .toList();

        if (globalSelectedViewArr.length != 0) {
          _selectedViewArr = globalSelectedViewArr;
          _tableViewList = globalTableViewList;
        } else {
          for (int i = 0; i < widget.sum; i++) {
            _selectedViewArr.add(_tableViewList.first);
          }
        }

        _stateControllerTableViewRes.sink.add(DataResponse.DataRecieved);

        //});
      }).catchError((error) {});
    }
  }

  _prefillDummyValues() {
    _tableViewList = globalTableViewList;
    _selectedViewArr = globalSelectedViewArr;

    if (globalSelectedTypeArr.length != 0) {
      _selectedTypeArr = globalSelectedTypeArr;
    } else {
      for (int i = 0; i < widget.sum; i++) {
        _selectedTypeArr.add(widget.newtabletypelist.first);
      }
    }
  }

  _onNextPressed() {
    List<String> results = [];
    for (int i = 0; i < widget.sum; i++) {
      results.add("${_selectedTypeArr[i]}|${_selectedViewArr[i]}");
    }

    print(results);

    globalSelectedTypeArr = _selectedTypeArr;
    globalSelectedViewArr = _selectedViewArr;
    globalTableViewList = _tableViewList;
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
