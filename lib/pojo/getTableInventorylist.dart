class TableInventorylist {
  List<AddRestaurantResult> addRestaurantResult;

  TableInventorylist({this.addRestaurantResult});

  TableInventorylist.fromJson(Map<String, dynamic> json) {
    if (json['AddRestaurantResult'] != null) {
      addRestaurantResult = new List<AddRestaurantResult>();
      json['AddRestaurantResult'].forEach((v) {
        addRestaurantResult.add(new AddRestaurantResult.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.addRestaurantResult != null) {
      data['AddRestaurantResult'] =
          this.addRestaurantResult.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AddRestaurantResult {
  int id;
  int branchId;
  String tableType;
  int noOfTables;
  int maxPosition;
  int estimatedTime;
  bool isActive;
  String createdDate;
  int minPosition;

  AddRestaurantResult(
      {this.id,
      this.branchId,
      this.tableType,
      this.noOfTables,
      this.maxPosition,
      this.estimatedTime,
      this.isActive,
      this.createdDate,
      this.minPosition});

  AddRestaurantResult.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    branchId = json['BranchId'];
    tableType = json['TableType'];
    noOfTables = json['NoOfTables'];
    maxPosition = json['MaxPosition'];
    estimatedTime = json['EstimatedTime'];
    isActive = json['IsActive'];
    createdDate = json['CreatedDate'];
    minPosition = json['MinPosition'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['BranchId'] = this.branchId;
    data['TableType'] = this.tableType;
    data['NoOfTables'] = this.noOfTables;
    data['MaxPosition'] = this.maxPosition;
    data['EstimatedTime'] = this.estimatedTime;
    data['IsActive'] = this.isActive;
    data['CreatedDate'] = this.createdDate;
    data['MinPosition'] = this.minPosition;
    return data;
  }
}