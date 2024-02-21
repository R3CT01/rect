// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously

import 'dart:js';
import 'dart:math';

import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:aura/helpers/prfntydetector.dart';
import 'package:aura/pages/main.dart';
import 'package:aura/pages/profile.dart';
import 'package:aura/pages/registerpage.dart';
import 'package:aura/widgets/errorcode.dart';
import 'package:aura/widgets/minimalbutton.dart';
import 'package:aura/widgets/navpanel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../amplifyconfiguration.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureAmplify();

  //checks for user image

  final AuthSession res = await Amplify.Auth.fetchAuthSession();
  //Checking if User is signed in
  //if not then continue to load user login page
  if (res.isSignedIn == true) {
    Logger().d('User Is Already Signed In');
  }
  if (res.isSignedIn == false) {
    Logger().d('No User Signed In');
  }

  runApp(MaterialApp(
    title: 'Login',
    home: Login(),
  ));
}

//Configure Amplify here
Future<void> configureAmplify() async {
  try {
    final auth = AmplifyAuthCognito();
    final storage = AmplifyStorageS3();
    await Amplify.addPlugins([auth, storage]);

    // call Amplify.configure to use the initialized categories in your app
    await Amplify.configure(amplifyconfig);
  } on Exception catch (e) {
    Logger().e('An error occurred configuring Amplify: $e');
  }
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool iserror = false;

  //text controllers for usernsme and password
  final password_con = TextEditingController();
  final username_con = TextEditingController();
  String errortext = '';
  bool isbuttonenabled = true;
  Future<bool> isUserSignedIn() async {
    final result = await Amplify.Auth.fetchAuthSession();
    return result.isSignedIn;
  }

  Future<void> SignInUser(String username, String password) async {}

  Future<void> signinUser(BuildContext contextobject) async {
    final AuthSession res = await Amplify.Auth.fetchAuthSession();
    try {
      SignInResult res = await Amplify.Auth.signIn(
        username: username_con.text,
        password: password_con.text,
      );

      if (res.isSignedIn == true) {
        Navigator.pushReplacement<void, void>(
          contextobject,
          MaterialPageRoute<void>(
            builder: (contextobject) => Profile(),
          ),
        );
      }
      if (res.isSignedIn == false) {
        Logger().d('User Does Not Exist Or Credentials Are Incorrect');
        password_con.clear();
      }
    } on AuthException catch (e) {
      Logger().w(e.message);
      if (mounted) {
        setState(() {
          errortext = e.message;
          iserror = true;
        });
      }

      Future.delayed(Duration(seconds: 10), () {
        setState(() {
          if (iserror == true) {
            iserror = false;
          }
        });
      });
      password_con.clear();
      username_con.clear();
      //Uncomment This For Debugging
      /* Navigator.pushReplacement<void, void>(
                              context,
                              MaterialPageRoute<void>(
                                builder: (context) => Profile(),
                              ),
                            );*/
    }
  }

  //const Login({super.key});
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final AuthSession res = await Amplify.Auth.fetchAuthSession();
      if (res.isSignedIn) {
        Navigator.pushReplacement<void, void>(
          context,
          MaterialPageRoute<void>(
            builder: (context) => Profile(),
          ),
        );
      }
      if (res.isSignedIn == false) {
        Logger().d('User is not signed in Please Log In Again Or Register');
      }
    });
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromARGB(255, 95, 95, 95),
      ),
      title: 'Login/Register',
      home: Scaffold(
          //Side Logo Top Left
          body: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: 1100,
              height: 1000,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  color: Color.fromARGB(97, 20, 22, 21)),
            ),
          ),
          //Intro Text
          SizedBox(
            width: 1100,
            height: 599,
            child: Padding(
              padding: const EdgeInsets.only(left: 100, top: 120),
            ),
          ),
          //Logo
          Image.asset(
            'assets/images/R3CT-removebg.png',
            opacity: const AlwaysStoppedAnimation(.1),
          ),
          //Log in
          Padding(
            padding: EdgeInsets.only(left: 1300, top: 200),
            child: SizedBox(
              width: 250,
              height: 500,

              //Login Column Here
              child: Column(
                children: [
                  //Error
                  InkWell(
                    splashColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    onTap: () => setState(() {
                      iserror = false;
                    }),
                    child: ErrorCodes(
                      errortext: errortext,
                      isvisible: iserror,
                      textstyle: TextStyle(
                        fontSize: 19,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                  Image.asset(
                    'assets/images/R3CT-removebg.png',
                    scale: 1,
                  ),
                  TextField(
                      style:
                          TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                      controller: username_con,
                      maxLength: 90,
                      decoration: InputDecoration(
                          hoverColor: const Color.fromARGB(255, 221, 221, 25),
                          hintStyle: TextStyle(
                              color: Color.fromARGB(228, 255, 255, 0)),
                          border: OutlineInputBorder(),
                          hintText: 'Username Or Email',
                          fillColor: Color.fromARGB(255, 255, 252, 61))),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: TextField(
                        style: TextStyle(color: Colors.yellowAccent),
                        controller: password_con,
                        obscureText: true,
                        decoration: InputDecoration(
                            hintStyle: TextStyle(
                                color: Color.fromARGB(129, 255, 255, 0)),
                            border: OutlineInputBorder(),
                            hintText: 'Password',
                            fillColor: Colors.greenAccent)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 9),
                    //Login Button Here
                    child: MinimalButton(
                        minimaloutlinewidth: 1.0,
                        minimaloutlinecolor: Color.fromARGB(255, 0, 0, 0),
                        minimalbackgroundcolor:
                            Color.fromARGB(70, 102, 102, 102),
                        minimalshadowcolor: Color.fromARGB(255, 56, 56, 56),
                        shadowheight: 4,
                        minimalbuttonheight: 50,
                        minimalbuttonwidth: 300,
                        textobject: Text(
                          'Login',
                          style: TextStyle(
                              color: Color.fromARGB(255, 201, 255, 75),
                              fontFamily: 'RobotoFlex',
                              fontSize: 27),
                        ),
                        onTap: () async {
                          //Send Username and password info to server
                          //if its correct redirect to Profile Page
                          signinUser(context);
                        }),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 17),
                    child: Theme(
                      data: ThemeData(
                          splashColor: Color.fromARGB(104, 187, 247, 76)),
                      child: MinimalButton(
                          minimaloutlinewidth: 1.0,
                          minimaloutlinecolor: Color.fromARGB(255, 0, 0, 0),
                          minimalbackgroundcolor:
                              Color.fromARGB(70, 102, 102, 102),
                          minimalshadowcolor: Color.fromARGB(255, 56, 56, 56),
                          shadowheight: 4,
                          minimalbuttonheight: 50,
                          minimalbuttonwidth: 300,
                          textobject: Text(
                            'Register',
                            style: TextStyle(
                                color: Color.fromARGB(255, 201, 255, 75),
                                fontFamily: 'RobotoFlex',
                                fontSize: 27),
                          ),
                          onTap: () {
                            Navigator.pushReplacement<void, void>(
                              context,
                              MaterialPageRoute<void>(
                                builder: (context) => Register(),
                              ),
                            );
                          }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
