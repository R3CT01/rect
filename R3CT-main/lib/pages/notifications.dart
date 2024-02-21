// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:aura/widgets/navpanel.dart';
import 'package:flutter/material.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Notifications',
        home: Scaffold(
          body: Row(children: [
            SingleChildScrollView(child: NavPanel()),
            Padding(padding: EdgeInsets.only(left: 90)),
          ]),
        ));
  }
}
