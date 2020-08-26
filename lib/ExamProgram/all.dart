import 'package:flutter/material.dart';


class HorizontalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TabBarDemo(),
    );
  }
}

class TabBarDemo extends StatefulWidget {
  @override
  _TabBarDemoState createState() => _TabBarDemoState();
}

class _TabBarDemoState extends State<TabBarDemo>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  int _selectedIndex = 0;

  List<Widget> list = [
    Tab(text: "10 к'ю", ),
    Tab(text: "9 к'ю"),
    Tab(text: "8 к'ю"),
    Tab(text: "7 к'ю"),
    Tab(text: "6 к'ю"),
    Tab(text: "5 к'ю"),
    Tab(text: "4 к'ю"),
    Tab(text: "3 к'ю"),
    Tab(text: "2 к'ю"),
    Tab(text: "1 к'ю"),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Create TabController for getting the index of current tab
    _controller = TabController(length: list.length, vsync: this);

    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
      });
      print("Selected Index: " + _controller.index.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          bottom: TabBar(
            onTap: (index) {
              // Should not used it as it only called when tab options are clicked,
              // not when user swapped
            },
            controller: _controller,
            tabs: list,
          ),
          title: Text('Атестаційна програма'),
        ),
        body: TabBarView(
          controller: _controller,
          children: [
            Center(
                child: Text(
                  _selectedIndex.toString(),
                  style: TextStyle(fontSize: 60),
                )),
            Center(
                child: Text(
                  _selectedIndex.toString(),
                  style: TextStyle(fontSize: 60),
                )),
            Center(
                child: Text(
                  _selectedIndex.toString(),
                  style: TextStyle(fontSize: 60),
                )),
            Center(
                child: Text(
                  _selectedIndex.toString(),
                  style: TextStyle(fontSize: 60),
                )),
            Center(
                child: Text(
                  _selectedIndex.toString(),
                  style: TextStyle(fontSize: 60),
                )),
            Center(
                child: Text(
                  _selectedIndex.toString(),
                  style: TextStyle(fontSize: 60),
                )),
            Center(
                child: Text(
                  _selectedIndex.toString(),
                  style: TextStyle(fontSize: 60),
                )),
            Center(
                child: Text(
                  _selectedIndex.toString(),
                  style: TextStyle(fontSize: 60),
                )),
            Center(
                child: Text(
                  _selectedIndex.toString(),
                  style: TextStyle(fontSize: 60),
                )),
            Center(
                child: Text(
                  _selectedIndex.toString(),
                  style: TextStyle(fontSize: 60),
                )),
          ],
        ),
      ),
    );
  }
}


//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//
//
//
//class HorizontalList extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    final title = 'Екзаменаційна програма';
//
//    return MaterialApp(
//      title: title,
//      home: Scaffold(
//        appBar: AppBar(
//          title: Text(title),
//        ),
//        body: Column(
//          children: <Widget>[
//            Container(
//              color: Colors.deepPurpleAccent,
//              margin: EdgeInsets.symmetric(vertical: 20.0),
//              height: 200.0,
//              child: ListView(
//                scrollDirection: Axis.horizontal,
//                children: <Widget>[
//                  MaterialButton(
//                    onPressed: () {},
//                    color: Colors.white,
//                    textColor: Colors.black,
//                    padding: EdgeInsets.all(75),
//                    shape: CircleBorder(),
//                    child: Text('10', style: TextStyle(fontSize: 40.0),),
//                  ),
//                  MaterialButton(
//                    onPressed: () {},
//                    color: Colors.white,
//                    textColor: Colors.black,
//                    padding: EdgeInsets.all(75),
//                    shape: CircleBorder(),
//                    child: Text('9', style: TextStyle(fontSize: 40.0),),
//                  ),
//                  MaterialButton(
//                    onPressed: () {},
//                    color: Colors.white,
//                    textColor: Colors.black,
//                    padding: EdgeInsets.all(75),
//                    shape: CircleBorder(),
//                    child: Text('8', style: TextStyle(fontSize: 40.0),),
//                  ),
//                  MaterialButton(
//                    onPressed: () {},
//                    color: Colors.white,
//                    textColor: Colors.black,
//                    padding: EdgeInsets.all(75),
//                    shape: CircleBorder(),
//                    child: Text('7', style: TextStyle(fontSize: 40.0),),
//                  ),
//                  MaterialButton(
//                    onPressed: () {},
//                    color: Colors.white,
//                    textColor: Colors.black,
//                    padding: EdgeInsets.all(75),
//                    shape: CircleBorder(),
//                    child: Text('6', style: TextStyle(fontSize: 40.0),),
//                  ),
//                  MaterialButton(
//                    onPressed: () {},
//                    color: Colors.yellow,
//                    textColor: Colors.black,
//                    padding: EdgeInsets.all(75),
//                    shape: CircleBorder(),
//                    child: Text('5', style: TextStyle(fontSize: 40.0),),
//                  ),
//                  MaterialButton(
//                    onPressed: () {},
//                    color: Colors.deepOrange,
//                    textColor: Colors.black,
//                    padding: EdgeInsets.all(75),
//                    shape: CircleBorder(),
//                    child: Text('4', style: TextStyle(fontSize: 40.0),),
//                  ),
//                  MaterialButton(
//                    onPressed: () {},
//                    color: Colors.green,
//                    textColor: Colors.black,
//                    padding: EdgeInsets.all(75),
//                    shape: CircleBorder(),
//                    child: Text('3', style: TextStyle(fontSize: 40.0),),
//                  ),
//                  MaterialButton(
//                    onPressed: () {},
//                    color: Colors.blue,
//                    textColor: Colors.black,
//                    padding: EdgeInsets.all(75),
//                    shape: CircleBorder(),
//                    child: Text('2', style: TextStyle(fontSize: 40.0),),
//                  ),
//                  MaterialButton(
//                    onPressed: () {},
//                    color: Colors.brown,
//                    textColor: Colors.black,
//                    padding: EdgeInsets.all(75),
//                    shape: CircleBorder(),
//                    child: Text('1', style: TextStyle(fontSize: 40.0),),
//                  ),
//                ],
//              ),
//            ),
//            ListView.builder(
//              shrinkWrap: true,
//              itemBuilder: (ctx,int){
//                return Card(
//                  child: ListTile(
//                      title: Text('Motivation $int'),
//                      subtitle: Text('this is a description of the motivation')),
//                );
//              },
//            ),
//          ],
//        ),
//
//
//      ),
//      );
//  }
//}


