// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:aura/widgets/navpanel.dart';
import 'package:aura/widgets/postdata.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromARGB(255, 52, 46, 56),
      ),
      home: Scaffold(
          body: Row(children: [
        SingleChildScrollView(child: NavPanel()),
        Padding(
          padding: EdgeInsets.only(left: 90),
          child: DataPost(),
        ),
      ])),
    );
  }
}
