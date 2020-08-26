import 'package:flutter/material.dart';
import 'package:aikidoacademyapp/anketa/user.dart';


class AlertPage extends StatefulWidget {
  AddUserDialog createState()=> AddUserDialog();
}


class AddUserDialog extends State<AlertPage> {
  final teName = TextEditingController();
  final listOfClubs = [
    "Кагамі доджо (тренер М.Рогач)",
    "Кейко доджо (тренер Г.Кухта)",
    "Макото доджо (тренер А.Слободяник)",
    "Катсу доджо (тренер В.Талапа)"
  ];
  String dropdownValue = "Кагамі доджо (тренер М.Рогач)";
  final teEmail = TextEditingController();
  final teAge = TextEditingController();
  final tePhone = TextEditingController();
  final teAdress = TextEditingController();
  User user;

  static const TextStyle linkStyle = const TextStyle(
    color: Colors.blue,
    decoration: TextDecoration.underline,
  );

  Widget buildAboutDialog(BuildContext context,
      AddUserCallback _myHomePageState, bool isEdit, User user) {

    if (user != null) {
      this.user = user;
      teName.text = user.name;
      teEmail.text = user.email;
      teAge.text = user.date;
      tePhone.text = user.phone;
      teAdress.text = user.place;
      dropdownValue = user.club;
    }

    return  AlertDialog(
      title:  Text(isEdit ? 'Внести зміни!' : 'Додати нового учасника!'),
      content:  SingleChildScrollView(
        child:  Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            getTextField("Ім'я", teName),
            DropdownButtonFormField(
              value: dropdownValue,
              icon: Icon(Icons.arrow_downward),
              decoration: InputDecoration(
                labelText: "Виберіть клуб",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              items: listOfClubs.map((String value) {
                return  DropdownMenuItem<String>(
                  value: value,
                  child:  Text(value),
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
            getTextField("Електронна пошта", teEmail),
            getTextField("Адреса", teAdress),
            getTextField("Дата народження", teAge),
            getTextField("Номер телефону", tePhone),
            GestureDetector(
              onTap: () => onTap(isEdit, _myHomePageState, context),
              child:  Container(
                margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                child: getAppBorderButton(isEdit ? "Змінити" : "Додати",
                    EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getTextField(
      String inputBoxName, TextEditingController inputBoxController) {
    var loginBtn =  Padding(
      padding: const EdgeInsets.all(5.0),
      child:  TextFormField(
        controller: inputBoxController,
        decoration:  InputDecoration(
          hintText: inputBoxName,
        ),
      ),
    );

    return loginBtn;
  }

  Widget getAppBorderButton(String buttonLabel, EdgeInsets margin) {
    var loginBtn =  Container(
      margin: margin,
      padding: EdgeInsets.all(8.0),
      alignment: FractionalOffset.center,
      decoration:  BoxDecoration(
        border: Border.all(color: const Color(0xFF28324E)),
        borderRadius: new BorderRadius.all(const Radius.circular(6.0)),
      ),
      child:  Text(
        buttonLabel,
        style:  TextStyle(
          color: const Color(0xFF28324E),
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
          letterSpacing: 0.3,
        ),
      ),
    );
    return loginBtn;
  }

  User getData(bool isEdit) {
    return new User(isEdit ? user.id : "", teName.text, teEmail.text,
        teAge.text, tePhone.text, teAdress.text, dropdownValue);
  }

  onTap(bool isEdit, AddUserCallback _myHomePageState, BuildContext context) {
    if (isEdit) {
      _myHomePageState.update(getData(isEdit));
      Navigator.of(context).pop();
    } else {
      _myHomePageState.addUser(getData(isEdit));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

abstract class AddUserCallback {
  void addUser(User user);

  void update(User user);
}