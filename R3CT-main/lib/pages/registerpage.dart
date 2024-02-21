// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, use_build_context_synchronously

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:aura/pages/loginpage.dart';
import 'package:aura/pages/profile.dart';
import 'package:aura/widgets/genderselect.dart';
import 'package:aura/limitnumber.dart';
import 'package:aura/widgets/minimalbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:email_validator/email_validator.dart';

@override
class Register extends StatefulWidget {
  //Register({super.key});

  @override
  State<Register> createState() => _RegisterState();

  Future<void> signUpUser({
    required String username,
    required String password,
    required String email,
    required String birthdate,
    required String gender,
    required String fullname,
  }) async {
    try {
      final userAttributes = {
        CognitoUserAttributeKey.custom('bio'): 'Nothing To See Here Yet',
        CognitoUserAttributeKey.custom('WishList'): 'https://www.amazon.com',
        CognitoUserAttributeKey.custom('Website'): 'https://www.linktr.ee',
        AuthUserAttributeKey.phoneNumber: '+15555555',
        AuthUserAttributeKey.email: email,
        AuthUserAttributeKey.preferredUsername: username,
        AuthUserAttributeKey.birthdate: birthdate,
        AuthUserAttributeKey.gender: gender,
        AuthUserAttributeKey.givenName: fullname,
      };
      final result = await Amplify.Auth.signUp(
        username: email,
        password: password,
        options: SignUpOptions(
          userAttributes: userAttributes,
        ),
      );

      await _handleSignUpResult(result);
    } on AuthException catch (e) {
      Logger().w('Error signing up user: ${e.message}');
      //error_text = e.message;
    }
  }

  //Handle Code Delivery To Email
  void _handleCodeDelivery(AuthCodeDeliveryDetails codeDeliveryDetails) {
    safePrint(
      'A confirmation code has been sent to ${codeDeliveryDetails.destination}. '
      'Please check your ${codeDeliveryDetails.deliveryMedium.name} for the code.',
    );
  }

  //Handle the sign up result
  Future<void> _handleSignUpResult(SignUpResult result) async {
    switch (result.nextStep.signUpStep) {
      case AuthSignUpStep.confirmSignUp:
        final codeDeliveryDetails = result.nextStep.codeDeliveryDetails!;
        _handleCodeDelivery(codeDeliveryDetails);
        break;
      case AuthSignUpStep.done:
        safePrint('Sign up is complete');

        break;
    }
  }
}

class _RegisterState extends State<Register> {
  var logger = Logger();

//Maybe I should Delete These Later
  final password = TextEditingController();
  final username = TextEditingController();
  final email = TextEditingController();
  final number = TextEditingController();
  final fullname = TextEditingController();
  final String finalcode = '';
  final code1 = TextEditingController();
  final code2 = TextEditingController();
  final code3 = TextEditingController();
  final code4 = TextEditingController();
  final code5 = TextEditingController();
  final code6 = TextEditingController();
  //Date of birth
  final mm = TextEditingController();
  final dd = TextEditingController();
  final yyyy = TextEditingController();

  //Edited Varibles to plug in to Cognito
  var dob = '';
  //edit this later
  var phonenumber_complete = '';
  String confirmationcode = '';
  String name_placeholder = '';
  bool email_error = false;

