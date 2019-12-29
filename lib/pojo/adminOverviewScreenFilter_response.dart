class AdminOverviewScreenFilter {
  List<Hoteldetailslist> hoteldetailslist;

  AdminOverviewScreenFilter({this.hoteldetailslist});

  AdminOverviewScreenFilter.fromJson(Map<String, dynamic> json) {
    if (json['hoteldetailslist'] != null) {
      hoteldetailslist = new List<Hoteldetailslist>();
      json['hoteldetailslist'].forEach((v) {
        hoteldetailslist.add(new Hoteldetailslist.fromJson(v));
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

class Hoteldetailslist {
  String branchId;
  String restaurantName;
  String foodType;
  String landline;
  String category;
  String estimatedCost;
  List<InventoryList> inventoryList;
  String message;

  Hoteldetailslist(
      {this.branchId,
      this.restaurantName,
      this.foodType,
      this.landline,
      this.category,
      this.estimatedCost,
      this.inventoryList,
      this.message});

  Hoteldetailslist.fromJson(Map<String, dynamic> json) {
    branchId = json['BranchId'];
    restaurantName = json['RestaurantName'];
    foodType = json['FoodType'];
    landline = json['Landline'];
    category = json['Category'];
    estimatedCost = json['EstimatedCost'];
    if (json['InventoryList'] != null) {
      inventoryList = new List<InventoryList>();
      json['InventoryList'].forEach((v) {
        inventoryList.add(new InventoryList.fromJson(v));
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
    data['EstimatedCost'] = this.estimatedCost;
    if (this.inventoryList != null) {
      data['InventoryList'] =
          this.inventoryList.map((v) => v.toJson()).toList();
    }
    data['Message'] = this.message;
    return data;
  }
}

class InventoryList {
  String tableType;
  String tableView;
  List<TimeSlotList> timeSlotList;

  InventoryList({this.tableType, this.tableView, this.timeSlotList});

  InventoryList.fromJson(Map<String, dynamic> json) {
    tableType = json['TableType'];
    tableView = json['TableView'];
    if (json['TimeSlotList'] != null) {
      timeSlotList = new List<TimeSlotList>();
      json['TimeSlotList'].forEach((v) {
        timeSlotList.add(new TimeSlotList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TableType'] = this.tableType;
    data['TableView'] = this.tableView;
    if (this.timeSlotList != null) {
      data['TimeSlotList'] = this.timeSlotList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TimeSlotList {
  String timeSlot;
  String timeSlotShow;
  String price;

  TimeSlotList({this.timeSlot, this.timeSlotShow, this.price});

  TimeSlotList.fromJson(Map<String, dynamic> json) {
    timeSlot = json['TimeSlot'];
    timeSlotShow = json['TimeSlotShow'];
    price = json['Price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TimeSlot'] = this.timeSlot;
    data['TimeSlotShow'] = this.timeSlotShow;
    data['Price'] = this.price;
    return data;
  }
}