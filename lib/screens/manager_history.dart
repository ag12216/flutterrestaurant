import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:restaurant/data/drawer/drawer_data.dart';
import 'package:restaurant/http/request.dart';
import 'package:restaurant/http/urls.dart';
import 'package:restaurant/pojo/adminBookingHistory_response.dart';
import 'package:restaurant/res/color.dart';
import 'package:restaurant/res/string.dart';
import 'package:restaurant/screens/analytics_screen.dart';
import 'package:restaurant/screens/dashboard.dart';
import 'package:restaurant/screens/login1.dart';
import 'package:restaurant/screens/page1.dart';
import 'package:restaurant/util/common.dart';
import 'package:restaurant/util/routes.dart';
import 'package:restaurant/util/shared_pref_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ManagerHistory extends StatefulWidget {
  @override
  _ManagerHistoryState createState() => _ManagerHistoryState();
}

class _ManagerHistoryState extends State<ManagerHistory> {
  DateTime currentBackPressTime;
  int statemaintain = 0;
  List<HoteldetailslistHistory> hotelhistoryList = [];
  List<BookingListDemoHistory> bookingListdemo = [];
  int _value = 0; // chip 1
  String _beginDate, _endDate;
  int _selectedIndex = 0;
  String _fullname = "";
  String _branchname = "";
  String _profileimage = "";

