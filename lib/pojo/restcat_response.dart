class RestCategory {
  List<RestCategoryList> restCategoryList;

  RestCategory({this.restCategoryList});

  RestCategory.fromJson(Map<String, dynamic> json) {
    if (json['RestCategoryList'] != null) {
      restCategoryList = new List<RestCategoryList>();
      json['RestCategoryList'].forEach((v) {
        restCategoryList.add(new RestCategoryList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.restCategoryList != null) {
      data['RestCategoryList'] =
          this.restCategoryList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RestCategoryList {
  int id;
  String category;

  RestCategoryList({this.id, this.category});

  RestCategoryList.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    category = json['Category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Category'] = this.category;
    return data;
  }
}