import 'package:firebase_database/firebase_database.dart';

class User {

  String _id;
  String _name;
  String _email;
  String _date;
  String _phone;
  String _place;
  String _club;

  User(this._id,this._name, this._email, this._date, this._phone, this._place, this._club);

  String get name => _name;

  String get email => _email;

  String get date => _date;

  String get phone => _phone;

  String get place => _place;

  String get club => _club;

  String get id => _id;

  User.fromSnapshot(DataSnapshot snapshot) {
    _id = snapshot.key;
    _name = snapshot.value['Name'];
    _email = snapshot.value['email'];
    _date = snapshot.value['date'];
    _phone = snapshot.value['phone'];
    _place = snapshot.value['Place'];
    _club = snapshot.value['Club'];

  }

}