import 'package:firebase_helpers/firebase_helpers.dart';



class AnketaModel extends DatabaseItem {
  final String id;
  final String name;
  final String date;
  final String place;
  final String club;
  final String phone;
  final String email;

  AnketaModel(
      {this.id,
      this.name,
      this.email,
      this.club,
      this.date,
      this.phone,
      this.place})
      : super(id);

  factory AnketaModel.fromMap(Map data) {
    return AnketaModel(
      name: data['Name'],
      date: data['date'],
      place: data['Place'],
      club: data['Club'],
      phone: data['phone'],
      email: data['email'],
    );
  }

  factory AnketaModel.fromDS(String id, Map<String, dynamic> data) {
    return AnketaModel(
      id: id,
      name: data['Name'],
      date: data['date'],
      place: data['Place'],
      club: data['Club'],
      phone: data['phone'],
      email: data['email'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "Name": name,
      "id": id,
      "Place": place,
      "Club": club,
      "phone": phone,
      "email": email
    };
  }
}
