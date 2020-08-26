import 'package:flutter/material.dart';
import 'package:aikidoacademyapp/calendar/event.dart';
import 'package:aikidoacademyapp/calendar/add_event.dart';
import 'package:link_text/link_text.dart';


class EventDetailsPage extends StatelessWidget {
  final EventModel event;

  const EventDetailsPage({Key key, this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Перегляд події'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              event.title,
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(height: 20.0),
//            SelectableText(
//              event.description,
//            )
            LinkText(
              text: event.description,
              textAlign: TextAlign.start
            ),
            SizedBox(height: 20.0),
//            SelectableText(
//              event.description,
//            )
            LinkText(
                text: event.eventDateStart.toString(),
                textAlign: TextAlign.start
            ),
            LinkText(
                text: event.eventDateEnd.toString(),
                textAlign: TextAlign.start
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit),
        backgroundColor: Colors.deepPurple,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddEventPage(
                note: event,
              ),
            ),
          );
        },
      ),
    );
  }
}
