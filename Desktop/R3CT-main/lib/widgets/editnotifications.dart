// ignore_for_file: prefer_const_constructors

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:aura/pages/profile.dart';
import 'package:aura/widgets/minimalbutton.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

class EditNotifications extends StatelessWidget {
  final username = TextEditingController();
  final fullname = TextEditingController();
  final bio = TextEditingController();
  final website = TextEditingController();
  final amazonwishlist = TextEditingController();
  EditNotifications({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 999,
      height: 700,
      child: ListView(scrollDirection: Axis.vertical, children: [
        Padding(
          padding: const EdgeInsets.only(left: 19),
          child: Container(
            width: 999,
            height: 260,
            decoration: BoxDecoration(
                border: Border.all(
                    color: Color.fromRGBO(230, 217, 39, 0.514), width: 3)),
            child:
                Image(fit: BoxFit.fill, image: AssetImage('backgroundimage')),
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: TextField(
              maxLength: 20,
              maxLines: 1,
              inputFormatters: [
                FilteringTextInputFormatter(
                    r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])',
                    allow: false),
                FilteringTextInputFormatter.deny(RegExp(r'\s'))
              ],
              style: TextStyle(color: Colors.yellowAccent),
              controller: username,
              decoration: InputDecoration(
                  labelText: 'Username',
                  labelStyle: TextStyle(color: Colors.yellowAccent),
                  hintStyle: TextStyle(color: Color.fromARGB(129, 255, 255, 0)),
                  border: OutlineInputBorder(),
                  hintText: 'Username',
                  fillColor: Colors.greenAccent)),
        ),
        //Full Name
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: TextField(
              maxLength: 30,
              maxLines: 1,
              inputFormatters: [
                FilteringTextInputFormatter(
                    r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])',
                    allow: false),
              ],
              style: TextStyle(color: Colors.yellowAccent),
              controller: fullname,
              decoration: InputDecoration(
                  labelText: 'Display Name',
                  labelStyle: TextStyle(color: Colors.yellowAccent),
                  hintStyle: TextStyle(color: Color.fromARGB(129, 255, 255, 0)),
                  border: OutlineInputBorder(),
                  hintText: 'Display Name',
                  fillColor: Colors.greenAccent)),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: TextField(
              maxLength: 1000,
              maxLines: null,
              inputFormatters: [
                FilteringTextInputFormatter(
                    r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])',
                    allow: false),
              ],
              style: TextStyle(color: Colors.yellowAccent),
              controller: bio,
              decoration: InputDecoration(
                  labelText: 'Bio',
                  labelStyle: TextStyle(color: Colors.yellowAccent),
                  hintStyle: TextStyle(color: Color.fromARGB(129, 255, 255, 0)),
                  border: OutlineInputBorder(),
                  hintText: 'Put Something Nice Here, Like Where Are You From?',
                  fillColor: Colors.greenAccent)),
        ),
        //Wishlist Link
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: TextField(
              maxLength: 500,
              maxLines: 1,
              inputFormatters: [
                FilteringTextInputFormatter(
                    r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])',
                    allow: false),
                FilteringTextInputFormatter.deny(RegExp(r'\s'))
              ],
              style: TextStyle(color: Colors.yellowAccent),
              controller: amazonwishlist,
              decoration: InputDecoration(
                  labelText: 'Amazon Wishlist Link',
                  labelStyle: TextStyle(color: Colors.yellowAccent),
                  hintStyle: TextStyle(color: Color.fromARGB(129, 255, 255, 0)),
                  border: OutlineInputBorder(),
                  hintText: 'Maybe You Need Some New Shoes?',
                  fillColor: Colors.greenAccent)),
        ),

        //Website
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: TextField(
              maxLength: 1000,
              maxLines: 1,
              inputFormatters: [
                FilteringTextInputFormatter(
                    r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])',
                    allow: false),
                FilteringTextInputFormatter.deny(RegExp(r'\s'))
              ],
              style: TextStyle(color: Colors.yellowAccent),
              controller: website,
              decoration: InputDecoration(
                  labelText: 'Website',
                  labelStyle: TextStyle(color: Colors.yellowAccent),
                  hintStyle: TextStyle(color: Color.fromARGB(129, 255, 255, 0)),
                  border: OutlineInputBorder(),
                  hintText: 'Your Cool Little Website Goes Here...',
                  fillColor: Colors.greenAccent)),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: MinimalButton(
            minimalbuttonheight: 50,
            minimalbuttonwidth: 300,
            minimaloutlinewidth: 1.0,
            minimaloutlinecolor: Color.fromARGB(255, 0, 0, 0),
            minimalbackgroundcolor: Color.fromARGB(70, 102, 102, 102),
            minimalshadowcolor: Color.fromARGB(255, 56, 56, 56),
            shadowheight: 4,
            textobject: const Text(
              'Privacy',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.yellowAccent,
                  fontFamily: 'Roboto'),
            ),
            onTap: () {},
          ),
        )
      ]),
    );
  }
}
