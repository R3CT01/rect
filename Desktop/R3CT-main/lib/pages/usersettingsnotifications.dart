import 'package:aura/pages/profile.dart';
import 'package:aura/pages/usersettingsaccount.dart';
import 'package:aura/pages/usersettingsprivacy.dart';
import 'package:aura/pages/usersettingsprofile.dart';
import 'package:aura/widgets/editaccount.dart';
import 'package:aura/widgets/editnotifications.dart';
import 'package:aura/widgets/editprofile.dart';
import 'package:aura/widgets/minimalbutton.dart';
import 'package:aura/widgets/navpanel.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class UserSettingsNoti extends StatelessWidget {
  const UserSettingsNoti({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Edit Notifications',
        theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 52, 46, 56),
        ),
        home: Scaffold(
          body: Row(children: [
            //const SingleChildScrollView(child: NavPanel()),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: SizedBox(
                height: 399,
                width: 400,
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 299),
                      child: InkWell(
                        radius: 2,
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.yellowAccent,
                          size: 88,
                        ),
                        onTap: () => Navigator.pushReplacement<void, void>(
                            context,
                            MaterialPageRoute<void>(
                              builder: (context) => Profile(),
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: MinimalButton(
                        minimaloutlinewidth: 1.0,
                        minimaloutlinecolor: Color.fromARGB(255, 0, 0, 0),
                        minimalbackgroundcolor:
                            Color.fromARGB(70, 102, 102, 102),
                        minimalshadowcolor: Color.fromARGB(255, 56, 56, 56),
                        shadowheight: 4,
                        minimalbuttonheight: 50,
                        minimalbuttonwidth: 300,
                        textobject: const Text(
                          'Profile',
                          style: TextStyle(
                              fontSize: 30,
                              color: Color.fromARGB(255, 123, 255, 0),
                              fontFamily: 'Roboto'),
                        ),
                        onTap: () {
                          Navigator.pushReplacement<void, void>(
                            context,
                            MaterialPageRoute<void>(
                              builder: (context) => UserSettingsProfile(),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: MinimalButton(
                        minimaloutlinewidth: 1.0,
                        minimaloutlinecolor: Color.fromARGB(255, 0, 0, 0),
                        minimalbackgroundcolor:
                            Color.fromARGB(70, 102, 102, 102),
                        minimalshadowcolor: Color.fromARGB(255, 56, 56, 56),
                        shadowheight: 4,
                        minimalbuttonheight: 50,
                        minimalbuttonwidth: 300,
                        textobject: const Text(
                          'Account',
                          style: TextStyle(
                              fontSize: 30,
                              color: Color.fromARGB(255, 0, 255, 34),
                              fontFamily: 'Roboto'),
                        ),
                        onTap: () {
                          Navigator.pushReplacement<void, void>(
                            context,
                            MaterialPageRoute<void>(
                              builder: (context) => const UserSettingsAccount(),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: MinimalButton(
                        minimaloutlinewidth: 1.0,
                        minimaloutlinecolor: Color.fromARGB(255, 0, 0, 0),
                        minimalbackgroundcolor:
                            Color.fromARGB(70, 102, 102, 102),
                        minimalshadowcolor: Color.fromARGB(255, 56, 56, 56),
                        shadowheight: 4,
                        minimalbuttonheight: 50,
                        minimalbuttonwidth: 300,
                        textobject: const Text(
                          'Privacy',
                          style: TextStyle(
                              fontSize: 30,
                              color: Color.fromARGB(255, 166, 255, 0),
                              fontFamily: 'Roboto'),
                        ),
                        onTap: () {
                          Navigator.pushReplacement<void, void>(
                            context,
                            MaterialPageRoute<void>(
                              builder: (context) => const UserSettingsPrivacy(),
                            ),
                          );
                        },
                      ),
                    ),
                    MinimalButton(
                      minimaloutlinewidth: 1.0,
                      minimaloutlinecolor: Color.fromARGB(255, 0, 0, 0),
                      minimalbackgroundcolor: Color.fromARGB(70, 102, 102, 102),
                      minimalshadowcolor: Color.fromARGB(255, 56, 56, 56),
                      shadowheight: 4,
                      minimalbuttonheight: 50,
                      minimalbuttonwidth: 300,
                      textobject: const Text(
                        'Notifications',
                        style: TextStyle(
                            fontSize: 30,
                            color: Color.fromARGB(255, 179, 255, 0),
                            fontFamily: 'Roboto'),
                      ),
                      onTap: () {
                        Navigator.pushReplacement<void, void>(
                          context,
                          MaterialPageRoute<void>(
                            builder: (context) => const UserSettingsNoti(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            //Display Screen Here
            Padding(
              padding: const EdgeInsets.only(left: 300, top: 90),
              child: EditNotifications(),
            ),
          ]),
        ));
  }
}
