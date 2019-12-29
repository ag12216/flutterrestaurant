class RestaurantListResponse {
  List<RestList> restList;

  RestaurantListResponse({this.restList});

  RestaurantListResponse.fromJson(Map<String, dynamic> json) {
    if (json['RestList'] != null) {
      restList = new List<RestList>();
      json['RestList'].forEach((v) {
        restList.add(new RestList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.restList != null) {
      data['RestList'] = this.restList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RestList {
  int id;
  String restaurantName;

  RestList({this.id, this.restaurantName});

  RestList.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    restaurantName = json['RestaurantName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['RestaurantName'] = this.restaurantName;
    return data;
  }
}