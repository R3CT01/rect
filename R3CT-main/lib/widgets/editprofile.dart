// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:aura/pages/loginpage.dart';
import 'package:aura/pages/photoeditor.dart';
import 'package:aura/pages/profile.dart';
import 'package:aura/widgets/minimalbutton.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

class EditProfile extends StatefulWidget {
  EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool profilehaschanged = false;

  Future<void> updateUserUsername() async {
    try {
      final result = await Amplify.Auth.updateUserAttribute(
        userAttributeKey: AuthUserAttributeKey.givenName,
        value: newusername,
      );
      _handleUpdateUserAttributeResult(result);
    } on AuthException catch (e) {
      safePrint('Error updating user attribute: ${e.message}');
    }
  }

  void _handleUpdateUserAttributeResult(
    UpdateUserAttributeResult result,
  ) {
    switch (result.nextStep.updateAttributeStep) {
      case AuthUpdateAttributeStep.confirmAttributeWithCode:
        final codeDeliveryDetails = result.nextStep.codeDeliveryDetails!;
        _handleCodeDelivery(codeDeliveryDetails);
        break;
      case AuthUpdateAttributeStep.done:
        setState(() {
          usernamedisplay = newusername;
        });

        safePrint('Successfully updated attribute');
        break;
    }
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

  Future<void> updateUserBio() async {
    try {
      final result = await Amplify.Auth.updateUserAttribute(
        userAttributeKey: CognitoUserAttributeKey.custom('bio'),
        value: newuserbio,
      );
      _handleUpdateUserBioResult(result);
    } on AuthException catch (e) {
      safePrint('Error updating user attribute: ${e.message}');
    }
  }

  void _handleUpdateUserBioResult(
    UpdateUserAttributeResult result,
  ) {
    switch (result.nextStep.updateAttributeStep) {
      case AuthUpdateAttributeStep.confirmAttributeWithCode:
        final codeDeliveryDetails = result.nextStep.codeDeliveryDetails!;
        _handleCodeDelivery(codeDeliveryDetails);
        break;
      case AuthUpdateAttributeStep.done:
        updatedone = true;
        Logger().d('Value Of IsDone = $updatedone');
        setState(() {
          userbio = newuserbio;
        });
        safePrint('Successfully updated attribute');
        break;
    }
  }

  Future<void> updateUserWebsite() async {
    try {
      final result = await Amplify.Auth.updateUserAttribute(
        userAttributeKey: CognitoUserAttributeKey.custom('Website'),
        value: newuserwebsite,
      );
      _handleUpdateUserWebsiteResult(result);
    } on AuthException catch (e) {
      safePrint('Error updating user attribute: ${e.message}');
    }
  }

  void _handleUpdateUserWebsiteResult(
    UpdateUserAttributeResult result,
  ) {
    switch (result.nextStep.updateAttributeStep) {
      case AuthUpdateAttributeStep.confirmAttributeWithCode:
        final codeDeliveryDetails = result.nextStep.codeDeliveryDetails!;
        _handleCodeDelivery(codeDeliveryDetails);
        break;
      case AuthUpdateAttributeStep.done:
        updatedone = true;
        Logger().d('Value Of IsDone = $updatedone');
        setState(() {
          userwebsite = newuserwebsite;
        });
        safePrint('Successfully updated attribute');
        break;
    }
  }

  void _handleCodeDelivery(AuthCodeDeliveryDetails codeDeliveryDetails) {
    safePrint(
      'A confirmation code has been sent to ${codeDeliveryDetails.destination}. '
      'Please check your ${codeDeliveryDetails.deliveryMedium.name} for the code.',
    );
  }

  Future<void> updateUserAmazonLink() async {
    try {
      final result = await Amplify.Auth.updateUserAttribute(
        userAttributeKey: CognitoUserAttributeKey.custom('WishList'),
        value: newuseramazonlink,
      );
      _handleUpdateUserAmazonLinkResult(result);
    } on AuthException catch (e) {
      safePrint('Error updating user attribute: ${e.message}');
    }
  }

  void _handleUpdateUserAmazonLinkResult(
    UpdateUserAttributeResult result,
  ) {
    switch (result.nextStep.updateAttributeStep) {
      case AuthUpdateAttributeStep.confirmAttributeWithCode:
        final codeDeliveryDetails = result.nextStep.codeDeliveryDetails!;
        _handleCodeDelivery(codeDeliveryDetails);
        break;
      case AuthUpdateAttributeStep.done:
        updatedone = true;
        Logger().d('Value Of IsDone = $updatedone');
        setState(() {
          useramazonlink = newuseramazonlink;
        });
        safePrint('Successfully updated attribute');
        break;
    }
  }

  final username = TextEditingController(text: usernamedisplay);

  final fullname = TextEditingController(text: fullnamedisplay);

  final bio = TextEditingController(text: userbio);

  final website = TextEditingController(text: userwebsite);

  final number = TextEditingController(text: usernumber);

  final amazonwishlist = TextEditingController(text: useramazonlink);
  bool updatedone = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 999,
      height: 800,
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 19),
                child: Container(
                  width: 999,
                  height: 260,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Color.fromARGB(255, 232, 193, 255), width: 3)),
                  child: Image(
                      fit: BoxFit.fill, image: AssetImage(backgroundimage)),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 160, right: 10),

                  //Profile Image Goes Here
                  child: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 232, 193, 255),
                    radius: 60,
                    child: Image(image: AssetImage(userimage.toString())),
                  )),
              Padding(
                padding: EdgeInsets.only(top: 239, left: 39),
                child: InkWell(
                  onTap: () async {
                    Logger().d(username);
                    Logger().d('User Wants To Change There Profile Picture!');

                    //Profile picture upload
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles();

                    if (result != null) {
                      Uint8List fileBytes = result.files.first.bytes!;
                      String fileName = result.files.first.name;

                      Navigator.pushReplacement<void, void>(
                          context,
                          MaterialPageRoute<void>(
                              builder: (context) => PhotoEditor(
                                    filebytes: fileBytes,
                                    filename: fileName,
                                  )));

                      /*uploadBytes(
                          bytes: fileBytes,
                          key: fileName,
                          contentType: 'contentType');*/
                      // Upload file
                    }
                  },

/**/
                  // Upload file with its filename as the key

                  child: Icon(
                    Icons.camera_alt_rounded,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              ),
              //Background Image
              Padding(
                padding: EdgeInsets.only(top: 215, left: 955),
                child: InkWell(
                  onTap: () async {
                    Logger()
                        .d('User Wants To Change There Background Picture!');
                  },
                  child: Icon(
                    Icons.camera_alt_rounded,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),

          //Full Name
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: TextFormField(
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
                  labelText: fullnamedisplay,
                  labelStyle: TextStyle(color: Colors.yellowAccent),
                  hintStyle: TextStyle(color: Color.fromARGB(129, 255, 255, 0)),
                  border: OutlineInputBorder(),
                  hintText: 'Display Name',
                  fillColor: Colors.greenAccent),
              onChanged: (fullname) {
                profilehaschanged = true;
              },
            ),
          ),
          //Bio
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
                onChanged: (bio) {
                  profilehaschanged = true;
                },
                decoration: InputDecoration(
                    labelText: 'Bio',
                    labelStyle: TextStyle(color: Colors.yellowAccent),
                    hintStyle:
                        TextStyle(color: Color.fromARGB(129, 255, 255, 0)),
                    border: OutlineInputBorder(),
                    hintText:
                        'Put Something Nice Here, Like Where Are You From?',
                    fillColor: Colors.greenAccent)),
          ),

