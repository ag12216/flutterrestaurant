import 'package:flutter/material.dart';
import 'package:restaurant/data/drawer/drawer_data.dart';
import 'package:restaurant/res/color.dart';
import 'package:restaurant/screens/Page6.dart';
import 'package:restaurant/screens/dashboard.dart';
import 'package:restaurant/screens/login.dart';
import 'package:restaurant/screens/login1.dart';
import 'package:restaurant/screens/manager_history.dart';
import 'package:restaurant/screens/page1.dart';
import 'package:restaurant/util/routes.dart';
import 'package:restaurant/util/shared_pref_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Page7 extends StatefulWidget {
  @override
  _Page7State createState() => _Page7State();
}

class _Page7State extends State<Page7> {
  final _formKey = GlobalKey<FormState>();
  String _offername,
      _refundamount,
      _cancelcharge,
      _canceltime,
      _admincharges,
      _timeslot,
      _estcostfor2;
  bool freewifi = false;
  bool kidszone = false;
  bool cardaccept = false;
  bool outdootseating = false;
  List<String> _locations = ['Rs 100', 'Rs 200', 'Rs 300']; // Option 2
  String _selectedLocation;

  String _fullname= "";
  String  _branchname="";
@override
  void initState() {
     _assignValue();
    super.initState();
  }
  Future<bool> backPress() {
    Routes.navigateRemoveUntil(context, Page6());
    return Future.value(false);
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
                                          color: Colors.deepOrangeAccent,
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
                            "OFFER NAME",
                            style: TextStyle(color: Colors.grey, fontSize: 13),
                          ),
                        ),
                        Container(
                          color: Colors.grey[200],
                          padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            autofocus: false,
                            onChanged: (value) => _offername = value,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Offer name required';
                              }
                              return null;
                            },
                            style: new TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.grey),
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(0.0)),
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.grey[200],
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                        "REFUND AMOUNT",
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 13),
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.fromLTRB(15, 0, 15, 0),
                                      color: Colors.grey[200],
                                      child: DropdownButton(
                                        isExpanded: true,
                                        hint: Text(
                                            'Select'), // Not necessary for Option 1
                                        value: _selectedLocation,
                                        onChanged: (newValue) {
                                          setState(() {
                                            _selectedLocation = newValue;
                                          });
                                        },
                                        items: _locations.map((location) {
                                          return DropdownMenuItem(
                                            child: new Text(location),
                                            value: location,
                                          );
                                        }).toList(),
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
                                        "CANCELLATION CHGS (%)",
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
                                        autofocus: false,
                                        onChanged: (value) =>
                                            _cancelcharge = value,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Cancellation CHGS required';
                                          }
                                          return null;
                                        },
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
                                        "CANCELLATION TIME (MINS)",
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
                                        autofocus: false,
                                        onChanged: (value) =>
                                            _canceltime = value,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Cancellation time required';
                                          }
                                          return null;
                                        },
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
                                        "ADMIN CHARGES",
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 13),
                                      ),
                                    ),
                                    Container(
                                      color: Colors.grey[200],
                                      padding:
                                          EdgeInsets.fromLTRB(15, 5, 15, 5),
                                      child: TextFormField(
                                        keyboardType: TextInputType.text,
                                        autofocus: false,
                                        onChanged: (value) =>
                                            _admincharges = value,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Admin charges required';
                                          }
                                          return null;
                                        },
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
                                        "TIME SLOT",
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 13),
                                      ),
                                    ),
                                    Container(
                                      color: Colors.grey[200],
                                      padding:
                                          EdgeInsets.fromLTRB(15, 5, 15, 5),
                                      child: TextFormField(
                                        keyboardType: TextInputType.text,
                                        autofocus: false,
                                        onChanged: (value) => _timeslot = value,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Time slot required';
                                          }
                                          return null;
                                        },
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
                                        "EST COST FOR 2",
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 13),
                                      ),
                                    ),
                                    Container(
                                      color: Colors.grey[200],
                                      padding:
                                          EdgeInsets.fromLTRB(15, 5, 15, 5),
                                      child: TextFormField(
                                        keyboardType: TextInputType.text,
                                        autofocus: false,
                                        onChanged: (value) =>
                                            _estcostfor2 = value,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Est cost for 2 required';
                                          }
                                          return null;
                                        },
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
                          padding: EdgeInsets.fromLTRB(15, 15, 15, 5),
                          child: Text(
                            "LABEL TYPE",
                            style: TextStyle(color: Colors.grey, fontSize: 13),
                          ),
                        ),
                        Container(
                            color: Colors.grey[200],
                            padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Checkbox(
                                          value: freewifi,
                                          onChanged: (bool value) {
                                            setState(() {
                                              freewifi = value;
                                            });
                                          },
                                        ),
                                        Text(
                                          "Free WIFI",
                                          style: TextStyle(fontSize: 13),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Checkbox(
                                          value: cardaccept,
                                          onChanged: (bool value) {
                                            setState(() {
                                              cardaccept = value;
                                            });
                                          },
                                        ),
                                        Text(
                                          "Card Accept",
                                          style: TextStyle(fontSize: 13),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Checkbox(
                                          value: kidszone,
                                          onChanged: (bool value) {
                                            setState(() {
                                              kidszone = value;
                                            });
                                          },
                                        ),
                                        Text(
                                          "Kids Zone",
                                          style: TextStyle(fontSize: 13),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Checkbox(
                                          value: outdootseating,
                                          onChanged: (bool value) {
                                            setState(() {
                                              outdootseating = value;
                                            });
                                          },
                                        ),
                                        Text(
                                          "Outdoot Seating",
                                          style: TextStyle(fontSize: 13),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
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
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        Page6()));
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
                                "FINISH",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                ),
                              ),
                              onPressed: () {
                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (BuildContext context) => Page6()));
                              },
                              color: Colors.white),
                        )),
                  )
                ],
              ),
            )));
  }

