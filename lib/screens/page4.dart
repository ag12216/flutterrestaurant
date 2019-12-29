import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant/data/drawer/drawer_data.dart';
import 'package:restaurant/http/request.dart';
import 'package:restaurant/http/urls.dart';
import 'package:restaurant/pojo/_getTableTypeListName_res.dart';
import 'package:restaurant/pojo/getTableInventorylist.dart';
import 'package:restaurant/res/color.dart';
import 'package:restaurant/res/string.dart';
import 'package:restaurant/screens/Page5.dart';
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

class Page4 extends StatefulWidget {
  @override
  _Page4State createState() => _Page4State();
}

class _Page4State extends State<Page4> {
  final _formKey = GlobalKey<FormState>();
  String _nooftables, _minposition, _maxposition, _esttime;
  List<TableTypeList> tableTypeList;
  TableTypeList _selectedTableType;
  String _tableTypeInventory;
  List<AddRestaurantResult> inventorylistList;
  bool isTablestatus = false;
  List<String> temptabletype = [];
  List<String> tableTypestringList = [];
  int sum = 0;
  List<int> nooftablelist = [];
  TextEditingController _nooftablesController = TextEditingController();
  TextEditingController _minpositionController = TextEditingController();
  TextEditingController _maxpositionController = TextEditingController();
  TextEditingController _esttimeController = TextEditingController();
  String _fullname= "";
  String  _branchname="";
  @override
  void initState() {
    _assignValue();
    _apiGetTableTypeListName();
    super.initState();
  }

  void _assignValue() async {

     _fullname = await SharedPrefManager.getString(keyfirstname) +
        " " +
        await SharedPrefManager.getString(keylastname);
    _branchname = await SharedPrefManager.getString(keyBranchName);
    
    isTablestatus = await SharedPrefManager.getBool(keystatuspage4);
    _nooftablesController.text =
        await SharedPrefManager.getString(keynooftables);
    _minpositionController.text =
        await SharedPrefManager.getString(keyminposition);
    _maxpositionController.text =
        await SharedPrefManager.getString(keymaxposition);
    _esttimeController.text = await SharedPrefManager.getString(keyesttime);
    _nooftables = _nooftablesController.text;
    _minposition = _minpositionController.text;
    _maxposition = _maxpositionController.text;
    _esttime = _esttimeController.text;
  }

