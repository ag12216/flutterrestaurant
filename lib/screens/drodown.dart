import 'package:flutter/material.dart';

List<User> userList = new List<User>();
User selectedUser;

class MyDropDownForm extends StatefulWidget {
  createState() {
    userList.add(new User(name: 'ABC', age: '25'));
    userList.add(new User(name: 'SDF', age: '24'));
    userList.add(new User(name: 'FGDG', age: '23'));
    userList.add(new User(name: 'PQR', age: '28'));
    userList.add(new User(name: 'XFGDF', age: '29'));
    userList.add(new User(name: 'WWW', age: '26'));
    userList.add(new User(name: 'HHH', age: '30'));
    userList.add(new User(name: 'RFD', age: '35'));
    selectedUser = userList[0];

    return StateKeeper();
  }
}

class StateKeeper extends State<MyDropDownForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      color: Colors.grey[200],
      child: DropdownButton(
        isExpanded: true,
        hint: Text('Select'), // Not necessary for Option 1
        value: selectedUser,
        onChanged: (User pt) {
          setState(() {
            selectedUser = pt;
            print("Selected user " + selectedUser.name);
          });
        },
     items: userList.map((User p) {
                              return new DropdownMenuItem<User>(
                                value: p,
                                child: new Text(
                                  p.name,
                                  textAlign: TextAlign.center,
                                  style: new TextStyle(color: Colors.black),
                                ),
                              );
                            }).toList(),
      ),
    );
  }
}

class User {
  String name;
  String age;

  User({
    this.name,
    this.age,
  });

  factory User.fromJson(Map<String, dynamic> json) => new User(
        name: json["name"],
        age: json["age"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "age": age,
      };
}
