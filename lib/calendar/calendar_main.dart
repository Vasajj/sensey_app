import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:aikidoacademyapp/calendar/event_firestore_service.dart';
import 'package:aikidoacademyapp/calendar/view_event.dart';
import 'package:aikidoacademyapp/calendar/event.dart';

class CalendarMain extends StatefulWidget {
  @override
  _CalendarMainState createState() => _CalendarMainState();
}

class _CalendarMainState extends State<CalendarMain> {
  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;
  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    _events = {};
    _selectedEvents = [];

  }



  Map<DateTime, List<dynamic>> _groupEvents(List<EventModel> allEvents) {
    Map<DateTime, List<dynamic>> data = {};
    allEvents.forEach((event) {
      DateTime _eventDate1 = DateTime(
        event.eventDateStart.year,
        event.eventDateStart.month,
        event.eventDateStart.day,
        12,
      );
      DateTime _eventDate2 = DateTime(
        event.eventDateEnd.year,
        event.eventDateEnd.month,
        event.eventDateEnd.day,
        12,
      );
//      for (int i = 0; i <= _eventDate2.difference(_eventDate1).inDays; i++) {
//        data[DateTime.now()].add(Duration(days: 1));
//      }


      if (data[_eventDate1] == null) data[_eventDate1] = [];
      data[_eventDate1].add(event);
      if (data[_eventDate2] == null) data[_eventDate2] = [];
      data[_eventDate2].add(event);

    });
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Календар'),
          backgroundColor: Colors.deepPurple,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.assignment),
              onPressed: () {
                Navigator.pushNamed(context, '5');
              },
            ),
          ]),
      body: StreamBuilder<List<EventModel>>(
          stream: eventDBS.streamList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<EventModel> allEvents = snapshot.data;
              if (allEvents.isNotEmpty) {
                _events = _groupEvents(allEvents);
              } else {
                _events = {};
                _selectedEvents = [];
              }
            }
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TableCalendar(
                    locale: 'ukr_UA',
                    events: _events,
                    initialCalendarFormat: CalendarFormat.month,
                    calendarStyle: CalendarStyle(
                        canEventMarkersOverflow: true,
                        todayColor: Colors.deepPurple,
                        selectedColor: Theme.of(context).primaryColor,
                        todayStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Colors.white)),
                    headerStyle: HeaderStyle(
                      centerHeaderTitle: true,
                      formatButtonDecoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      formatButtonTextStyle: TextStyle(color: Colors.white),
                      formatButtonShowsNext: false,
                    ),
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    onDaySelected: (date, events) {
                      setState(() {
                        _selectedEvents = events;
                      });
                    },
                    builders: CalendarBuilders(
//                      unavailableDayBuilder: (context, date, events) => Container(
//                          margin: const EdgeInsets.all(4.0),
//                          alignment: Alignment.center,
//                          decoration: BoxDecoration(
//                              color: Colors.green,
//                              borderRadius: BorderRadius.circular(10.0)),
//                          child: Text(
//                            date.day.toString(),
//                            style: TextStyle(color: Colors.white),
//                          )),
                      selectedDayBuilder: (context, date, events) => Container(
                          margin: const EdgeInsets.all(4.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Text(
                            date.day.toString(),
                            style: TextStyle(color: Colors.white),
                          )),
                      todayDayBuilder: (context, date, events) => Container(
                          margin: const EdgeInsets.all(4.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Text(
                            date.day.toString(),
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                    calendarController: _controller,
                  ),
                  ..._selectedEvents.map(
                    (event) => ListTile(
                      title: Text(event.title),
//                      subtitle: Text(event.eventDate.toString()),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EventDetailsPage(
                              event: event,
                            ),
                          ),
                        );
                      },
                      onLongPress: () => onDelete(context, event.id),
                    ),
                  ),],
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
        onPressed: () => Navigator.pushNamed(context, '4'),
      ),
    );
  }
}

void onDelete(BuildContext context, String id) async {
  if (await _showConfirmationDialog(context)) {
    eventDBS.removeItem(id);
  }
}


Future<bool> _showConfirmationDialog(BuildContext context) async {
  return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
        content: Text("Видалити подію?"),
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