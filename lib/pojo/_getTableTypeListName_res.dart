class GetTableTypeListName {
  List<TableTypeList> tableTypeList;

  GetTableTypeListName({this.tableTypeList});

  GetTableTypeListName.fromJson(Map<String, dynamic> json) {
    if (json['TableTypeList'] != null) {
      tableTypeList = new List<TableTypeList>();
      json['TableTypeList'].forEach((v) {
        tableTypeList.add(new TableTypeList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tableTypeList != null) {
      data['TableTypeList'] =
          this.tableTypeList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TableTypeList {
  int id;
  String tableType;

  TableTypeList({this.id, this.tableType});

  TableTypeList.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    tableType = json['TableType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['TableType'] = this.tableType;
    return data;
  }
}