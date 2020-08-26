import 'package:firebase_helpers/firebase_helpers.dart';


class EventModel extends DatabaseItem{
  final String id;
  final String title;
  final String description;
  final DateTime eventDateStart;
  final DateTime eventDateEnd;





  EventModel({this.id,this.title, this.description, this.eventDateStart,this.eventDateEnd,}):super(id);

  factory EventModel.fromMap(Map data) {
    return EventModel(
      title: data['title'],
      description: data['description'],
      eventDateStart: data['event_date1'],
      eventDateEnd: data['event_date2'],

    );
  }

  factory EventModel.fromDS(String id, Map<String,dynamic> data) {
    return EventModel(
      id: id,
      title: data['title'],
      description: data['description'],
      eventDateStart: data['event_date1'].toDate(),
      eventDateEnd: data['event_date2'].toDate(),
    );
  }


  Map<String,dynamic> toMap() {
    return {
      "title":title,
      "description": description,
      "event_date1":eventDateStart,
      "event_date2":eventDateEnd,
      "id":id,
    };
  }



}




