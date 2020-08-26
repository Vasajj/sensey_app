import 'package:aikidoacademyapp/calendar/calendar_main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'enter_page.dart';
import 'first_screen.dart';
import 'calendar/calendar_main.dart';
import 'package:aikidoacademyapp/calendar/add_event.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'calendar/just_events_list.dart';
import 'anketa/list_of_data.dart';
import 'package:aikidoacademyapp/ExamProgram/all.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(MaterialApp(
        initialRoute: '1',
        routes: {
          '1': (context) => EnterPage(),
          '2': (context) => PassportPage(),
          '3': (context) => CalendarMain(),
          '4': (context) => AddEventPage(),
          '5': (context) => NotesHomePage(),
          '6': (context) => Anketa(),
          '7': (context) => HorizontalList(),
        },
      )));
}
