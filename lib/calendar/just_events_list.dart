import 'package:flutter/material.dart';
import 'package:aikidoacademyapp/calendar/note_item.dart';

import 'package:aikidoacademyapp/calendar/event_firestore_service.dart';
import 'package:aikidoacademyapp/calendar/view_event.dart';
import 'package:aikidoacademyapp/calendar/event.dart';
import 'package:aikidoacademyapp/calendar/add_event.dart';


class NotesHomePage extends StatelessWidget {
//  final list = [
//    DateTime.now(),
//    DateTime.now().subtract(Duration(days: 1)),
//    DateTime.now().subtract(Duration(days: 2)),
//    DateTime.now().subtract(Duration(days: 3)),
//  ];
//
//  //Order By Descending
//  list.sort((a, b) => a.isAfter(b) ? -1 : 1);
//
//  //Order By Ascending
//  list.sort((a, b) => a.isBefore(b) ? -1 : 1);
//
//  for (var item in list) {
//  print(item);
//  }


@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text("Події"),
              ),
      body: StreamBuilder(
        stream: eventDBS.streamList(),
        builder: (BuildContext context, AsyncSnapshot<List<EventModel>> snapshot) {
          if (snapshot.hasError)
            return Center(
              child: Text("Виникла помилка"),
            );
          if (!snapshot.hasData) return CircularProgressIndicator();

          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return NoteItem(
                  note: snapshot.data[index],
                  onDelete: (note) async {
                    if (await _confirmDelete(context)) {
                      eventDBS.removeItem(note.id);
                    }
                  },
                  onTap: (event) => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EventDetailsPage(
                          event: event,
                        ),
                      )),
                  onEdit: (event) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AddEventPage(
                            note: event,
                          ),
                        ));
                  },
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
        onPressed: () => Navigator.pushNamed(context, '4'),
      ),
    );
  }

  Future<bool> _confirmDelete(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Видалити подію"),
//          content: Text("Are you sure you want to delete?"),
          actions: <Widget>[
            FlatButton(
              child: Text("Ні"),
              onPressed: () => Navigator.pop(context, false),
            ),
            FlatButton(
              child: Text("Так"),
              onPressed: () => Navigator.pop(context, true),
            ),
          ],
        ));
  }
}
