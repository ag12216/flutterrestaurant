class AdminBookingHistory {
  List<HoteldetailslistHistory> hoteldetailslist;

  AdminBookingHistory({this.hoteldetailslist});

  AdminBookingHistory.fromJson(Map<String, dynamic> json) {
    if (json['hoteldetailslist'] != null) {
      hoteldetailslist = new List<HoteldetailslistHistory>();
      json['hoteldetailslist'].forEach((v) {
        hoteldetailslist.add(new HoteldetailslistHistory.fromJson(v));
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

class HoteldetailslistHistory {
  String tableType;
  String tableView;
  List<BookingListDemoHistory> bookingListDemo;

  HoteldetailslistHistory({this.tableType, this.tableView, this.bookingListDemo});

  HoteldetailslistHistory.fromJson(Map<String, dynamic> json) {
    tableType = json['TableType'];
    tableView = json['TableView'];
    if (json['BookingListDemo'] != null) {
      bookingListDemo = new List<BookingListDemoHistory>();
      json['BookingListDemo'].forEach((v) {
        bookingListDemo.add(new BookingListDemoHistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TableType'] = this.tableType;
    data['TableView'] = this.tableView;
    if (this.bookingListDemo != null) {
      data['BookingListDemo'] =
          this.bookingListDemo.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BookingListDemoHistory {
  int bookingId;
  int bookingStatus;
  int cancelStatus;
  int userId;
  int noOfPeople;
  String timeSlot;
  String timeSlotShow;
  String selectedDate;
  String tableType;
  String tableNo;
  String rates;
  String firstName;
  String lastName;
  String profilePic;
  String tableView;

  BookingListDemoHistory(
      {this.bookingId,
      this.bookingStatus,
      this.cancelStatus,
      this.userId,
      this.noOfPeople,
      this.timeSlot,
      this.timeSlotShow,
      this.selectedDate,
      this.tableType,
      this.tableNo,
      this.rates,
      this.firstName,
      this.lastName,
      this.profilePic,
      this.tableView});

  BookingListDemoHistory.fromJson(Map<String, dynamic> json) {
    bookingId = json['BookingId'];
    bookingStatus = json['BookingStatus'];
    cancelStatus = json['CancelStatus'];
    userId = json['UserId'];
    noOfPeople = json['NoOfPeople'];
    timeSlot = json['TimeSlot'];
    timeSlotShow = json['TimeSlotShow'];
    selectedDate = json['SelectedDate'];
    tableType = json['TableType'];
    tableNo = json['TableNo'];
    rates = json['Rates'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    profilePic = json['ProfilePic'];
    tableView = json['TableView'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['BookingId'] = this.bookingId;
    data['BookingStatus'] = this.bookingStatus;
    data['CancelStatus'] = this.cancelStatus;
    data['UserId'] = this.userId;
    data['NoOfPeople'] = this.noOfPeople;
    data['TimeSlot'] = this.timeSlot;
    data['TimeSlotShow'] = this.timeSlotShow;
    data['SelectedDate'] = this.selectedDate;
    data['TableType'] = this.tableType;
    data['TableNo'] = this.tableNo;
    data['Rates'] = this.rates;
    data['FirstName'] = this.firstName;
    data['LastName'] = this.lastName;
    data['ProfilePic'] = this.profilePic;
    data['TableView'] = this.tableView;
    return data;
  }
}