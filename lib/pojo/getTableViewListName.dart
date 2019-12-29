
class GetTableViewListName {
  List<TableViewList> tableViewList;

  GetTableViewListName({this.tableViewList});

  GetTableViewListName.fromJson(Map<String, dynamic> json) {
    if (json['TableViewList'] != null) {
      tableViewList = new List<TableViewList>();
      json['TableViewList'].forEach((v) {
        tableViewList.add(new TableViewList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tableViewList != null) {
      data['TableViewList'] =
          this.tableViewList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TableViewList {
  int id;
  String tableView;
  String icon;

  TableViewList({this.id, this.tableView, this.icon});

  TableViewList.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    tableView = json['TableView'];
    icon = json['Icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['TableView'] = this.tableView;
    data['Icon'] = this.icon;
    return data;
  }

}