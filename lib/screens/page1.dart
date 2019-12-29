import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant/data/drawer/drawer_data.dart';
import 'package:restaurant/http/request.dart';
import 'package:restaurant/http/urls.dart';
import 'package:restaurant/pojo/restaurentname_response.dart';
import 'package:restaurant/pojo/restcat_response.dart';
import 'package:restaurant/res/color.dart';
import 'package:restaurant/res/string.dart';
import 'package:restaurant/screens/dashboard.dart';
import 'package:restaurant/screens/login1.dart';
import 'package:restaurant/screens/manager_history.dart';
import 'package:restaurant/screens/page2.dart';
import 'package:restaurant/util/common.dart';
import 'package:restaurant/util/routes.dart';
import 'package:restaurant/util/shared_pref_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Page1 extends StatefulWidget {
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  TextEditingController _restBranchNameController = TextEditingController();
// ? pending cat value
  TextEditingController _address1Controller = TextEditingController();
  TextEditingController _address2Controller = TextEditingController();
  TextEditingController _firstnmController = TextEditingController();
  TextEditingController _lastnmController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _landlineController = TextEditingController();
  TextEditingController _mobilenoController = TextEditingController();
  TextEditingController _assignController = TextEditingController();

  List<String> _foodTypes = ['Veg', 'Non veg']; // Option 2
  String _selectedFoodtype; // Op
  String _selectedTimeZone;
  bool isStatusSwitched= false;
  final _formKey = GlobalKey<FormState>();
  RestaurantListResponse restNameResponse;
  List<RestCategoryList> restCat = [];
  List<String> timeZonelist;
  String _branchName;
  String _address1;
  String _address2;
  String _firstnm;
  String _lastnm;
  String _emailaddress;
  String _landlinenumber;
  String _mobnumber;
  String _assignuser;
  int _selectedCategoryid;
  RestCategoryList _selectedCategory;