//User Number

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
                onChanged: (wishlist) {
                  profilehaschanged = true;
                },
                decoration: InputDecoration(
                    labelText: 'Amazon Wishlist Link',
                    labelStyle: TextStyle(color: Colors.yellowAccent),
                    hintStyle:
                        TextStyle(color: Color.fromARGB(129, 255, 255, 0)),
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
                onChanged: (website) {
                  profilehaschanged = true;
                },
                decoration: InputDecoration(
                    labelText: 'Website',
                    labelStyle: TextStyle(color: Colors.yellowAccent),
                    hintStyle:
                        TextStyle(color: Color.fromARGB(129, 255, 255, 0)),
                    border: OutlineInputBorder(),
                    hintText: 'Your Cool Little Website Goes Here...',
                    fillColor: Colors.greenAccent)),
          ),
          //Bio
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: MinimalButton(
              minimaloutlinewidth: 1.0,
              minimaloutlinecolor: Color.fromARGB(255, 0, 0, 0),
              minimalbackgroundcolor: Color.fromARGB(70, 102, 102, 102),
              minimalshadowcolor: Color.fromARGB(255, 56, 56, 56),
              shadowheight: 4,
              minimalbuttonheight: 50,
              minimalbuttonwidth: 50,
              textobject: const Text(
                'Save',
                style: TextStyle(
                    fontSize: 30, color: Color.fromRGBO(120, 252, 44, 0.906)),
              ),
              onTap: () {
                Logger().d('Value Of Profile Changed Is $profilehaschanged');

                setState(() {
                  profilehaschanged = false;
                });
                if (userbio != newuserbio) {
                  setState(() {
                    newuserbio = bio.text;
                  });
                  updateUserBio();
                }
                if (fullnamedisplay != newusername) {
                  setState(() {
                    newusername = fullname.text;
                  });
                  updateUserUsername();
                }

                if (userwebsite != newuserwebsite) {
                  setState(() {
                    newuserwebsite = website.text;
                  });
                  updateUserWebsite();
                }

                if (useramazonlink != newuseramazonlink) {
                  setState(() {
                    newuseramazonlink = amazonwishlist.text;
                  });
                  updateUserAmazonLink();
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: MinimalButton(
              minimaloutlinewidth: 1.0,
              minimaloutlinecolor: Color.fromARGB(255, 0, 0, 0),
              minimalbackgroundcolor: Color.fromARGB(70, 102, 102, 102),
              minimalshadowcolor: Color.fromARGB(255, 56, 56, 56),
              shadowheight: 4,
              minimalbuttonheight: 50,
              minimalbuttonwidth: 50,
              textobject: const Text(
                'Sign Out',
                style: TextStyle(
                    fontSize: 30,
                    color: Color.fromARGB(255, 255, 6, 6),
                    fontFamily: 'Roboto'),
              ),
              onTap: () async {
                //Sign Out Dialog
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Expanded(
                      child: AlertDialog(
                          backgroundColor: Color.fromRGBO(255, 232, 193, 255),
                          actions: <Widget>[
                            //Yes
                            MinimalButton(
                              minimaloutlinewidth: 1.0,
                              minimaloutlinecolor: Color.fromARGB(255, 0, 0, 0),
                              minimalbackgroundcolor:
                                  Color.fromARGB(70, 102, 102, 102),
                              minimalshadowcolor:
                                  Color.fromARGB(255, 56, 56, 56),
                              shadowheight: 4,
                              minimalbuttonheight: 50,
                              minimalbuttonwidth: 100,
                              textobject: const Text(
                                'Yes',
                                style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.yellowAccent,
                                    fontFamily: 'Roboto'),
                              ),
                              onTap: () async {
                                Logger().d('$usernamedisplay Has Logged Out');
                                final result = await Amplify.Auth.signOut();
                                if (result is CognitoCompleteSignOut) {
                                  safePrint('Sign out completed successfully');
                                  Navigator.pushReplacement<void, void>(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (context) => Login(),
                                    ),
                                  );
                                } else if (result is CognitoFailedSignOut) {
                                  safePrint(
                                      'Error signing user out: ${result.exception.message}');
                                }
                              },
                            ),

                            //No
                            MinimalButton(
                              minimaloutlinewidth: 1.0,
                              minimaloutlinecolor: Color.fromARGB(255, 0, 0, 0),
                              minimalbackgroundcolor:
                                  Color.fromARGB(70, 102, 102, 102),
                              minimalshadowcolor:
                                  Color.fromARGB(255, 56, 56, 56),
                              shadowheight: 4,
                              minimalbuttonheight: 50,
                              minimalbuttonwidth: 100,
                              textobject: const Text(
                                'No',
                                style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.yellowAccent,
                                    fontFamily: 'Roboto'),
                              ),
                              onTap: () {
                                Navigator.of(context).pop();
                                Logger().d('Closed Window');
                              },
                            ),
                          ],
                          content: Text(
                            'Are You Sure You Want To Log Out?',
                            style: TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(255, 255, 43, 5),
                                fontFamily: 'Roboto'),
                          )),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
