
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:restaurant/data/drawer/drawer_data.dart';
import 'package:restaurant/res/color.dart';
import 'package:restaurant/screens/dashboard.dart';
import 'package:restaurant/screens/login1.dart';
import 'package:restaurant/screens/manager_history.dart';
import 'package:restaurant/screens/page1.dart';
import 'package:restaurant/screens/page2.dart';
import 'package:restaurant/screens/page4.dart';
import 'package:restaurant/util/common.dart';
import 'package:restaurant/util/routes.dart';
import 'package:restaurant/util/shared_pref_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class Page3 extends StatefulWidget {
  @override
  _Page3State createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  final _formKey = GlobalKey<FormState>();
  int _radioValue1 = -1;
  int correctScore = 0;
  String _imgType = 'PHOTO';

  List<Asset> images = List<Asset>();
  String _error = 'No Error Dectected';
  String _titlename;
  TextEditingController _titleController = TextEditingController();
 String _fullname= "";
  String  _branchname="";
  void _handleRadioValueChange1(int value) {
    setState(() {
      _radioValue1 = value;

      switch (_radioValue1) {
        case 0:
          Common.toast(context, 'PHOTO');
          _imgType = "PHOTO";
          correctScore++;
          break;
        case 1:
          Common.toast(context, 'MENU');
          _imgType = "MENU";

          break;
      }
    });
  }

  @override
  void initState() {
    _assignValue();
    setState(() {
      _radioValue1 = 0;
    });
    super.initState();
  }
  
 void _assignValue() async {
  _fullname = await SharedPrefManager.getString(keyfirstname) +
        " " +
        await SharedPrefManager.getString(keylastname);
    _branchname = await SharedPrefManager.getString(keyBranchName);
    
    _titleController.text =
        await SharedPrefManager.getString(keytitlename);
    
    _titlename = _titleController.text;
  
  }
 
  Widget buildGridView() {
    return GridView.count(
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      shrinkWrap: true,
      padding: EdgeInsets.all(5),
      mainAxisSpacing: 5.0,
      crossAxisSpacing: 5.0,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return GestureDetector(
          child: AssetThumb(
            asset: asset,
            width: 300,
            height: 300,
          ),
          onTap: () {
            Routes.navigate(
                context,
                DetailScreen(
                  asset: asset,
                ));
          },
        );
      }),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 10,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Restaurant App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
      // for (var r in resultList) {
      //   var t = await r.metadata;
      //   print(t);
      // }
    } on Exception catch (e) {
      error = e.toString();
    }
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      _error = error;
      Toast.show(_error, context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    });
  }
Future<bool> backPress() {
      Routes.navigateRemoveUntil(context, Page2());
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
                          "TITLE NAME",
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                      ),
                      Container(
                        color: Colors.grey[200],
                        padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                        child: TextFormField(
                          textCapitalization: TextCapitalization.sentences,
                          keyboardType: TextInputType.text,
                          controller: _titleController,
                          onChanged: (value) => _titlename = value,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Title name required';
                            }
                            return null;
                          },
                          autofocus: false,
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
                      new Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            new Radio(
                              value: 0,
                              groupValue: _radioValue1,
                              onChanged: _handleRadioValueChange1,
                            ),
                            new Text(
                              'PHOTO',
                              style: new TextStyle(
                                  fontSize: 13.0, color: Colors.grey),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            new Radio(
                              value: 1,
                              groupValue: _radioValue1,
                              onChanged: _handleRadioValueChange1,
                            ),
                            new Text(
                              'MENU',
                              style: new TextStyle(
                                  fontSize: 13.0, color: Colors.grey),
                            ),
                          ]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.fromLTRB(15, 15, 15, 5),
                            color: Colors.grey[200],
                            child: Text(
                              "UPLOAD IMAGE",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 13),
                            ),
                          ),
                          IconButton(
                            padding: EdgeInsets.fromLTRB(15, 15, 15, 5),
                            iconSize: 35,
                            icon: Icon(
                              Icons.camera_alt,
                              color: Colors.grey,
                            ),
                            onPressed: loadAssets,
                          )
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(130, 0, 130, 0),
                        child: FlatButton(
                          onPressed: null,
                          child: Text('SAVE',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 13)),
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Colors.grey,
                                  width: 1,
                                  style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(0)),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                        width: MediaQuery.of(context).size.width,
                        child: Container(
                          child: images.length == 0
                              ? Center(child: Text('No image selected.'))
                              : buildGridView(),
                        ),
                      ),
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
                              Routes.navigateRemoveUntil(context, Page2());
                             
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
                                  keytitlename, _titlename);
                              Routes.navigate(context, Page4());
                            },
                            color: Colors.white),
                      )),
                )
              ],
            ),
          )),
    );
  }

  // File _image;
  // Future getImageFromCam() async { // for camera
  //   var image = await ImagePicker.pickImage(source: ImageSource.camera);
  //   setState(() {
  //     _image = image;
  //   });
  // }
  //  Future getImageFromGallery() async {// for gallery
  //   var image = await ImagePicker.pickImage(source: ImageSource.gallery);
  //   setState(() {
  //     _image = image;
  //   });
  // }

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

class DetailScreen extends StatelessWidget {
  final Asset asset;

  DetailScreen({
    this.asset,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: AssetThumb(asset: asset, width: 350, height: 400),
        ),
      ),
    );
  }
  
}
