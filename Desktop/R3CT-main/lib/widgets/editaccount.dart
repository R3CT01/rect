// ignore_for_file: prefer_const_constructors

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:aura/pages/profile.dart';
import 'package:aura/widgets/minimalbutton.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

class EditAccount extends StatefulWidget {
  EditAccount({super.key});

  @override
  State<EditAccount> createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  final email = TextEditingController(text: useremail);
  final number = TextEditingController(text: usernumber);

  bool profilehaschanged = false;

  void _handleCodeDelivery(AuthCodeDeliveryDetails codeDeliveryDetails) {
    safePrint(
      'A confirmation code has been sent to ${codeDeliveryDetails.destination}. '
      'Please check your ${codeDeliveryDetails.deliveryMedium.name} for the code.',
    );
  }

  Future<void> updateUserEmail() async {
    try {
      final result = await Amplify.Auth.updateUserAttribute(
        userAttributeKey: AuthUserAttributeKey.email,
        value: newuseremail,
      );
      _handleUpdateUserEmaileResult(result);
    } on AuthException catch (e) {
      safePrint('Error updating user attribute: ${e.message}');
    }
  }

  void _handleUpdateUserEmaileResult(
    UpdateUserAttributeResult result,
  ) {
    switch (result.nextStep.updateAttributeStep) {
      case AuthUpdateAttributeStep.confirmAttributeWithCode:
        final codeDeliveryDetails = result.nextStep.codeDeliveryDetails!;
        _handleCodeDelivery(codeDeliveryDetails);
        break;
      case AuthUpdateAttributeStep.done:
        setState(() {
          useremail = newuseremail;
        });
        safePrint('Successfully updated attribute');
        break;
    }
  }

  Future<void> updateUserPassword() async {
    try {
      final result = await Amplify.Auth.updateUserAttribute(
        userAttributeKey: AuthUserAttributeKey.email,
        value: newuseremail,
      );
      _handleUpdateUserPasswordResult(result);
    } on AuthException catch (e) {
      safePrint('Error updating user attribute: ${e.message}');
    }
  }

  void _handleUpdateUserPasswordResult(
    UpdateUserAttributeResult result,
  ) {
    switch (result.nextStep.updateAttributeStep) {
      case AuthUpdateAttributeStep.confirmAttributeWithCode:
        final codeDeliveryDetails = result.nextStep.codeDeliveryDetails!;
        _handleCodeDelivery(codeDeliveryDetails);
        break;
      case AuthUpdateAttributeStep.done:
        setState(() {
          useremail = newuseremail;
        });
        safePrint('Successfully updated attribute');
        break;
    }
  }

  Future<void> updateUserNumber() async {
    try {
      final result = await Amplify.Auth.updateUserAttribute(
        userAttributeKey: AuthUserAttributeKey.phoneNumber,
        value: usernumber,
      );
      _handleUpdateUserNumberResult(result);
    } on AuthException catch (e) {
      safePrint('Error updating user attribute: ${e.message}');
    }
  }

  void _handleUpdateUserNumberResult(
    UpdateUserAttributeResult result,
  ) {
    switch (result.nextStep.updateAttributeStep) {
      case AuthUpdateAttributeStep.confirmAttributeWithCode:
        final codeDeliveryDetails = result.nextStep.codeDeliveryDetails!;
        _handleCodeDelivery(codeDeliveryDetails);
        break;
      case AuthUpdateAttributeStep.done:
        setState(() {
          usernumber = newusernumber;
        });

        safePrint('Successfully updated attribute');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 999,
      height: 700,
      child: ListView(scrollDirection: Axis.vertical, children: [
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
              controller: email,
              onChanged: (email) {
                profilehaschanged = true;
              },
              decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.yellowAccent),
                  hintStyle: TextStyle(color: Color.fromARGB(129, 255, 255, 0)),
                  border: OutlineInputBorder(),
                  hintText: 'Email',
                  fillColor: Colors.greenAccent)),
        ),
        //Phone Number
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: TextField(
              maxLength: 20,
              maxLines: 1,
              inputFormatters: [
                FilteringTextInputFormatter(
                    r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])',
                    allow: false),
              ],
              style: TextStyle(color: Colors.yellowAccent),
              controller: number,
              onChanged: (phonenumber) {
                profilehaschanged = true;
              },
              decoration: InputDecoration(
                  labelText: 'Phone Number',
                  labelStyle: TextStyle(color: Colors.yellowAccent),
                  hintStyle: TextStyle(color: Color.fromARGB(129, 255, 255, 0)),
                  border: OutlineInputBorder(),
                  hintText: 'Phone Number',
                  fillColor: Colors.greenAccent)),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: MinimalButton(
            minimalbuttonheight: 50,
            minimalbuttonwidth: 300,
            minimaloutlinewidth: 1.0,
            minimaloutlinecolor: Color.fromARGB(255, 0, 0, 0),
            minimalbackgroundcolor: Color.fromARGB(70, 102, 102, 102),
            minimalshadowcolor: Color.fromARGB(255, 56, 56, 56),
            shadowheight: 4,
            textobject: const Text(
              '                                                     Save',
              style: TextStyle(
                  fontSize: 30, color: Color.fromRGBO(255, 232, 193, 25)),
            ),
            onTap: () {
              Logger().d('Value Of Profile Changed Is $profilehaschanged');

              setState(() {
                profilehaschanged = false;
              });

              if (useremail != newuseremail) {
                setState(() {
                  newuseremail = email.text;
                });
                updateUserEmail();
              }

              if (usernumber != newusernumber) {
                setState(() {
                  newusernumber = number.text;
                });
                updateUserNumber();
              }
            },
          ),
        ),
      ]),
    );
  }
}