  // ignore: override_on_non_overriding_member
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    password.dispose();
    username.dispose();
    email.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (BuildContext, Orientation, ScreenType) {
        return MaterialApp(
          theme: ThemeData(
            scaffoldBackgroundColor: Color.fromARGB(255, 48, 68, 67),
          ),
          title: 'Login/Register',
          home: Scaffold(
              //Side Logo Top Left
              body: Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                //Right Purple Boarder
                child: Container(
                  width: 1200,
                  height: 1000,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Color.fromARGB(82, 129, 106, 168)),
                ),
              ),
              //Intro Text
              SizedBox(
                width: 1100,
                height: 599,
                child: Padding(
                  padding: const EdgeInsets.only(left: 100, top: 120),
                  child: DefaultTextStyle(
                    style: TextStyle(
                        fontFamily: 'Rajdhani',
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.amberAccent),
                    child: AnimatedTextKit(
                        isRepeatingAnimation: false,
                        animatedTexts: [
                          TyperAnimatedText(
                              "Sign Up To Support Your Favorite Content Creators\non the Perfect Platform, Built From The Ground Up")
                        ]),
                  ),
                ),
              ),
              //Logo
              Image.asset(
                'assets/images/R3CT-removebg.png',
                opacity: const AlwaysStoppedAnimation(.1),
              ),
              //Log in Sqaure Side Panel
              Padding(
                padding: EdgeInsets.only(left: 1300, top: 10),
                child: SizedBox(
                  width: 350,
                  height: 1000,
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/R3CT-removebg.png',
                      ),
                      Visibility(
                        visible: email_error,
                        child: Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: DefaultTextStyle(
                            style: TextStyle(
                                fontFamily: 'Rajdhani',
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 255, 0, 0)),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: AnimatedTextKit(
                                  isRepeatingAnimation: false,
                                  animatedTexts: [
                                    FadeAnimatedText(
                                        "Email is Not Valid, Lets Try That Again")
                                  ]),
                            ),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 3)),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: TextField(
                            style: TextStyle(color: Colors.yellowAccent),
                            controller: email,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                hintStyle: TextStyle(
                                    color: Color.fromARGB(129, 255, 255, 0)),
                                border: OutlineInputBorder(),
                                hintText: 'Email',
                                fillColor: Colors.greenAccent)),
                      ),
                      Text('ie. useremail@provider.com',
                          style: TextStyle(
                              color: Color.fromARGB(129, 255, 255, 0))),
                      //Full Name
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: TextField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(45),
                              FilteringTextInputFormatter(
                                  r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff][\s])',
                                  allow: false),
                            ],
                            style: TextStyle(color: Colors.yellowAccent),
                            controller: fullname,
                            decoration: InputDecoration(
                                hintStyle: TextStyle(
                                    color: Color.fromARGB(129, 255, 255, 0)),
                                border: OutlineInputBorder(),
                                hintText: 'Full Name',
                                fillColor: Colors.greenAccent)),
                      ),
                      Text(
                          'can be whatever name you want people to see publicly',
                          style: TextStyle(
                              color: Color.fromARGB(129, 255, 255, 0))),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Stack(
                          children: [
                            //Random Boarder to line up the date of birth module
                            TextField(
                                enabled: false,
                                style: TextStyle(color: Colors.yellowAccent),
                                decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                        color:
                                            Color.fromARGB(129, 255, 255, 0)),
                                    border: OutlineInputBorder(),
                                    fillColor: Colors.greenAccent)),
                            //Date of birth goes here
                            Row(
                              children: [
                                SizedBox(
                                  height: 60,
                                  width: 50,
                                  child: TextField(
                                    controller: mm,
                                    keyboardType: TextInputType.number,
                                    //Allowing all characters but emojis(Becuase people are curious)
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(2),
                                      LimitRange(01, 12),
                                    ],
                                    style:
                                        TextStyle(color: Colors.yellowAccent),
                                    decoration: InputDecoration(
                                        hintText: 'MM',
                                        hintStyle: TextStyle(
                                            color: Color.fromARGB(
                                                129, 255, 255, 0))),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 100),
                                  child: SizedBox(
                                    height: 60,
                                    width: 50,
                                    child: TextField(
                                      controller: dd,
                                      keyboardType: TextInputType.number,
                                      //Allowing all characters but emojis(Becuase people are curious)
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(2),
                                        LimitRange(01, 31),
                                      ],
                                      style:
                                          TextStyle(color: Colors.yellowAccent),
                                      decoration: InputDecoration(
                                          hintText: 'DD',
                                          hintStyle: TextStyle(
                                              color: Color.fromARGB(
                                                  129, 255, 255, 0))),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 80),
                                  child: SizedBox(
                                    height: 60,
                                    width: 50,
                                    child: TextField(
                                      controller: yyyy,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(4),
                                        LimitRange(0, 2023),
                                      ],
                                      style:
                                          TextStyle(color: Colors.yellowAccent),
                                      decoration: InputDecoration(
                                          hintText: 'YYYY',
                                          hintStyle: TextStyle(
                                              color: Color.fromARGB(
                                                  129, 255, 255, 0))),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      //Username is here
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: TextField(
                            inputFormatters: [
                              FilteringTextInputFormatter(
                                  r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])',
                                  allow: false),
                              FilteringTextInputFormatter.deny(RegExp(r'\s'))
                            ],
                            style: TextStyle(color: Colors.yellowAccent),
                            controller: username,
                            decoration: InputDecoration(
                                hintStyle: TextStyle(
                                    color: Color.fromARGB(129, 255, 255, 0)),
                                border: OutlineInputBorder(),
                                hintText: 'Username',
                                fillColor: Colors.greenAccent)),
                      ),
                      Text(
                        'can only be changed twice a year ie. @username',
                        style:
                            TextStyle(color: Color.fromARGB(129, 255, 255, 0)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: SizedBox(),
                      ),

                      //Password Here
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: TextField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(20),
                              FilteringTextInputFormatter(
                                  r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])',
                                  allow: false),
                            ],
                            style: TextStyle(color: Colors.yellowAccent),
                            controller: password,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                  color: Color.fromARGB(129, 255, 255, 0)),
                              border: OutlineInputBorder(),
                              hintText: 'Password',
                              fillColor: Colors.greenAccent,
                            )),
                      ),

                      Text('passkey to remember(reset if forgoten)',
                          style: TextStyle(
                              color: Color.fromARGB(129, 255, 255, 0))),

                      Text('Gender',
                          style: TextStyle(
                              color: Color.fromARGB(204, 231, 231, 33),
                              fontSize: 40)),
                      //Gender Name

                      //Gender Select Box
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: RadioExample(),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: MinimalButton(
                            textobject: const Text(
                              'Login',
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Color.fromARGB(255, 255, 200, 0)),
                            ),
                            minimaloutlinewidth: 1.0,
                            minimaloutlinecolor: Color.fromARGB(255, 0, 0, 0),
                            minimalbackgroundcolor:
                                Color.fromARGB(70, 102, 102, 102),
                            minimalshadowcolor: Color.fromARGB(255, 56, 56, 56),
                            shadowheight: 4,
                            minimalbuttonheight: 50,
                            minimalbuttonwidth: 300,
                            onTap: () {
                              //Step 1: Check to see if username and password exist on the databse and cross check passwords sha-5
                              //Step 2: if it exist then send a response to the server that says "let this user in"
                              Navigator.pushReplacement<void, void>(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (context) => Login(),
                                ),
                              );
                            }),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 5,
                        ),
                        //Register Button
                        child: MinimalButton(
                            textobject: const Text(
                              'Register',
                              style: TextStyle(
                                  fontSize: 25, color: Colors.amberAccent),
                            ),
                            minimaloutlinewidth: 1.0,
                            minimaloutlinecolor: Color.fromARGB(255, 0, 0, 0),
                            minimalbackgroundcolor:
                                Color.fromARGB(70, 102, 102, 102),
                            minimalshadowcolor: Color.fromARGB(255, 56, 56, 56),
                            shadowheight: 4,
                            minimalbuttonheight: 50,
                            minimalbuttonwidth: 300,
                            onTap: () async {
                              dob = '${mm.text}/${dd.text}/${yyyy.text}';
                              //phonenumber_complete = '+1${number.text}';
                              logger.d('user date of birth is $dob');
                              logger.d('user gender is $genderstring');

                              if (EmailValidator.validate(email.text) == true) {
                                Register().signUpUser(
                                    username: username.text,
                                    password: password.text,
                                    email: email.text,
                                    birthdate: dob,
                                    gender: genderstring,
                                    fullname: fullname.text);

                                //Security Code Enter Dialog
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        backgroundColor:
                                            Color.fromARGB(220, 162, 127, 168),
                                        actions: <Widget>[
                                          //Submit Buttons
                                          TextButton(
                                            onPressed: () async {},
                                            child: Text(
                                              'Change Email',
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  color: Color.fromARGB(
                                                      255, 255, 200, 0)),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () async {},
                                            child: Text(
                                              'Resend Code',
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  color: Color.fromARGB(
                                                      255, 255, 200, 0)),
                                            ),
                                          ),
                                          //Accept Button
                                          TextButton(
                                            onPressed: () async {
                                              confirmationcode = code1.text +
                                                  code2.text +
                                                  code3.text +
                                                  code4.text +
                                                  code5.text +
                                                  code6.text;
                                              try {
                                                var result = await Amplify.Auth
                                                    .confirmSignUp(
                                                  username: email.text,
                                                  confirmationCode:
                                                      confirmationcode,
                                                );
                                                // Check if further confirmations are needed or if
                                                // the sign up is complete.
                                                await Register()
                                                    ._handleSignUpResult(
                                                        result);
                                                if (result.isSignUpComplete) {
                                                  Navigator.of(context).pop();
                                                  Navigator.pushReplacement<
                                                      void, void>(
                                                    context,
                                                    MaterialPageRoute<void>(
                                                      builder: (context) =>
                                                          Login(),
                                                    ),
                                                  );
                                                }
                                              } on AuthException catch (e) {
                                                safePrint(
                                                    'Error confirming user: ${e.message}');
                                              }
                                            },
                                            child: Text(
                                              'Submit Code',
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  color: Color.fromARGB(
                                                      255, 255, 200, 0)),
                                            ),
                                          )
                                        ],
                                        title: Text(
                                            'Check ${email.text} for your confirmation code'),
                                        content: Row(
                                          children: [
                                            SizedBox(
                                              width: 30,
                                              child: TextField(
                                                inputFormatters: [
                                                  LengthLimitingTextInputFormatter(
                                                      1),
                                                  FilteringTextInputFormatter
                                                      .digitsOnly
                                                ],
                                                keyboardType:
                                                    TextInputType.number,
                                                style: TextStyle(fontSize: 50),
                                                onChanged: (value) {},
                                                controller: code1,
                                                decoration: InputDecoration(
                                                  hintText: "1",
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 60),
                                              child: SizedBox(
                                                width: 30,
                                                child: TextField(
                                                  inputFormatters: [
                                                    LengthLimitingTextInputFormatter(
                                                        1),
                                                    FilteringTextInputFormatter
                                                        .digitsOnly
                                                  ],
                                                  keyboardType:
                                                      TextInputType.number,
                                                  style:
                                                      TextStyle(fontSize: 50),
                                                  onChanged: (value) {},
                                                  controller: code2,
                                                  decoration: InputDecoration(
                                                      hintText: "2"),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 60),
                                              child: SizedBox(
                                                width: 30,
                                                child: TextField(
                                                  inputFormatters: [
                                                    LengthLimitingTextInputFormatter(
                                                        1),
                                                    FilteringTextInputFormatter
                                                        .digitsOnly
                                                  ],
                                                  keyboardType:
                                                      TextInputType.number,
                                                  style:
                                                      TextStyle(fontSize: 50),
                                                  onChanged: (value) {},
                                                  controller: code3,
                                                  decoration: InputDecoration(
                                                      hintText: "3"),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 60),
                                              child: SizedBox(
                                                width: 30,
                                                child: TextField(
                                                  inputFormatters: [
                                                    LengthLimitingTextInputFormatter(
                                                        1),
                                                    FilteringTextInputFormatter
                                                        .digitsOnly
                                                  ],
                                                  keyboardType:
                                                      TextInputType.number,
                                                  style:
                                                      TextStyle(fontSize: 50),
                                                  onChanged: (value) {},
                                                  controller: code4,
                                                  decoration: InputDecoration(
                                                      hintText: "4"),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 60),
                                              child: SizedBox(
                                                width: 30,
                                                child: TextField(
                                                  inputFormatters: [
                                                    LengthLimitingTextInputFormatter(
                                                        1),
                                                    FilteringTextInputFormatter
                                                        .digitsOnly
                                                  ],
                                                  keyboardType:
                                                      TextInputType.number,
                                                  style:
                                                      TextStyle(fontSize: 50),
                                                  onChanged: (value) {},
                                                  controller: code5,
                                                  decoration: InputDecoration(
                                                      hintText: "5"),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 60),
                                              child: SizedBox(
                                                width: 30,
                                                child: TextField(
                                                  inputFormatters: [
                                                    LengthLimitingTextInputFormatter(
                                                        1),
                                                    FilteringTextInputFormatter
                                                        .digitsOnly
                                                  ],
                                                  keyboardType:
                                                      TextInputType.number,
                                                  style:
                                                      TextStyle(fontSize: 50),
                                                  onChanged: (value) {},
                                                  controller: code6,
                                                  decoration: InputDecoration(
                                                      hintText: "6"),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                              } else if (EmailValidator.validate(email.text) ==
                                  false) {
                                logger.d("Email Aint Right Mane");
                                email_error = true;
                                logger.d('the email bool is $email_error');
                                email.clear();
                              }
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
        );
      },
    );
  }
}
