class DrawerData {
  static List<DrawerModel> data = [
    DrawerModel(title: 'Overview'),
    DrawerModel(title: 'Booking History'),
   // DrawerModel(title: 'Add Restaurant'),
    DrawerModel(title: 'Analytics'),
    DrawerModel(title: 'Sign Out'),
  ];
}

class DrawerModel {
  // String imagePath;
  String title;
  DrawerModel({this.title});
}