  _onSelected(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  void initState() {
    _pref();
    _apiAdminBookingHistory();
    super.initState();
  }

  void _pref() async {
    _fullname = await SharedPrefManager.getString(keyfirstname) +
        " " +
        await SharedPrefManager.getString(keylastname);
    _branchname = await SharedPrefManager.getString(keyBranchName);
        _profileimage = await SharedPrefManager.getString(keyProfileImage);

  }

  Future<bool> backPress() {
    Navigator.pop(context);
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
              'HISTORY',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 17),
            ),
            backgroundColor: Colors.deepOrangeAccent,
            actions: <Widget>[
              new IconButton(
                icon: new Icon(Icons.date_range),
                tooltip: 'Time filter',
                onPressed: () {
                  showPickerDateRange(context);
                },
              ),
            ],
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
                      hotelhistoryList.length,
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
                            hotelhistoryList[_selectIndex].tableType +
                                " " +
                                hotelhistoryList[_selectIndex].tableView,
                            style: TextStyle(
                                fontSize: 11, color: Colors.deepOrangeAccent),
                          ),
                          selected: _value == _selectIndex,
                          onSelected: (bool selected) {
                            setState(() {
                              _value = selected ? _selectIndex : null;
                              statemaintain = _selectIndex;
                              bookingListdemo = hotelhistoryList[_selectIndex]
                                  .bookingListDemo;
                            });
                          },
                        );
                      },
                    ).toList(),
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: bookingListdemo.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    child: Slidable(
                      key: ValueKey(index),
                      actionPane: SlidableDrawerActionPane(),
                      secondaryActions: <Widget>[
                        _slideButtons(
                            bookingListdemo[index].cancelStatus,
                            bookingListdemo[index].userId,
                            bookingListdemo[index].bookingStatus,
                            bookingListdemo[index].bookingId,
                            bookingListdemo[index].timeSlot)
                      ],
                      child: Container(
                          height: 100,
                          margin: new EdgeInsets.all(0.5),
                          color: bookingListdemo[index].userId == 0 &&
                                  bookingListdemo[index].cancelStatus == 0
                              ? Colors.yellow[300]
                              : Colors.white,
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                child: CircleAvatar(
                                  child: ClipRRect(
                                    borderRadius: new BorderRadius.circular(20),
                                    child: CachedNetworkImage(
                                        imageUrl:
                                            bookingListdemo[index].profilePic,
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
                                            child: bookingListdemo[index].userId == 0 &&
                                                    bookingListdemo[index]
                                                            .cancelStatus ==
                                                        0
                                                ? Text('Block by admin',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        fontSize: 11))
                                                : Text(
                                                    bookingListdemo[index]
                                                            .firstName
                                                            .replaceAll(
                                                                "\r\n", " ") +
                                                        " " +
                                                        bookingListdemo[index]
                                                            .lastName
                                                            .replaceAll(
                                                                "\r\n", " "),
                                                    style: TextStyle(
                                                        color: Colors.deepOrangeAccent,
                                                        fontStyle: FontStyle.italic,
                                                        fontSize: 11))),
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
                                                      Icons.date_range,
                                                      size: 15,
                                                    ),
                                                    flex: 1,
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      bookingListdemo[index]
                                                          .selectedDate
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12),
                                                    ),
                                                    flex: 5,
                                                  ),
                                                ],
                                              ),
                                            )),
                                        Expanded(
                                          child: Container(
                                            width: 150,
                                            padding:
                                                EdgeInsets.fromLTRB(0, 3, 0, 0),
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
                                                        bookingListdemo[index]
                                                            .timeSlotShow,
                                                    // bookingList[index]
                                                    //     .timeSlotLastShow,
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
                                                      bookingListdemo[index]
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
                                          bookingListdemo[index].rates,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                      ),
                                    ],
                                  )),
                              Container(
                                width: 85,
                                padding: EdgeInsets.fromLTRB(10, 2, 0, 0),
                                child: Center(
                                  child: _status(
                                      bookingListdemo[index].bookingStatus,
                                      bookingListdemo[index].cancelStatus,
                                      bookingListdemo[index].userId),
                                ),
                              ),
                              Container(
                                child: bookingListdemo[index].bookingStatus ==
                                            0 ||
                                        bookingListdemo[index].cancelStatus ==
                                                0 &&
                                            bookingListdemo[index].userId == 0
                                    ? Icon(
                                        Icons.chevron_right,
                                        size: 25,
                                      )
                                    : SizedBox(
                                        width: 25,
                                      ),
                              )
                            ],
                          )),
                    ),
                    onTap: () => _onSelected(index),
                  );
                },
              )
            ],
          )),
    );
  }

  _status(int bookingStatus, int cancelStatus, int userId) {
    if (userId == 0 && cancelStatus == 0) {
      return Text("Block by admin",
          style: TextStyle(color: Colors.black, fontSize: 15));
    } else if (bookingStatus == 0) {
      return Text("In progress",
          style: TextStyle(color: Colors.black, fontSize: 15));
    } else if (bookingStatus == 1) {
      return Text("Checkout",
          style: TextStyle(color: Colors.black, fontSize: 15));
    } else if (cancelStatus == 1) {
      return Text("cancelled",
          style: TextStyle(color: Colors.black, fontSize: 15));
    }
  }

  _slideButtons(int cancelStatus, int userId, int bookingStatus, int bookingId,
      String timeslot) {
    if (cancelStatus == 0 && userId == 0) {
      return IconSlideAction(
        caption: 'UNBLOCK',
        color: Colors.blue,
        icon: Icons.block,
        onTap: () {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => AlertDialog(
                    title: Text("Confirmation!"),
                    content: const Text('Are you sure you want to unblock?'),
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
                          _apiUnblockBookingByAdmin(
                            bookingId,
                          );
                        },
                      )
                    ],
                  ));
        },
      );
    } else if (bookingStatus == 0) {
      return IconSlideAction(
        caption: 'CHECK OUT',
        color: Colors.green,
        icon: Icons.check,
        onTap: () {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => AlertDialog(
                    title: Text("Confirmation!"),
                    content: const Text('Are you sure you want to check out?'),
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
                            bookingId,
                          );
                        },
                      )
                    ],
                  ));
        },
      );
    } else if (bookingStatus == 1) {
      return SizedBox(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Image.asset(
              'assets/happy.png',
            ),
          ),
          height: 50,
          width: 50,
          color: Colors.white,
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
      );
    } else if (cancelStatus == 1) {
      return SizedBox(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Image.asset(
              'assets/sad.png',
            ),
          ),
          height: 50,
          width: 50,
          color: Colors.white,
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
      );
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

  void _apiAdminBookingHistory() async {
    if (await Common.isNetworkAvailable()) {
      Future.delayed(Duration.zero, () => Common.dialogLoader(context));

      var currentDate = new DateTime.now();
      var date = DateTime.parse(currentDate.toString());
      var formattedcurrentDate = "${date.day}-${date.month}-${date.year}";
      var data;
      if (_beginDate == null && _endDate == null) {
        data = {
          "BranchId": int.parse(await SharedPrefManager.getString(keyBranchId)),
          "DateFrom": formattedcurrentDate,
          "DateTo": formattedcurrentDate
        };
      } else {
        data = {
          "BranchId": int.parse(await SharedPrefManager.getString(keyBranchId)),
          "DateFrom": _beginDate,
          "DateTo": _endDate
        };
      }

      Request request = Request(urlAdminBookingHistory, data);
      request.post().then((result) {
        Navigator.pop(context);
        var rest = result.data['hoteldetailslist'] as List;
        setState(() {
          hotelhistoryList = rest
              .map<HoteldetailslistHistory>(
                  (json) => HoteldetailslistHistory.fromJson(json))
              .toList();
          bookingListdemo = hotelhistoryList[statemaintain].bookingListDemo;
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
            _apiAdminBookingHistory();
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

  void _apiUnblockBookingByAdmin(int bookingId) async {
    {
      if (await Common.isNetworkAvailable()) {
        var data = {
          "BookingId": bookingId,
          "BranchId": int.parse(await SharedPrefManager.getString(keyBranchId)),
        };
        Request request = Request(urlUnblockBookingByAdmin, data);
        request.post().then((result) {
          if (result.data['UnblockBookingByAdminResult']['Status'] == '1') {
            _apiAdminBookingHistory();
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

  void _apiCancel(int bookingid, String timeslot) async {
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
            _apiAdminBookingHistory();
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
        Common.toast(context, noInternetMsg);
      }
    }
  }

  void _apiUpdateBookingStatus(int bookingId) async {
    {
      if (await Common.isNetworkAvailable()) {
        var data = {
          "BookingId": bookingId,
          "BranchId": int.parse(await SharedPrefManager.getString(keyBranchId)),
        };
        Request request = Request(urlUpdateBookingStatus, data);
        request.post().then((result) {
          if (result.data['UpdateBookingStatusResult']['Status'] == '1') {
            _apiAdminBookingHistory();
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
}