  Future<bool> backPress() {
    Routes.navigateRemoveUntil(context, Page3());
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
            body: Form(
              key: _formKey,
              child: Container(
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      color: Colors.grey[200],
                                      padding:
                                          EdgeInsets.fromLTRB(15, 15, 15, 5),
                                      child: Text(
                                        "TABLE TYPE",
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 13),
                                      ),
                                    ),
                                    Container(
                                      color: Colors.grey[200],
                                      padding:
                                          EdgeInsets.fromLTRB(15, 5, 15, 5),
                                      child: new DropdownButton(
                                        hint: Text('Select'),
                                        value: _selectedTableType,
                                        onChanged: (newValue) {
                                          setState(() {
                                            _selectedTableType = newValue;
                                            _tableTypeInventory =
                                                _selectedTableType.tableType;
                                            Common.toast(
                                                context,
                                                _selectedTableType.tableType
                                                    .toString());
                                          });
                                        },
                                        items: tableTypeList?.map((tableType) {
                                              return new DropdownMenuItem(
                                                value: tableType,
                                                child: new Text(
                                                  tableType.tableType,
                                                  style: new TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              );
                                            })?.toList() ??
                                            [],
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
                                      color: Colors.grey[200],
                                      padding:
                                          EdgeInsets.fromLTRB(15, 15, 15, 5),
                                      child: Text(
                                        "NO OF TABLES",
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 13),
                                      ),
                                    ),
                                    Container(
                                      color: Colors.grey[200],
                                      padding:
                                          EdgeInsets.fromLTRB(15, 5, 15, 5),
                                      child: TextFormField(
                                        controller: _nooftablesController,
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) =>
                                            _nooftables = value,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'No of tables required';
                                          }
                                          return null;
                                        },
                                        autofocus: false,
                                        style: new TextStyle(
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey),
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.fromLTRB(
                                              20.0, 10.0, 20.0, 10.0),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(0.0)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.grey[200],
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      color: Colors.grey[200],
                                      padding:
                                          EdgeInsets.fromLTRB(15, 15, 15, 5),
                                      child: Text(
                                        "MIN POSITION",
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 13),
                                      ),
                                    ),
                                    Container(
                                      color: Colors.grey[200],
                                      padding:
                                          EdgeInsets.fromLTRB(15, 5, 15, 5),
                                      child: TextFormField(
                                        controller: _minpositionController,
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) =>
                                            _minposition = value,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Min position required';
                                          }
                                          return null;
                                        },
                                        autofocus: false,
                                        style: new TextStyle(
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey),
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.fromLTRB(
                                              20.0, 10.0, 20.0, 10.0),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(0.0)),
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
                                      color: Colors.grey[200],
                                      padding:
                                          EdgeInsets.fromLTRB(15, 15, 15, 5),
                                      child: Text(
                                        "MAX POSITION",
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 13),
                                      ),
                                    ),
                                    Container(
                                      color: Colors.grey[200],
                                      padding:
                                          EdgeInsets.fromLTRB(15, 5, 15, 5),
                                      child: TextFormField(
                                        controller: _maxpositionController,
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) =>
                                            _maxposition = value,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Min position required';
                                          }
                                          return null;
                                        },
                                        autofocus: false,
                                        style: new TextStyle(
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey),
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.fromLTRB(
                                              20.0, 10.0, 20.0, 10.0),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(0.0)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.grey[200],
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      color: Colors.grey[200],
                                      padding:
                                          EdgeInsets.fromLTRB(15, 15, 15, 5),
                                      child: Text(
                                        "EST TIME (MINS)",
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 13),
                                      ),
                                    ),
                                    Container(
                                      color: Colors.grey[200],
                                      padding:
                                          EdgeInsets.fromLTRB(15, 5, 15, 5),
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: _esttimeController,
                                        onChanged: (value) => _esttime = value,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Est time required';
                                          }
                                          return null;
                                        },
                                        autofocus: false,
                                        style: new TextStyle(
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey),
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.fromLTRB(
                                              20.0, 10.0, 20.0, 10.0),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(0.0)),
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
                                      color: Colors.grey[200],
                                      padding:
                                          EdgeInsets.fromLTRB(15, 15, 15, 5),
                                      child: Text(
                                        "STATUS",
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 13),
                                      ),
                                    ),
                                    Switch(
                                      value: isTablestatus,
                                      onChanged: (value) {
                                        setState(() {
                                          isTablestatus = value;
                                        });
                                      },
                                      activeTrackColor: Colors.blue,
                                      activeColor: Colors.white,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(150, 15, 150, 0),
                          child: FlatButton(
                            onPressed: () {
                              _apiGetInventorylist();
                            },
                            child: Text('ADD',
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 13)),
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Colors.grey,
                                    width: 1,
                                    style: BorderStyle.solid),
                                borderRadius: BorderRadius.circular(0)),
                          ),
                        ),
                        inventorylistList == null
                            ? Center(child: Text('Empty'))
                            : ListView.builder(
                                shrinkWrap: true,
                                padding: EdgeInsets.fromLTRB(15, 15, 15, 5),
                                itemCount: inventorylistList.length,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder:
                                    (BuildContext context, int index) =>
                                        _buildListview(
                                            context, inventorylistList[index]),
                              )
                      ],
                    ),
                  ],
                ),
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
                                Routes.navigate(context, Page3());
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
                                // if (_formKey.currentState.validate()) {
                                //   _apiAddRestaurantStep1();
                                // }
                                SharedPrefManager.setString(
                                    keynooftables, _nooftables);
                                SharedPrefManager.setString(
                                    keyminposition, _minposition);
                                SharedPrefManager.setString(
                                    keymaxposition, _maxposition);
                                SharedPrefManager.setString(
                                    keyesttime, _esttime);
                                SharedPrefManager.setBool(
                                    keystatuspage4, isTablestatus);

                                List<String> newtabletypelist = [];
                                for (int i = 0;
                                    i < tableTypestringList.length;
                                    i++) {
                                  if (temptabletype
                                      .contains(tableTypestringList[i])) {
                                    newtabletypelist
                                        .add(tableTypestringList[i]);
                                  }
                                } // ! pass the value tableype newtabletypelist
                                // ! create table index {sum}
                                for (num e in nooftablelist) {
                                  sum += e;
                                }
                                print(sum.toString());
                                print(nooftablelist.toString());

                                Routes.navigate(
                                    context,
                                    Page5(
                                      newtabletypelist: newtabletypelist,
                                      sum: sum,
                                    ));
                              },
                              color: Colors.white),
                        )),
                  )
                ],
              ),
            )));
  }

  void _apiGetTableTypeListName() async {
    if (await Common.isNetworkAvailable()) {
      Request request = Request(urlGetTableTypeListName, {});
      request.post().then((result) {
        setState(() {
          var rest = result.data['TableTypeList'] as List;
          tableTypeList = rest
              .map<TableTypeList>((json) => TableTypeList.fromJson(json))
              .toList();

          for (int i = 0; i < tableTypeList.length; i++) {
            tableTypestringList.add(tableTypeList[i].tableType);
          }
        });
      }).catchError((error) {});
    }
  }

  void _apiGetInventorylist() async {
    if (await Common.isNetworkAvailable()) {
      Future.delayed(Duration.zero, () => Common.dialogLoader(context));
      var data = {
        "step": 4,
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
        "IsMonday": "",
        "MonStart": "",
        "MonEnd": "",
        "IsTuesday": "",
        "TueStart": "",
        "TueEnd": "",
        "IsWednesday": "",
        "WedStart": "",
        "WedEnd": "",
        "IsThursday": "",
        "ThuStart": "",
        "ThuEnd": "",
        "IsFriday": "",
        "FriStart": "",
        "FriEnd": "",
        "IsSaturday": "",
        "SatStart": "",
        "SatEnd": "",
        "IsSunday": "",
        "SunStart": "",
        "SunEnd": "",
        "TableTypeInventory": _tableTypeInventory,
        "NoOfTable": _nooftables,
        "MinPosition": _minposition,
        "MaxPosition": _maxposition,
        "EstTime": _esttime,
        "InventoryStatus": isTablestatus.toString(),
        "TableNo": "",
        "TableTypeFetch": "",
        "TableView": "",
        "Status": ""
      };
      Request request = Request(urlAddRestaurant, data);
      request.post().then((result) {
        Navigator.pop(context);
        TableInventorylist tableResponse =
            TableInventorylist.fromJson(result.data);
        setState(() => inventorylistList = tableResponse.addRestaurantResult);

        for (int i = 0; i < inventorylistList.length; i++) {
          temptabletype.add(inventorylistList[i].tableType);
          nooftablelist.add(inventorylistList[i].noOfTables);
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

  Widget _buildListview(
      BuildContext context, AddRestaurantResult inventorylistList) {
    return GestureDetector(
      child: Container(
        color: Colors.grey,
        child: Container(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
          margin: new EdgeInsets.fromLTRB(0, 0.5, 0, 0.5),
          color: Colors.grey[200],
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 3, 0, 3),
                      child: Text(
                        "TABLE TYPE : " + inventorylistList.tableType,
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 3, 0, 3),
                      child: Text(
                        "MIN POSITION : " +
                            inventorylistList.minPosition.toString(),
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 3, 0, 3),
                      child: Text(
                        "EST TIME : " +
                            inventorylistList.estimatedTime.toString(),
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 3, 0, 3),
                            child: Text(
                              "NO OF TABLES : " +
                                  inventorylistList.noOfTables.toString(),
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 13),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 3, 0, 3),
                            child: Text(
                              "MAX POSITION : " +
                                  inventorylistList.maxPosition.toString(),
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 13),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 3, 0, 3),
                            child: Text(
                              "STATUS : " +
                                  inventorylistList.isActive.toString(),
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
              SizedBox(
                width: 5,
              ),
              Expanded(
                flex: 1,
                child: Image.asset(
                  'assets/pencil.png',
                  width: 17,
                  height: 17,
                  color: Colors.deepPurple[300],
                ),
              )
            ],
          ),
        ),
      ),
    );
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

//  var rest = result.data['inventorylist'] as List;
//        inventorylistList = rest.map<Inventorylist>((json) => Inventorylist.fromJson(json))
//               .toList();

}
