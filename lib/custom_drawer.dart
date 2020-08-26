import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final Function closeDrawer;

  const CustomDrawer({Key key, this.closeDrawer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Container(
      color: Colors.deepPurple,
      width: mediaQuery.size.width * 0.60,
      height: mediaQuery.size.height,
      child: Column(
        children: <Widget>[
          Container(
              width: double.infinity,
              height: 200,
              color: Colors.grey.withAlpha(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'images/AAA logo w-01.png',
                    width: 180,
                    height: 180,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              )),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, '3');
            },
            leading: Icon(Icons.calendar_today, color: Colors.white,),
            title: Text(
              "Календар", style: TextStyle(color: Colors.white),
            ),

          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, '6');
            },
            leading: Icon(Icons.event, color: Colors.white,),
            title: Text(
              "Список учасників", style: TextStyle(color: Colors.white),
            ),

          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, '7');
            },
            leading: Icon(Icons.bookmark_border, color: Colors.white,),
            title: Text("Атестаційна програма", style: TextStyle(color: Colors.white),),
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            onTap: () {
              debugPrint("Tapped Payments");
            },
            leading: Icon(Icons.assignment_turned_in, color: Colors.white,),
            title: Text("Відвідані семінари", style: TextStyle(color: Colors.white),),
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            onTap: () {
              debugPrint("Tapped Notifications");
            },
            leading: Icon(Icons.notifications, color: Colors.white,),
            title: Text("Корисна інформація", style: TextStyle(color: Colors.white),),
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            onTap: () {
              debugPrint("Tapped Log Out");
            },
            leading: Icon(Icons.exit_to_app, color: Colors.white,),
            title: Text("Вихід", style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
    );
  }
}
