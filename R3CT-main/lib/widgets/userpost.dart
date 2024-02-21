// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class UserPost extends StatelessWidget {
  const UserPost({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        crossAxisCount: 3,
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Card(
              shape: Border.all(style: BorderStyle.solid),
              color: Colors.red,
              child: SizedBox.square(
                dimension: 20,
              )),
        ]);
  }
}







/*  */