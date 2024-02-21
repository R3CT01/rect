// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:aura/widgets/navpanel.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: Color.fromARGB(255, 52, 46, 56),
        ),
        title: 'Profile',
        home: Scaffold(
          body: Row(children: [
            SingleChildScrollView(child: NavPanel()),
            Padding(
                padding: EdgeInsets.only(
              left: 40,
            )),
            SizedBox(
              width: 500,
              height: 500,
              child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter a Username',
                      fillColor: Colors.greenAccent)),
            ),
          ]),
        ));
  }
}
