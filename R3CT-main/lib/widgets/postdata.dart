// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class DataPost extends StatelessWidget {
  const DataPost({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 700,
      height: 1400,
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          //First 20 Post

          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 60, left: 50),
                child: Text('User',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w200,
                        fontSize: 20)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 43),
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Color.fromARGB(255, 255, 1, 1),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 90),
                child: Container(
                  width: 700,
                  height: 700,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 100, bottom: 3),
            child: Container(
              width: 700,
              height: 700,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
            ),
          ),
        ],
      ),
    );
  }
}
