import 'package:flutter/material.dart';
import 'package:aikidoacademyapp/calendar/event.dart';
import 'package:aikidoacademyapp/calendar/event_firestore_service.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;

class AddEventPage extends StatefulWidget {
  final EventModel note;

  const AddEventPage({
    Key key,
    this.note,
  }) : super(key: key);

  @override
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  TextEditingController _title;
  TextEditingController _description;
  DateTime _eventDate1 = DateTime.now();
  DateTime _eventDate2 = DateTime.now().add(new Duration(days: 3));

  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  bool processing;
  bool _editMode;

  @override
  void initState() {
    super.initState();
    _editMode = widget.note != null;
    _title = TextEditingController(text: _editMode ? widget.note.title : null);
    _description =
        TextEditingController(text: _editMode ? widget.note.description : null);
    _eventDate1 = DateTime.now();
    _eventDate2 = DateTime.now().add(new Duration(days: 3));
    processing = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title:
            Text(widget.note != null ? "Відредагувати подію" : "Додати подію"),
      ),
      key: _key,
      body: Form(
        key: _formKey,
        child: Container(
          alignment: Alignment.center,
          child: ListView(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextFormField(
                  controller: _title,
                  validator: (value) => (value.isEmpty) ? "Введіть тему" : null,
                  style: style,
                  decoration: InputDecoration(
                      labelText: "Тема",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextFormField(
                  controller: _description,
                  minLines: 3,
                  maxLines: 20,
                  validator: (value) => (value.isEmpty) ? "Введіть опис" : null,
                  style: style,
                  decoration: InputDecoration(
                      labelText: "Опис",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              const SizedBox(height: 10.0),
              ListTile(
                title: Text("Дата початку та завершення події"),
                subtitle: Text("${(_eventDate1)} - ${(_eventDate2)} "),
                onTap: () async {
                  final List<DateTime> picked =
                      await DateRagePicker.showDatePicker(
                    context: context,
//                      locale: Locale('en_Gb'),
                        initialFirstDate: _eventDate1,
                    initialLastDate: _eventDate2,
                    firstDate: new DateTime(2019),
                    lastDate: new DateTime(2030),
                  );
                  if (picked != null && picked.length == 2) {
                    picked.forEach((event) {
                      setState(() {
                        _eventDate1 = picked[0];
                        _eventDate2 = picked[1];
                      });
                    });
                  }
                },
              ),
              SizedBox(height: 10.0),
              processing
                  ? Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(30.0),
                        color: Colors.deepPurple,
                        child: MaterialButton(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                processing = true;
                              });
                              if (widget.note != null) {
                                await eventDBS.updateData(widget.note.id, {
                                  "title": _title.text,
                                  "description": _description.text,
                                  "event_date1": widget.note.eventDateStart,
                                  "event_date2": widget.note.eventDateEnd,
                                });
                              } else {
                                await eventDBS.createItem(EventModel(
                                  title: _title.text,
                                  description: _description.text,
                                  eventDateStart: _eventDate1,
                                  eventDateEnd: _eventDate2,
                                ));
                              }
                              Navigator.pop(context);
                              setState(() {
                                processing = false;
                              });
                            }
                          },
                          child: Text(
                            "Зберегти",
                            style: style.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    super.dispose();
  }
}

//DateTime picked = await showDatePicker(
//context: context,
//initialDate: _eventDate,
//firstDate: DateTime(_eventDate.year - 5),
//lastDate: DateTime(_eventDate.year + 10),
////                      locale: Locale('ukr_UA'),
//);
//if (picked != null) {
//setState(() {
//_eventDate = picked;
//});
//}
