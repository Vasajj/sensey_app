import 'package:flutter/material.dart';

class EnterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Color(0xFF503740), Color(0xff4B3290)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
              ),
              child: ConstrainedBox(
                  constraints: BoxConstraints.expand(),
                  child: FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '2');
                      },
                      padding: EdgeInsets.all(0.0),
                      child: Image.asset('images/AAA logo w-01.png'))))),
    );
  }
}