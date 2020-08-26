import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:aikidoacademyapp/anketa/data_firestore.dart';

class ListOfNames extends StatefulWidget {
  @override
  _ListOfNamesState createState() => _ListOfNamesState();
}

class _ListOfNamesState extends State<ListOfNames> {
  final dbRef = FirebaseDatabase.instance.reference().child("record");

  List<Map<dynamic,dynamic>> lists = List();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Text("Список учасників"),
        ),
        body:

        StreamBuilder(
            stream: dbRef.onValue,
            builder: (context, AsyncSnapshot<Event> snapshot) {
              if (snapshot.hasData) {
                lists.clear();
                DataSnapshot dataValues = snapshot.data.snapshot;
                Map<dynamic, dynamic> values = dataValues.value;
                values.forEach((key, values) {
                  lists.add(values);
                });
                return new ListView.builder(
                    shrinkWrap: true,
                    itemCount: lists.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                            title:Text(lists[index]["Name"], style: TextStyle(height: 2.5, fontSize:20.0),),
                            subtitle:Text(lists[index]['Club'], style: TextStyle(fontSize:16.0),),
                        onTap: (){
//                              Navigator.push(context,
//                              MaterialPageRoute(builder: (context) => DetailPage(snapshot.data[index]['Name']),
//                              )
//                              );
                        },
                      );
                    });
              }
              return CircularProgressIndicator();
            })
    );
  }
}

//class DetailPage extends StatelessWidget {
//
//  List<Map<dynamic,dynamic>> data ;
//  DetailPage ({this.data});
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text(data.name),
//      ),
//    );
//  }
//}
//
