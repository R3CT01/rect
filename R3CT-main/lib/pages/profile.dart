// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:aura/helpers/storageupload.dart';
import 'package:aura/pages/registerpage.dart';
import 'package:aura/pages/usersettingsprofile.dart';
import 'package:aura/widgets/navpanel.dart';
import 'package:aura/widgets/userpost.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:logger/logger.dart';

String usersub = '';
String fullnamedisplay = '';
String usernamedisplay = '';
String newusername = '';
String newuserbio = '';
String newusernumber = '';
String newuserwebsite = '';
String newuseramazonlink = '';
String newuseremail = '';
String username = '';
String userbio = '';
String usernumber = '';
String userwebsite = '';
String useramazonlink = '';
String useremail = '';
String userimage =
    'https://rectuserstorage44431-staging.s3.us-west-1.amazonaws.com/protected/us-west-1%3Acf8a3483-26f2-cf21-70e4-463a087f4908/chiave13/profileimages/Logo.png';
String backgroundimage = '../assets/images/defaultuserbackgrnd.png';

class Profile extends StatefulWidget {
  Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final int number_of_follwers = 0;

  final int number_of_following = 0;

  getUserAtrib() async {
    final result = await Amplify.Auth.fetchUserAttributes();
    int index = 0;
    for (final element in result) {
      index++;

      // Logger().d(element.value);
    }
    //Logger().d(userbio);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        final result = await Amplify.Auth.fetchUserAttributes();
        int index = 0;
        for (final element in result) {
          index++;
          //Logger().d(result[index].value);
          if (index == 1 && mounted) {
            setState(() {
              usersub = result[index].value;
            });
            Logger().d('Value Of User Bio Is: $usersub');
          }
          if (index == 7 && mounted) {
            setState(() {
              userbio = result[index].value;
            });
            //Logger().d('Value Of User Bio Is: $userbio');
          }

          if (index == 9 && mounted) {
            setState(() {
              usernumber = result[index].value;
            });
            // Logger().d('Value Of User Number Is: $usernumber');
          }

          if (index == 5 && mounted) {
            setState(() {
              usernamedisplay = result[index].value;
            });
          }

          if (index == 6 && mounted) {
            setState(() {
              fullnamedisplay = result[index].value;
            });
          }
          //8 is website
          if (index == 10 && mounted) {
            setState(() {
              useremail = result[index].value;
            });
            //Logger().d('Value Of User Bio Is: $userbio');
          }
          if (index == 11 && mounted) {
            setState(() {
              useramazonlink = result[index].value;
            });
            //Logger().d('Value Of User Bio Is: $userbio');
          }

          if (index == 8 && mounted) {
            setState(() {
              userwebsite = result[index].value;
            });
            //Logger().d('Value Of User Bio Is: $userbio');
          }
        }
      } on AuthException catch (e) {
        safePrint('Error fetching user attributes: ${e.message}');
      }
    });
    return MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: Color.fromARGB(255, 66, 66, 66),
        ),
        title: 'Profile',
        home: Scaffold(
          backgroundColor: Color.fromARGB(255, 49, 49, 49),
          body: Container(
            decoration:
                BoxDecoration(border: Border.all(style: BorderStyle.solid)),
            child: Row(children: [
              SingleChildScrollView(
                  clipBehavior: Clip.hardEdge, child: NavPanel()),
              Padding(
                padding: EdgeInsets.only(
                  left: 150,
                ),
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: 200),
                  scrollDirection: Axis.vertical,
                  child: Stack(
                    children: [
                      //Background Image Here
                      Padding(
                        padding: const EdgeInsets.only(left: 19),
                        child: Container(
                          width: 999,
                          height: 260,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                  width: 3,
                                  color: Color.fromARGB(242, 97, 97, 97))),
                          child: Image(
                              fit: BoxFit.fill,
                              image: AssetImage(backgroundimage)),
                        ),
                      ),

                      //Edit Profile Button
                      Padding(
                        padding: EdgeInsets.only(top: 220, left: 867),
                        child: Bounceable(
                          scaleFactor: 0.4,
                          onTap: () {
                            Navigator.pushReplacement<void, void>(
                              context,
                              MaterialPageRoute<void>(
                                builder: (context) => UserSettingsProfile(),
                              ),
                            );
                            //getUserAtrib();
                          },
                          child: Text(
                            'Edit Profile',
                            style: TextStyle(
                                fontSize: 30,
                                color: Color.fromARGB(255, 83, 153, 90)),
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 160, right: 10),

                          //Profile Image Goes Here
                          child: CircleAvatar(
                            backgroundColor: Color.fromARGB(255, 232, 193, 255),
                            radius: 60,
                            child: Image(image: NetworkImage(userimage)),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(top: 260, left: 500),
                        child:
                            Text('Followers ${number_of_follwers.toString()}',
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Color.fromARGB(255, 166, 255, 175),
                                )),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 260, left: 150),
                        child: Text(fullnamedisplay,
                            style: TextStyle(
                              fontSize: 40,
                              color: Color.fromARGB(255, 166, 255, 175),
                            )),
                      ),
                      //Username
                      Padding(
                        padding: const EdgeInsets.only(top: 307, left: 150),
                        child: Text('@$usernamedisplay',
                            style: TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(255, 166, 255, 175),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 260, left: 700),
                        child:
                            Text('Following ${number_of_following.toString()}',
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Color.fromARGB(255, 166, 255, 175),
                                )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 400, left: 30),
                        child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    style: BorderStyle.solid,
                                    color: Colors.white)),
                            height: 800,
                            width: 1000,
                            child: UserPost()),
                      )
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ));
  }
}
