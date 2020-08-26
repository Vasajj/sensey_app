import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:aikidoacademyapp/anketa/tile.dart';
import 'package:aikidoacademyapp/anketa/user_dashboard.dart';

class Anketa extends StatefulWidget {
  Anketa({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AnketaState createState() => _AnketaState();
}

class _AnketaState extends State<Anketa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Реєстраційна форма",
                  style: TextStyle(
                      fontWeight: FontWeight.w200,
                      fontSize: 30,
                      fontFamily: 'Roboto',
                      fontStyle: FontStyle.italic)),
              RegisterStudent(),
            ]),
      )),
    );
  }
}

class RegisterStudent extends StatefulWidget {
  RegisterStudent({Key key}) : super(key: key);

  @override
  _RegisterStudentState createState() => _RegisterStudentState();
}

class _RegisterStudentState extends State<RegisterStudent> {
  final _formKey = GlobalKey<FormState>();
  final listOfClubs = [
    "Кагамі доджо (тренер М.Рогач)",
    "Кейко доджо (тренер Г.Кухта)",
    "Макото доджо (тренер А.Слободяник)",
    "Катсу доджо (тренер В.Талапа)"
  ];
  String dropdownValue = "Кагамі доджо (тренер М.Рогач)";
  final nameController = TextEditingController();
  final placeController = TextEditingController();
  final dateController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  final dbRef = FirebaseDatabase.instance.reference().child("record");

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
            child: Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20.0),
            child: TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Введіть ім'я",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value.isEmpty) {
                  return "Введіть ім'я";
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: TextFormField(
              controller: dateController,
              decoration: InputDecoration(
                labelText: "Дата народження",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value.isEmpty) {
                  return "Дата не введена";
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: TextFormField(
              controller: placeController,
              decoration: InputDecoration(
                labelText: "Місце проживання",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value.isEmpty) {
                  return "Місце проживання не введено";
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: DropdownButtonFormField(
              value: dropdownValue,
              icon: Icon(Icons.arrow_downward),
              decoration: InputDecoration(
                labelText: "Виберіть клуб",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              items: listOfClubs.map((String value) {
                return new DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
              onChanged: (String newValue) {
                setState(() {
                  this.dropdownValue = newValue;
                });
              },
              validator: (value) {
                if (value.isEmpty) {
                  return 'Виберіть клуб';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: phoneController,
              decoration: InputDecoration(
                labelText: "Введіть номер телефону",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value.isEmpty) {
                  return 'Введіть номер телефону';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Введіть електронну адресу",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value.isEmpty) {
                  return 'Електронна адреса не введена';
                }
                return null;
              },
            ),
          ),
          Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    color: Colors.lightBlue,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        dbRef.push().set({
                          "Name": nameController.text,
                          "date": dateController.text,
                          "Club": dropdownValue,
                          "email": emailController.text,
                          "Place": placeController.text,
                          "phone": phoneController.text,
                        }).then((_) {
                          Scaffold.of(context)
                              .showSnackBar(SnackBar(content: Text('Додано')));
                          dateController.clear();
                          nameController.clear();
                        }).catchError((onError) {
                          Scaffold.of(context)
                              .showSnackBar(SnackBar(content: Text(onError)));
                        });
                      }
                    },
                    child: Text('Додати'),
                  ),
                  RaisedButton(
                    color: Colors.deepPurple,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserDashboard()),
                      );
                    },
                    child: Text('Перейти до списку'),
                  ),
                ],
              )),
        ])));
  }

  @override
  void dispose() {
    super.dispose();
    dateController.dispose();
    nameController.dispose();
  }
}
