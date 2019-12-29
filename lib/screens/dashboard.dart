import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:restaurant/data/drawer/drawer_data.dart';
import 'package:restaurant/http/request.dart';
import 'package:restaurant/http/urls.dart';
import 'package:restaurant/pojo/adminOverviewScreenFilter_response.dart';
import 'package:restaurant/pojo/adminOverviewScreen_response.dart';
import 'package:restaurant/res/color.dart';
import 'package:restaurant/res/string.dart';
import 'package:restaurant/screens/analytics_screen.dart';
import 'package:restaurant/screens/login1.dart';
import 'package:restaurant/screens/manager_history.dart';
import 'package:restaurant/screens/page1.dart';
import 'package:restaurant/util/common.dart';
import 'package:restaurant/util/routes.dart';
import 'package:restaurant/util/shared_pref_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  DateTime currentBackPressTime;

  List<Hoteldetailslist> hoteldetailslist = [];
  List<Hoteldetailslist1> overviewList = [];
  List<InventoryList> inventrylist = [];
  List<TimeSlotList> timesslot = [];
  List<BookingListDemo> bookingList = [];
  String _totalPosition = "";
  String _bookedPosition = "";
  String _vacantPosition = "";
  String _adminBlocked = "";

  int _value = 0; // chip 1
  int _value1 = 0; //chip 2
  String _selectType;
  String _selectView;

  String _selectTimeSlot;
  String _fullname = "";
  String _branchname = "";
  String _restname = "";
  String _profileimage = "";
  int _selectedIndex = 0;

  _onSelected(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  void initState() {
    _pref();
    _apiAdminOverviewScreenFilter();
    super.initState();
  }

  void _pref() async {
    _fullname = await SharedPrefManager.getString(keyfirstname) +
        " " +
        await SharedPrefManager.getString(keylastname);
    _branchname = await SharedPrefManager.getString(keyBranchName);
    _restname = await SharedPrefManager.getString(keyRestName);
    _profileimage = await SharedPrefManager.getString(keyProfileImage);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
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
                      Container(
                        child: CircleAvatar(
                          backgroundColor: Colors.deepOrangeAccent,
                          child: ClipRRect(
                            borderRadius: new BorderRadius.circular(20),
                            child: CachedNetworkImage(
                                imageUrl:
                                    _profileimage,
                                placeholder: (context, url) => Image.asset(
                                      'assets/nvuser.png',
                                      width: 35,
                                      height: 35,
                                      color: Colors.white,
                                    ),
                                // errorWidget: (context, url, error) => new Icon(Icons.error),
                                fit: BoxFit.fill),
                          ),
                          foregroundColor: Colors.white,
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
                            style: TextStyle(fontSize: 13, color: Colors.white),
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
              _restname.toUpperCase(),
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
          body: ListView(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(5.0),
                color: Colors.deepOrangeAccent,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 12.0,
                    children: List<Widget>.generate(
                      inventrylist.length,
                      (int _selectIndex) {
                        return ChoiceChip(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(5),
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5),
                                  bottomRight: Radius.circular(5))),
                          backgroundColor: Colors.black.withOpacity(0.7),
                          pressElevation: 0.0,
                          selectedColor: Colors.white,
                          label: Text(
                            inventrylist[_selectIndex].tableType +
                                " " +
                                inventrylist[_selectIndex].tableView,
                            style: TextStyle(
                                fontSize: 11, color: Colors.deepOrangeAccent),
                          ),
                          selected: _value == _selectIndex,
                          onSelected: (bool selected) {
                            setState(() {
                              //! if branch id declr then add brid
                              _value = selected ? _selectIndex : null;
                              _selectType =
                                  inventrylist[_selectIndex].tableType;
                              _selectView =
                                  inventrylist[_selectIndex].tableView;
                              String _selectTypewithview =
                                  inventrylist[_selectIndex].tableType +
                                      " " +
                                      inventrylist[_selectIndex]
                                          .tableView
                                          .toString();
                              _apiAdminOverviewScreenFilter();

                              timesslot =
                                  inventrylist[_selectIndex].timeSlotList;
                            });
                          },
                        );
                      },
                    ).toList(),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                color: Colors.deepOrangeAccent,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 12.0,
                    children: List<Widget>.generate(
                      timesslot.length,
                      (int index) {
                        return ChoiceChip(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(5),
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5),
                                  bottomRight: Radius.circular(5))),
                          backgroundColor: Colors.black.withOpacity(0.7),
                          pressElevation: 0.0,
                          selectedColor: Colors.white,
                          label: Text(
                            timesslot[index].timeSlotShow,
                            style: TextStyle(
                                fontSize: 11, color: Colors.deepOrangeAccent),
                          ),
                          selected: _value1 == index,
                          onSelected: (bool selected) {
                            setState(() {
                              _value1 = selected ? index : null;
                              _selectTimeSlot = timesslot[index].timeSlot;
                              _apiAdminOverviewScreenFilter();
                            });
                          },
                        );
                      },
                    ).toList(),
                  ),
                ),
              ),
              Container(
                  color: Colors.deepOrangeAccent,
                  padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            child: Text(
                              "TOTAL \n POSITION",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 11),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 2, 0, 15),
                            child: Text(
                              _totalPosition,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            child: Text(
                              "BOOKED \n POSITION",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 11),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 2, 0, 15),
                            child: Text(
                              _bookedPosition,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            child: Text(
                              "VACANT \n POSITION",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 11),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 2, 0, 15),
                            child: Text(
                              _vacantPosition,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            child: Text(
                              "ADMIN \n BLOCKED",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 11),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 2, 0, 15),
                            child: Text(
                              _adminBlocked,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
              ListView.builder(
                shrinkWrap: true,
                itemCount: bookingList.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    child: Slidable(
                        key: ValueKey(index),
                        actionPane: SlidableDrawerActionPane(),
                        secondaryActions: <Widget>[
                          bookingList[index].userId != 0 &&
                                  bookingList[index].status == "1"
                              ? IconSlideAction(
                                  caption: 'CHECK OUT',
                                  color: Colors.green,
                                  icon: Icons.check,
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (_) => AlertDialog(
                                              title: Text("Confirmation!"),
                                              content: const Text(
                                                  'Are you sure you want to check out?'),
                                              actions: <Widget>[
                                                FlatButton(
                                                  child: const Text('No'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                FlatButton(
                                                  child: const Text('Yes'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                    _apiUpdateBookingStatus(
                                                        bookingList[index]
                                                            .bookingId,
                                                        bookingList[index]
                                                            .branchId);
                                                  },
                                                )
                                              ],
                                            ));
                                  },
                                )
                              : bookingList[index].userId == 0 &&
                                      bookingList[index].status == "1"
                                  ? IconSlideAction(
                                      caption: 'UNBLOCK',
                                      color: Colors.blue,
                                      icon: Icons.block,
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (_) => AlertDialog(
                                                  title: Text("Confirmation!"),
                                                  content: const Text(
                                                      'Are you sure you want to unblock?'),
                                                  actions: <Widget>[
                                                    FlatButton(
                                                      child: const Text('No'),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                    FlatButton(
                                                      child: const Text('Yes'),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                        _apiUnblockBookingByAdmin(
                                                          bookingList[index]
                                                              .bookingId,
                                                          bookingList[index]
                                                              .branchId,
                                                        );
                                                      },
                                                    )
                                                  ],
                                                ));
                                      },
                                    )
                                  : IconSlideAction(
                                      caption: 'BLOCK',
                                      color: Colors.blue,
                                      icon: Icons.block,
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (_) => AlertDialog(
                                                  title: Text("Confirmation!"),
                                                  content: const Text(
                                                      'Are you sure you want to block?'),
                                                  actions: <Widget>[
                                                    FlatButton(
                                                      child: const Text('No'),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                    FlatButton(
                                                      child: const Text('Yes'),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                        _apiBookTableByAdmin(
                                                            bookingList[index]
                                                                .userId,
                                                            bookingList[index]
                                                                .branchId,
                                                            bookingList[index]
                                                                .tableViewId,
                                                            bookingList[index]
                                                                .noOfPeople,
                                                            bookingList[index]
                                                                .selectedDate,
                                                            bookingList[index]
                                                                .timeSlotLast,
                                                            bookingList[index]
                                                                .rates);
                                                      },
                                                    )
                                                  ],
                                                ));
                                      },
                                    ),
                        ],
                        child: Container(
                            height: 80,
                            margin: new EdgeInsets.all(0.5),
                            color: bookingList[index].userId == 0 &&
                                    bookingList[index].status == "1"
                                //  _selectedIndex != null &&
                                //   _selectedIndex == index
                                ? Colors.yellow[300]
                                : Colors.white,
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  child: CircleAvatar(
                                    child: ClipRRect(
                                      borderRadius:
                                          new BorderRadius.circular(20),
                                      child: CachedNetworkImage(
                                          imageUrl:
                                              bookingList[index].profilePic,
                                          placeholder: (context, url) =>
                                              Image.asset('assets/user.png',
                                                  width: 100, height: 50),
                                          // errorWidget: (context, url, error) => new Icon(Icons.error),
                                          fit: BoxFit.fill),
                                    ),
                                    foregroundColor: Colors.white,
                                  ),
                                ),
                                Container(
                                    height: 100,
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(5, 2, 0, 0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Expanded(
                                            flex: 2,
                                            child: _status(
                                                bookingList[index].userId,
                                                bookingList[index].status,
                                                bookingList[index].firstName,
                                                bookingList[index].lastName),
                                          ),
                                          Expanded(
                                            child: Container(
                                              width: 150,
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 3, 0, 0),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Expanded(
                                                    child: new Icon(
                                                      Icons.watch_later,
                                                      size: 15,
                                                    ),
                                                    flex: 1,
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      "Est. Time: " +
                                                          bookingList[index]
                                                              .timeSlotLastShow,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12),
                                                    ),
                                                    flex: 5,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            flex: 2,
                                          ),
                                          Expanded(
                                              flex: 2,
                                              child: Container(
                                                width: 150,
                                                padding: EdgeInsets.fromLTRB(
                                                    0, 3, 0, 0),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: new Icon(
                                                        Icons.people,
                                                        size: 15,
                                                      ),
                                                      flex: 1,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        bookingList[index]
                                                                .noOfPeople
                                                                .toString() +
                                                            " People(s)",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 12),
                                                      ),
                                                      flex: 5,
                                                    ),
                                                  ],
                                                ),
                                              )),
                                        ],
                                      ),
                                    )),
                                Container(
                                    padding: EdgeInsets.fromLTRB(3, 2, 0, 0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Container(
                                          child: Text(
                                            "USD",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          child: Text(
                                            bookingList[index].rates.toString(),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                        ),
                                      ],
                                    )),
                                Container(
                                    padding: EdgeInsets.fromLTRB(10, 2, 0, 0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Container(
                                          child: Text(
                                            "Position",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          child: Text(
                                            bookingList[index]
                                                .position
                                                .toString(),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                        ),
                                      ],
                                    )),
                                Container(
                                    child: new Icon(
                                  Icons.chevron_right,
                                  size: 25,
                                ))
                              ],
                            ))),
                    onTap: () => _onSelected(index),
                  );
                },
              )
            ],
          )),
    );
  }

  _status(int userId, String status, String firstname, String lastname) {
    if (userId == 0 && status == "1") {
      return Text(
        'Block by admin',
        style: TextStyle(
            color: Colors.black, fontStyle: FontStyle.italic, fontSize: 11),
      );
    } else if (userId == 0 && status == "0") {
      return Text(
        'Booking available',
        style: TextStyle(
            color: Colors.deepOrangeAccent,
            fontStyle: FontStyle.italic,
            fontSize: 11),
      );
    } else {
      return Text(
        firstname.replaceAll("\r\n", " ") +
            " " +
            lastname.replaceAll("\r\n", " "),
        style: TextStyle(
            color: Colors.deepOrangeAccent,
            fontStyle: FontStyle.italic,
            fontSize: 11),
      );
    }
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Common.toast(context, 'Press again to exit');
      return Future.value(false);
    }
    return Future.value(true);
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
      case 'analytics':
        Routes.navigate(context, Analytics());
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

  void _apiAdminOverviewScreenFilter() async {
    if (await Common.isNetworkAvailable()) {
      Future.delayed(Duration.zero, () => Common.dialogLoader(context));
      var data = {
        "BranchId": int.parse(await SharedPrefManager.getString(keyBranchId)),
      };
      Request request = Request(urlAdminOverviewScreenFilter, data);
      request.post().then((result) {
        Navigator.pop(context);
        var rest = result.data['hoteldetailslist'] as List;
        setState(() {
          hoteldetailslist = rest
              .map<Hoteldetailslist>((json) => Hoteldetailslist.fromJson(json))
              .toList();
          print(hoteldetailslist.toString());
        });

        for (int i = 0; i < hoteldetailslist.length; i++) {
          inventrylist = hoteldetailslist[i].inventoryList;
          if (_selectTimeSlot == null) {
            timesslot = inventrylist[i].timeSlotList;
          }
        }
        if (_selectType == null) {
          _selectType = inventrylist[0].tableType.toString();
        }
        if (_selectView == null) {
          _selectView = inventrylist[0].tableView.toString();
        }
        if (_selectTimeSlot == null) {
          _selectTimeSlot = inventrylist[0].timeSlotList[0].timeSlot.toString();
        }
        _apiAdminOverviewScreen();
      }).catchError((error) {
           Navigator.pop(context);

        Common.toast(context, wrongMsg);
      });
    } else {
      Common.toast(context, noInternetMsg);
    }
  }

  void _apiAdminOverviewScreen() async {
    if (await Common.isNetworkAvailable()) {
      Future.delayed(Duration.zero, () => Common.dialogLoader(context));

      var data = {
        "BranchId": int.parse(await SharedPrefManager.getString(keyBranchId)),
        "TableType": _selectType,
        "TableView": _selectView,
        "TimeSlot": _selectTimeSlot
      };
      Request request = Request(urlAdminOverviewScreen, data);
      request.post().then((result) {
        Navigator.pop(context);
        var rest = result.data['hoteldetailslist'] as List;
        setState(() {
          overviewList = rest
              .map<Hoteldetailslist1>(
                  (json) => Hoteldetailslist1.fromJson(json))
              .toList();
          print(overviewList.toString());
        });
        _totalPosition = overviewList[0]
            .inventoryList[0]
            .bookingListCountDemo[0]
            .overallCount
            .toString();
        _bookedPosition = overviewList[0]
            .inventoryList[0]
            .bookingListCountDemo[0]
            .bookedCount
            .toString();
        _vacantPosition = overviewList[0]
            .inventoryList[0]
            .bookingListCountDemo[0]
            .vacantCount
            .toString();
        _adminBlocked = overviewList[0]
            .inventoryList[0]
            .bookingListCountDemo[0]
            .adminCount
            .toString();

        for (int i = 0; i < overviewList.length; i++) {
          bookingList = overviewList[0].inventoryList[i].bookingListDemo;
          print(bookingList.length);
        }
      }).catchError((error) {
        Navigator.pop(context);

        Common.toast(context, wrongMsg);
      });
    } else {
      Common.toast(context, noInternetMsg);
    }
  }

  void _apiCancel(int bookingid, int branchid, String timeslot) async {
    {
      if (await Common.isNetworkAvailable()) {
        var data = {
          "BookingId": bookingid,
          "BranchId": int.parse(await SharedPrefManager.getString(keyBranchId)),
          "TimeSlot": timeslot
        };
        Request request = Request(urlCancellationBooking, data);
        request.post().then((result) {
          if (result.data['CancellationBookingResult']['Status'] == '1') {
            _apiAdminOverviewScreen();
          }
//           {
//     "CancellationBookingResult": {
//         "Message": "Your Booking Cancelled Successfully",
//         "Status": "1"
//     }
// }
        }).catchError((error) {
          Common.toast(context, wrongMsg);
        });
      } else {
        Navigator.pop(context);
        Common.toast(context, noInternetMsg);
      }
    }
  }

  void _apiBookTableByAdmin(
      int userId,
      int branchId,
      int tableViewId,
      int noOfPeople,
      String selectedDate,
      String timeSlot,
      String rates) async {
    // block
    {
      if (await Common.isNetworkAvailable()) {
        var data = {
          "UserId": 0,
          "BranchId": int.parse(await SharedPrefManager.getString(keyBranchId)),
          "TableViewId": tableViewId,
          "NoOfPeople": noOfPeople,
          "SelectedDate": selectedDate,
          "TimeSlot": timeSlot,
          "Rates": rates
        };
        Request request = Request(urlBookTableByAdmin, data);
        request.post().then((result) {
          _apiAdminOverviewScreen();
        }).catchError((error) {
          Common.toast(context, wrongMsg);
        });
      } else {
        Navigator.pop(context);
        Common.toast(context, noInternetMsg);
      }
    }
  }

  void _apiUnblockBookingByAdmin(int bookingId, int branchId) async {
    {
      if (await Common.isNetworkAvailable()) {
        var data = {
          "BookingId": bookingId,
          "BranchId": int.parse(await SharedPrefManager.getString(keyBranchId)),
        };
        Request request = Request(urlUnblockBookingByAdmin, data);
        request.post().then((result) {
          if (result.data['UnblockBookingByAdminResult']['Status'] == '1') {
            _apiAdminOverviewScreen();
          }
        }).catchError((error) {
          Common.toast(context, wrongMsg);
        });
      } else {
        Navigator.pop(context);
        Common.toast(context, noInternetMsg);
      }
    }
  }

  void _apiUpdateBookingStatus(int bookingId, int branchId) async {
    {
      if (await Common.isNetworkAvailable()) {
        var data = {
          "BookingId": bookingId,
          "BranchId": int.parse(await SharedPrefManager.getString(keyBranchId)),
        };
        Request request = Request(urlUpdateBookingStatus, data);
        request.post().then((result) {
          if (result.data['UpdateBookingStatusResult']['Status'] == '1') {
            _apiAdminOverviewScreen();
          }
// {
//     "UpdateBookingStatusResult": {
//         "Message": "Status Updated Successfully",
//         "Status": "1"
//     }
// }
        }).catchError((error) {
          Common.toast(context, wrongMsg);
        });
      } else {
        Navigator.pop(context);
        Common.toast(context, noInternetMsg);
      }
    }
  }
}
