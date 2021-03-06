import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:aikidoacademyapp/anketa/add_user_dialog.dart';
import 'package:aikidoacademyapp/anketa/firebase_database_util.dart';
import 'package:aikidoacademyapp/anketa/user.dart';

class UserDashboard extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<UserDashboard> implements AddUserCallback {
  TextEditingController editingController = TextEditingController();
  bool _anchorToBottom = false;
  FirebaseDatabaseUtil databaseUtil;


  @override
  void initState() {
    super.initState();
    databaseUtil = FirebaseDatabaseUtil();
    databaseUtil.initState();
  }

  @override
  void dispose() {
    super.dispose();
    databaseUtil.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildTitle(BuildContext context) {
      return InkWell(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Список учасників',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      );
    }

    List<Widget> _buildActions() {
      return <Widget>[
        new IconButton(
          icon: const Icon(
            Icons.group_add,
            color: Colors.white,
          ),
          onPressed: () => showEditWidget(null, false),
        ),
      ];
    }

    return new Scaffold(
        appBar:  AppBar(
          title: _buildTitle(context),
          actions: _buildActions(),
          backgroundColor: Colors.deepPurple,
        ),
        body: Container(
          child: Column(children: <Widget>[
//            Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: TextField(
//                onChanged: (value) {
//                  filterSearchResults(value);
//                },
//                controller: editingController,
//                decoration: InputDecoration(
//                    labelText: "Пошук",
//                    hintText: "Пошук",
//                    prefixIcon: Icon(Icons.search),
//                    border: OutlineInputBorder(
//                        borderRadius: BorderRadius.all(Radius.circular(25.0))),
//                ),
//              ),
//            ),
            Expanded(
              child: FirebaseAnimatedList(
                key: ValueKey<bool>(_anchorToBottom),
                query: databaseUtil.getUser(),
                reverse: _anchorToBottom,
                sort: _anchorToBottom
                    ? (DataSnapshot a, DataSnapshot b) => b.key.compareTo(a.key)
                    : null,
                itemBuilder: (BuildContext context, DataSnapshot snapshot,
                    Animation<double> animation, int index) {
                  return SizeTransition(
                    sizeFactor: animation,
                    child: showUser(snapshot),
                  );
                },
              ),
            ),
          ]),
        ));
  }

  @override
  void addUser(User user) {
    setState(() {
      databaseUtil.addUser(user);
    });
  }

  @override
  void update(User user) {
    setState(() {
      databaseUtil.updateUser(user);
    });
  }

  Widget showUser(DataSnapshot res) {
    User user = User.fromSnapshot(res);

    var item = Card(
      child: Container(
          child: Center(
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 30.0,
                  child: Text(getShortName(user)),
                  backgroundColor: const Color(0xFF20283e),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          user.name,
                          // set some style to text
                          style: TextStyle(
                              fontSize: 20.0, color: Colors.deepPurple),
                        ),
                        Text(
                          user.club,
                          // set some style to text
                          style: TextStyle(
                              fontSize: 20.0, color: Colors.lightBlueAccent),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.deepPurple,
                      ),
                      onPressed: () => showEditWidget(user, true),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_forever),
                      color: Colors.deepPurple,
                      onPressed: () => onDelete(user),
                    ),
                  ],
                ),
              ],
            ),
          ),
          padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0)),
    );

    return item;
  }

  String getShortName(User user) {
    String shortName = "";
    if (!user.name.isNotEmpty) {
      shortName = user.name.substring(0, 1);
    }
    return shortName;
  }

  showEditWidget(User user, bool isEdit) {
    showDialog(
      context: context,
      builder: (BuildContext context) =>
          AddUserDialog().buildAboutDialog(context, this, isEdit, user),
    );
  }

  void onDelete(User user) async {
    if (await _showConfirmationDialog(context)) {
      databaseUtil.deleteUser(user);
    }
  }

  Future<bool> _showConfirmationDialog(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
              content: Text("Видалити учасника?"),
              actions: <Widget>[
                FlatButton(
                  textColor: Colors.red,
                  child: Text("Видалити"),
                  onPressed: () => Navigator.pop(context, true),
                ),
                FlatButton(
                  textColor: Colors.black,
                  child: Text("Відміна"),
                  onPressed: () => Navigator.pop(context, false),
                ),
              ],
            ));
  }
}



//class DetailPage extends StatelessWidget {
//   @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text(data.name),
//      ),
//    );
//  }