// void _apiAddRestaurantStep1() async {
//     if (await Common.isNetworkAvailable()) {
//       Future.delayed(Duration.zero, () => Common.dialogLoader(context));
//       if (await SharedPrefManager.getString(keyBranchId) != "") {
//         //   int _refreshbranchid = int.parse(await SharedPrefManager.getString(keyBranchId)); //! when update to set id
//       }

//       var data = {
//         "step": 1,
//         "BranchId": 23,
//         "HotelierId": 1,
//         "RestCategoryId": _selectedCategoryid,
//         "RestName": _branchName,
//         "FoodType": _selectedFoodtype,
//         "TimeZoneName": _selectedTimeZone,
//         "Address1": _address1,
//         "Address2": _address2,
//         "Latitude": "",
//         "Longitude": "",
//         "FirstName": _firstnm,
//         "LastName": _lastnm,
//         "Email": _emailaddress,
//         "Landline": _landlinenumber,
//         "Mobile": _mobnumber,
//         "AssignUser": _assignuser,
//         "IsActive": isStatusSwitched.toString(),
//         "IsMonday": "",
//         "MonStart": "",
//         "MonEnd": "",
//         "IsTuesday": "",
//         "TueStart": "",
//         "TueEnd": "",
//         "IsWednesday": "",
//         "WedStart": "",
//         "WedEnd": "",
//         "IsThursday": "",
//         "ThuStart": "",
//         "ThuEnd": "",
//         "IsFriday": "",
//         "FriStart": "",
//         "FriEnd": "",
//         "IsSaturday": "",
//         "SatStart": "",
//         "SatEnd": "",
//         "IsSunday": "",
//         "SunStart": "",
//         "SunEnd": "",
//         "TableTypeInventory": "",
//         "NoOfTable": "",
//         "MinPosition": "",
//         "MaxPosition": "",
//         "EstTime": "",
//         "InventoryStatus": "",
//         "TableNo": "",
//         "TableTypeFetch": "",
//         "TableView": "",
//         "Status": ""
//       };
//       Request request = Request(urlAddRestaurant, data);
//       request.post().then((result) {
//         Navigator.pop(context);
//         Common.toast(
//             context, result.data['AddRestaurantResult']['BranchId'].toString());
//         SharedPrefManager.setString(keyBranchId,
//             result.data['AddRestaurantResult']['BranchId'].toString());
//         if (result.data['AddRestaurantResult']['BranchId'].toString() != "") {
//           Routes.navigate(context, Page2());
//         }
//       }).catchError((error) {
//         Common.toast(context, wrongMsg);
//         Navigator.pop(context);
//       });
//     } else {
//       Navigator.pop(context);
//       Common.toast(context, noInternetMsg);
//     }
//   }
  
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