String _fullname= "";
  String  _branchname="";
  @override
  initState() {
    //_apiGetRestName();
    _assignValue();
    _apiGetRestCategory();
    _apiTimeZoneList();

    super.initState();
  }

  void _assignValue() async {
  _fullname = await SharedPrefManager.getString(keyfirstname) +
        " " +
        await SharedPrefManager.getString(keylastname);
    _branchname = await SharedPrefManager.getString(keyBranchName);
      isStatusSwitched = await SharedPrefManager.getBool(keyisstatuspage1);
    

    _restBranchNameController.text =
        await SharedPrefManager.getString(keybranchname);
    _address1Controller.text = await SharedPrefManager.getString(keyaddress1);
    _address2Controller.text = await SharedPrefManager.getString(keyaddress2);
    _firstnmController.text = await SharedPrefManager.getString(keyfirstnm);
    _lastnmController.text = await SharedPrefManager.getString(keylastnm);
    _emailController.text = await SharedPrefManager.getString(keyemailaddress);
    _landlineController.text =
        await SharedPrefManager.getString(keylandlinenumber);
    _mobilenoController.text = await SharedPrefManager.getString(keymobnumber);
    _assignController.text = await SharedPrefManager.getString(keyassignuser);

    _branchName = _restBranchNameController.text;
    _address1 = _address1Controller.text;
    _address2 = _address2Controller.text;
    _firstnm = _firstnmController.text;
    _lastnm = _lastnmController.text;
    _emailaddress = _emailController.text;
    _landlinenumber = _landlineController.text;
    _mobnumber = _mobilenoController.text;
    _assignuser = _assignController.text;
  }

  Future<bool> backPress() {
    Routes.navigateRemoveUntil(context, Dashboard());
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
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
                                        color: Colors.grey,
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
                        padding: EdgeInsets.fromLTRB(15, 15, 15, 5),
                        child: Text(
                          "BRANCH NAME",
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                      ),
                      Container(
                        color: Colors.grey[200],
                        padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                        child: TextFormField(
                          controller: _restBranchNameController,
                          onChanged: (value) => _branchName = value,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Branch name required';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.sentences,
                          autofocus: false,
                          style: new TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0.0)),
                          ),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.fromLTRB(15, 15, 15, 5),
                          color: Colors.grey[200],
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    color: Colors.grey[200],
                                    child: Text(
                                      "RESTAURANT CATEGORY",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 13),
                                    ),
                                  ),
                                  Container(
                                    color: Colors.grey[200],
                                    child: new DropdownButton(
                                      hint: Text('Select'),
                                      value: _selectedCategory,
                                      onChanged: (newValue) {
                                        setState(() {
                                          _selectedCategory = newValue;
                                          _selectedCategoryid =
                                              _selectedCategory.id;
                                          Common.toast(context,
                                              _selectedCategoryid.toString());
                                        });
                                      },
                                      items: restCat?.map((rest) {
                                            return new DropdownMenuItem(
                                              value: rest,
                                              child: new Text(
                                                rest.category,
                                                style: new TextStyle(
                                                    color: Colors.black),
                                              ),
                                            );
                                          })?.toList() ??
                                          [],
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Container(
                                    color: Colors.grey[200],
                                    child: Text(
                                      "FOOD TYPE",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 13),
                                    ),
                                  ),
                                  Container(
                                    color: Colors.grey[200],
                                    child: DropdownButton(
                                      hint: Text(
                                          'Select'), // Not necessary for Option 1
                                      value: _selectedFoodtype,
                                      onChanged: (newValue) {
                                        setState(() {
                                          _selectedFoodtype = newValue;
                                        });
                                      },
                                      items: _foodTypes?.map((foodtype) {
                                            return DropdownMenuItem(
                                              child: new Text(foodtype),
                                              value: foodtype,
                                            );
                                          })?.toList() ??
                                          [],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Container(
                        padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                        color: Colors.grey[200],
                        child: Text(
                          "TIME ZONE",
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                        color: Colors.grey[200],
                        child: DropdownButton(
                          isExpanded: true,
                          hint: Text('Select'), // Not necessary for Option 1
                          value: _selectedTimeZone,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedTimeZone = newValue;
                            });
                          },
                          items: timeZonelist?.map((timezone) {
                                return DropdownMenuItem(
                                  child: new Text(timezone),
                                  value: timezone,
                                );
                              })?.toList() ??
                              [],
                        ),
                      ),
                      Container(
                        color: Colors.grey[200],
                        padding: EdgeInsets.fromLTRB(15, 15, 15, 5),
                        child: Text(
                          "GOOGLE ADDRESS",
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                      ),
                      Container(
                        color: Colors.grey[200],
                        padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                        child: TextFormField(
                          textCapitalization: TextCapitalization.sentences,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          autofocus: false,
                          controller: _address1Controller,
                          onChanged: (value) => _address1 = value,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Google address required';
                            }
                            return null;
                          },
                          style: new TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0.0)),
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.grey[200],
                        padding: EdgeInsets.fromLTRB(15, 15, 15, 5),
                        child: Text(
                          "LANDMARK",
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                      ),
                      Container(
                        color: Colors.grey[200],
                        width: 50.0,
                        padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                        child: TextFormField(
                          textCapitalization: TextCapitalization.sentences,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          autofocus: false,
                          controller: _address2Controller,
                          onChanged: (value) => _address2 = value,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Landmark address required';
                            }
                            return null;
                          },
                          style: new TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0.0)),
                          ),
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
                                    padding: EdgeInsets.fromLTRB(15, 15, 15, 5),
                                    child: Text(
                                      "FIRST NAME",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 13),
                                    ),
                                  ),
                                  Container(
                                    color: Colors.grey[200],
                                    padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                                    child: TextFormField(
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                      textInputAction: TextInputAction.next,
                                      controller: _firstnmController,
                                      keyboardType: TextInputType.text,
                                      autofocus: false,
                                      onChanged: (value) => _firstnm = value,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'First name required';
                                        }
                                        return null;
                                      },
                                      style: new TextStyle(
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black),
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(
                                            10.0, 10.0, 10.0, 10.0),
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
                                    padding: EdgeInsets.fromLTRB(15, 15, 15, 5),
                                    child: Text(
                                      "LAST NAME",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 13),
                                    ),
                                  ),
                                  Container(
                                    color: Colors.grey[200],
                                    padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.text,
                                      controller: _lastnmController,
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                      autofocus: false,
                                      onChanged: (value) => _lastnm = value,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Last name required';
                                        }
                                        return null;
                                      },
                                      style: new TextStyle(
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black),
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(
                                            10.0, 10.0, 10.0, 10.0),
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
                        padding: EdgeInsets.fromLTRB(15, 15, 15, 5),
                        child: Text(
                          "EMAIL ID",
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                      ),
                      Container(
                        color: Colors.grey[200],
                        padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                        child: TextFormField(
                          textCapitalization: TextCapitalization.none,
                          textInputAction: TextInputAction.next,
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          autofocus: false,
                          onChanged: (value) => _emailaddress = value,
                          validator: (value) {
                            if (value.isEmpty ||
                                !RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value)) {
                              return 'Enter valid email address.';
                            }
                            return null;
                          },
                          style: new TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0.0)),
                          ),
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
                                    padding: EdgeInsets.fromLTRB(15, 15, 15, 5),
                                    child: Text(
                                      "LANDLINE NO",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 13),
                                    ),
                                  ),
                                  Container(
                                    color: Colors.grey[200],
                                    padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.number,
                                      autofocus: false,
                                      controller: _landlineController,
                                      onChanged: (value) =>
                                          _landlinenumber = value,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Landline no. required';
                                        }
                                        return null;
                                      },
                                      style: new TextStyle(
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black),
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(
                                            10.0, 10.0, 10.0, 10.0),
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
                                    padding: EdgeInsets.fromLTRB(15, 15, 15, 5),
                                    child: Text(
                                      "MOBILE NUMBER",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 13),
                                    ),
                                  ),
                                  Container(
                                    color: Colors.grey[200],
                                    padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.number,
                                      autofocus: false,
                                      controller: _mobilenoController,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(10),
                                      ],
                                      onChanged: (value) => _mobnumber = value,
                                      validator: (value) {
                                        if (_mobnumber.trim().length < 10) {
                                          return 'Mobile no. required';
                                        }
                                        return null;
                                      },
                                      style: new TextStyle(
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black),
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(
                                            10.0, 10.0, 10.0, 10.0),
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
                        padding: EdgeInsets.fromLTRB(15, 15, 15, 5),
                        child: Text(
                          "ASSIGN USER",
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                      ),
                      Container(
                        color: Colors.grey[200],
                        padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          autofocus: false,
                          controller: _assignController,
                          onChanged: (value) => _assignuser = value,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Assign user required';
                            }
                            return null;
                          },
                          style: new TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0.0)),
                          ),
                        ),
                      ),
                      Container(
                          color: Colors.grey[200],
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 6,
                                child: Container(
                                  color: Colors.grey[200],
                                  padding: EdgeInsets.fromLTRB(15, 15, 15, 25),
                                  child: Text(
                                    "STATUS",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 13),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  color: Colors.grey[200],
                                  child: Switch(
                                    value: isStatusSwitched,
                                    onChanged: (value) {
                                      setState(() {
                                        isStatusSwitched = value;
                                      });
                                    },
                                    activeTrackColor: Colors.blue,
                                    activeColor: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ))
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
                      child: Container(child: Container())),
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
                            onPressed: () async {
                              // if (_formKey.currentState.validate()) {
                              //   _apiAddRestaurantStep1();
                              // }
                              SharedPrefManager.setString(
                                  keybranchname, _branchName);
                              SharedPrefManager.setString(
                                  keyaddress1, _address1);
                              SharedPrefManager.setString(
                                  keyaddress2, _address2);
                              SharedPrefManager.setString(keyfirstnm, _firstnm);
                              SharedPrefManager.setString(keylastnm, _lastnm);
                              SharedPrefManager.setString(
                                  keyemailaddress, _emailaddress);
                              SharedPrefManager.setString(
                                  keylandlinenumber, _landlinenumber);
                              SharedPrefManager.setString(
                                  keymobnumber, _mobnumber);
                              SharedPrefManager.setString(
                                  keyassignuser, _assignuser);
                              SharedPrefManager.setBool(
                                  keyisstatuspage1, isStatusSwitched);
                              Routes.navigateRemoveUntil(context, Page2());
                            },
                            color: Colors.white),
                      )),
                )
              ],
            ),
          )),
    );
  }

  void _apiGetRestCategory() async {
    if (await Common.isNetworkAvailable()) {
      Request request = Request(urlGetRestCategoryListName, {});
      request.post().then((result) {
        setState(() {
          var rest = result.data['RestCategoryList'] as List;
          restCat = rest
              .map<RestCategoryList>((json) => RestCategoryList.fromJson(json))
              .toList();
        });
      }).catchError((error) {});
    }
  }

  void _apiTimeZoneList() async {
    if (await Common.isNetworkAvailable()) {
      Request request = Request(urlGetTimeZoneListName, {});
      request.post().then((result) {
        setState(() {
          var streetsFromJson = result.data['TimeZoneName'];
          timeZonelist = new List<String>.from(streetsFromJson);
        });
      }).catchError((error) {});
    }
  }

  void _apiAddRestaurantStep1() async {
    if (await Common.isNetworkAvailable()) {
      Future.delayed(Duration.zero, () => Common.dialogLoader(context));
      int _branchid;
      if (await SharedPrefManager.getString(keyBranchId) == "") {
        _branchid = 0;
      } else {
        _branchid = int.parse(await SharedPrefManager.getString(
            keyBranchId)); //! when update to set id
      }

      var data = {
        "step": 1,
        "BranchId": _branchid,
        "HotelierId": int.parse(await SharedPrefManager.getString(keyRestId)),
        "RestCategoryId": _selectedCategoryid,
        "RestName": _branchName,
        "FoodType": _selectedFoodtype,
        "TimeZoneName": _selectedTimeZone,
        "Address1": _address1,
        "Address2": _address2,
        "Latitude": "",
        "Longitude": "",
        "FirstName": _firstnm,
        "LastName": _lastnm,
        "Email": _emailaddress,
        "Landline": _landlinenumber,
        "Mobile": _mobnumber,
        "AssignUser": _assignuser,
        "IsActive": isStatusSwitched.toString(),
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
        Common.toast(
            context, result.data['AddRestaurantResult']['BranchId'].toString());
        SharedPrefManager.setString(keyBranchId,
            result.data['AddRestaurantResult']['BranchId'].toString());
        if (result.data['AddRestaurantResult']['BranchId'].toString() != "") {
          SharedPrefManager.setString(keyBranchId,
              result.data['AddRestaurantResult']['BranchId'].toString());
          Routes.navigate(context, Page2());
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
