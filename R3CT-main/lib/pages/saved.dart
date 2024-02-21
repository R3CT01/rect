// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:aura/widgets/navpanel.dart';
import 'package:flutter/material.dart';

class Saved extends StatelessWidget {
  const Saved({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: Color.fromARGB(255, 52, 46, 56),
        ),
        title: 'Saved',
        home: Scaffold(
          body: Row(children: [
            SingleChildScrollView(child: NavPanel()),
            Padding(padding: EdgeInsets.only(left: 90)),
          ]),
        ));
  }
}
