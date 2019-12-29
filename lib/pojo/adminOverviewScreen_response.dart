class AdminOverviewScreen {
  List<Hoteldetailslist1> hoteldetailslist;

  AdminOverviewScreen({this.hoteldetailslist});

  AdminOverviewScreen.fromJson(Map<String, dynamic> json) {
    if (json['hoteldetailslist'] != null) {
      hoteldetailslist = new List<Hoteldetailslist1>();
      json['hoteldetailslist'].forEach((v) {
        hoteldetailslist.add(new Hoteldetailslist1.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.hoteldetailslist != null) {
      data['hoteldetailslist'] =
          this.hoteldetailslist.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Hoteldetailslist1 {
  String branchId;
  String restaurantName;
  String foodType;
  String landline;
  String category;
  String addressLine1;
  String addressLine2;
  String rating;
  String estimatedCost;
  List<ImageList> imageList;
  List<InventoryList1> inventoryList;
  String message;

  Hoteldetailslist1(
      {this.branchId,
      this.restaurantName,
      this.foodType,
      this.landline,
      this.category,
      this.addressLine1,
      this.addressLine2,
      this.rating,
      this.estimatedCost,
      this.imageList,
      this.inventoryList,
      this.message});

  Hoteldetailslist1.fromJson(Map<String, dynamic> json) {
    branchId = json['BranchId'];
    restaurantName = json['RestaurantName'];
    foodType = json['FoodType'];
    landline = json['Landline'];
    category = json['Category'];
    addressLine1 = json['AddressLine1'];
    addressLine2 = json['AddressLine2'];
    rating = json['Rating'];
    estimatedCost = json['EstimatedCost'];
    if (json['ImageList'] != null) {
      imageList = new List<ImageList>();
      json['ImageList'].forEach((v) {
        imageList.add(new ImageList.fromJson(v));
      });
    }
    if (json['InventoryList'] != null) {
      inventoryList = new List<InventoryList1>();
      json['InventoryList'].forEach((v) {
        inventoryList.add(new InventoryList1.fromJson(v));
      });
    }
    message = json['Message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['BranchId'] = this.branchId;
    data['RestaurantName'] = this.restaurantName;
    data['FoodType'] = this.foodType;
    data['Landline'] = this.landline;
    data['Category'] = this.category;
    data['AddressLine1'] = this.addressLine1;
    data['AddressLine2'] = this.addressLine2;
    data['Rating'] = this.rating;
    data['EstimatedCost'] = this.estimatedCost;
    if (this.imageList != null) {
      data['ImageList'] = this.imageList.map((v) => v.toJson()).toList();
    }
    if (this.inventoryList != null) {
      data['InventoryList'] =
          this.inventoryList.map((v) => v.toJson()).toList();
    }
    data['Message'] = this.message;
    return data;
  }
}

class ImageList {
  String title;
  String url;
  String type;

  ImageList({this.title, this.url, this.type});

  ImageList.fromJson(Map<String, dynamic> json) {
    title = json['Title'];
    url = json['Url'];
    type = json['Type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Title'] = this.title;
    data['Url'] = this.url;
    data['Type'] = this.type;
    return data;
  }
}

class InventoryList1 {
  List<BookingListDemo> bookingListDemo;
  List<BookingListCountDemo> bookingListCountDemo;

  InventoryList1({this.bookingListDemo, this.bookingListCountDemo});

  InventoryList1.fromJson(Map<String, dynamic> json) {
    if (json['BookingListDemo'] != null) {
      bookingListDemo = new List<BookingListDemo>();
      json['BookingListDemo'].forEach((v) {
        bookingListDemo.add(new BookingListDemo.fromJson(v));
      });
    }
    if (json['BookingListCountDemo'] != null) {
      bookingListCountDemo = new List<BookingListCountDemo>();
      json['BookingListCountDemo'].forEach((v) {
        bookingListCountDemo.add(new BookingListCountDemo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bookingListDemo != null) {
      data['BookingListDemo'] =
          this.bookingListDemo.map((v) => v.toJson()).toList();
    }
    if (this.bookingListCountDemo != null) {
      data['BookingListCountDemo'] =
          this.bookingListCountDemo.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BookingListDemo {
  String status;
  int position;
  String currencyType;
  String price;
  String timeSlotLast;
  String timeSlotLastShow;
  int bookingId;
  int bookingStatus;
  int userId;
  int branchId;
  int tableViewId;
  int noOfPeople;
  String selectedDate;
  String timeSlot;
  String postedDate;
  String tableTypeId;
  String tableType;
  String rates;
  int cancelStatus;
  String firstName;
  String lastName;
  String profilePic;
  int makeSaleStatus;
  String makeSalePrice;
  String cancellingStatus;

  BookingListDemo(
      {this.status,
      this.position,
      this.currencyType,
      this.price,
      this.timeSlotLast,
      this.timeSlotLastShow,
      this.bookingId,
      this.bookingStatus,
      this.userId,
      this.branchId,
      this.tableViewId,
      this.noOfPeople,
      this.selectedDate,
      this.timeSlot,
      this.postedDate,
      this.tableTypeId,
      this.tableType,
      this.rates,
      this.cancelStatus,
      this.firstName,
      this.lastName,
      this.profilePic,
      this.makeSaleStatus,
      this.makeSalePrice,
      this.cancellingStatus});

  BookingListDemo.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    position = json['Position'];
    currencyType = json['CurrencyType'];
    price = json['Price'];
    timeSlotLast = json['TimeSlotLast'];
    timeSlotLastShow = json['TimeSlotLastShow'];
    bookingId = json['BookingId'];
    bookingStatus = json['BookingStatus'];
    userId = json['UserId'];
    branchId = json['BranchId'];
    tableViewId = json['TableViewId'];
    noOfPeople = json['NoOfPeople'];
    selectedDate = json['SelectedDate'];
    timeSlot = json['TimeSlot'];
    postedDate = json['PostedDate'];
    tableTypeId = json['TableTypeId'];
    tableType = json['TableType'];
    rates = json['Rates'];
    cancelStatus = json['CancelStatus'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    profilePic = json['ProfilePic'];
    makeSaleStatus = json['MakeSaleStatus'];
    makeSalePrice = json['MakeSalePrice'];
    cancellingStatus = json['CancellingStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    data['Position'] = this.position;
    data['CurrencyType'] = this.currencyType;
    data['Price'] = this.price;
    data['TimeSlotLast'] = this.timeSlotLast;
    data['TimeSlotLastShow'] = this.timeSlotLastShow;
    data['BookingId'] = this.bookingId;
    data['BookingStatus'] = this.bookingStatus;
    data['UserId'] = this.userId;
    data['BranchId'] = this.branchId;
    data['TableViewId'] = this.tableViewId;
    data['NoOfPeople'] = this.noOfPeople;
    data['SelectedDate'] = this.selectedDate;
    data['TimeSlot'] = this.timeSlot;
    data['PostedDate'] = this.postedDate;
    data['TableTypeId'] = this.tableTypeId;
    data['TableType'] = this.tableType;
    data['Rates'] = this.rates;
    data['CancelStatus'] = this.cancelStatus;
    data['FirstName'] = this.firstName;
    data['LastName'] = this.lastName;
    data['ProfilePic'] = this.profilePic;
    data['MakeSaleStatus'] = this.makeSaleStatus;
    data['MakeSalePrice'] = this.makeSalePrice;
    data['CancellingStatus'] = this.cancellingStatus;
    return data;
  }
}

class BookingListCountDemo {
  int overallCount;
  int bookedCount;
  int vacantCount;
  int adminCount;

  BookingListCountDemo(
      {this.overallCount, this.bookedCount, this.vacantCount, this.adminCount});

  BookingListCountDemo.fromJson(Map<String, dynamic> json) {
    overallCount = json['OverallCount'];
    bookedCount = json['BookedCount'];
    vacantCount = json['VacantCount'];
    adminCount = json['AdminCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OverallCount'] = this.overallCount;
    data['BookedCount'] = this.bookedCount;
    data['VacantCount'] = this.vacantCount;
    data['AdminCount'] = this.adminCount;
    return data;
  }
}