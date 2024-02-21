// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:amplify_core/amplify_core.dart';
import 'package:aura/pages/loginpage.dart';
import 'package:aura/pages/main.dart';
import 'package:aura/pages/messages.dart';
import 'package:aura/pages/notifications.dart';
import 'package:aura/pages/profile.dart';
import 'package:aura/pages/saved.dart';
import 'package:aura/pages/subscriptions.dart';
import 'package:aura/widgets/minimalbutton.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class NavPanel extends StatelessWidget {
  const NavPanel({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 300, top: 90),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 3, color: Color.fromARGB(70, 41, 41, 41)),
        ),
        child: Column(
          children: [
            //Home
            MinimalButton(
              minimalbuttonheight: 50,
              minimalbuttonwidth: 300,
              minimaloutlinewidth: 1.0,
              minimaloutlinecolor: Color.fromARGB(255, 0, 0, 0),
              minimalbackgroundcolor: Color.fromARGB(70, 102, 102, 102),
              minimalshadowcolor: Color.fromARGB(255, 56, 56, 56),
              shadowheight: 4,
              textobject: Text(
                'Home',
                style: TextStyle(
                    color: Color.fromARGB(255, 81, 255, 0),
                    fontSize: 30,
                    fontFamily: 'RobotoFlex'),
              ),
              onTap: () {
                Navigator.pushReplacement<void, void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => Home(),
                  ),
                );
              },
            ),
            const Padding(padding: EdgeInsets.only(bottom: 40)),

            //Notifications
            MinimalButton(
              minimalbuttonheight: 50,
              minimalbuttonwidth: 300,
              minimaloutlinewidth: 1.0,
              minimaloutlinecolor: Color.fromARGB(255, 0, 0, 0),
              minimalbackgroundcolor: Color.fromARGB(70, 102, 102, 102),
              minimalshadowcolor: Color.fromARGB(255, 56, 56, 56),
              textobject: Text(
                'Notifications',
                style: TextStyle(
                    color: Color.fromARGB(255, 102, 255, 0),
                    fontSize: 30,
                    fontFamily: 'Roboto'),
              ),
              shadowheight: 4,
              onTap: () {
                Navigator.pushReplacement<void, void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => Notifications(),
                  ),
                );
              },
            ),
            const Padding(padding: EdgeInsets.only(bottom: 40)),

            //Messages
            MinimalButton(
              shadowheight: 4,
              minimalbuttonheight: 50,
              minimalbuttonwidth: 300,
              textobject: Text(
                '         Messages         ',
                style: TextStyle(
                    color: Color.fromARGB(255, 179, 255, 0),
                    fontSize: 30,
                    fontFamily: 'Roboto'),
              ),
              minimaloutlinewidth: 1.0,
              minimaloutlinecolor: Color.fromARGB(255, 0, 0, 0),
              minimalbackgroundcolor: Color.fromARGB(70, 102, 102, 102),
              minimalshadowcolor: Color.fromARGB(255, 56, 56, 56),
              onTap: () {
                Navigator.pushReplacement<void, void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => Messages(),
                  ),
                );
              },
            ),
            const Padding(padding: EdgeInsets.only(bottom: 40)),

            //Subs
            MinimalButton(
              minimaloutlinewidth: 1.0,
              minimaloutlinecolor: Color.fromARGB(255, 0, 0, 0),
              minimalbackgroundcolor: Color.fromARGB(70, 102, 102, 102),
              minimalshadowcolor: Color.fromARGB(255, 56, 56, 56),
              shadowheight: 4,
              minimalbuttonheight: 50,
              minimalbuttonwidth: 300,
              textobject: Text(
                'Subscriptions',
                style: TextStyle(
                    color: Color.fromARGB(255, 208, 255, 0),
                    fontSize: 30,
                    fontFamily: 'Roboto'),
              ),
              onTap: () {
                Navigator.pushReplacement<void, void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => Subscriptions(),
                  ),
                );
              },
            ),

            const Padding(padding: EdgeInsets.only(bottom: 40)),

            //Saved
            MinimalButton(
              minimaloutlinewidth: 1.0,
              minimaloutlinecolor: Color.fromARGB(255, 0, 0, 0),
              minimalbackgroundcolor: Color.fromARGB(70, 102, 102, 102),
              minimalshadowcolor: Color.fromARGB(255, 56, 56, 56),
              shadowheight: 4,
              minimalbuttonheight: 50,
              minimalbuttonwidth: 300,
              textobject: Text('Saved',
                  style: TextStyle(
                      color: Colors.yellowAccent,
                      fontSize: 30,
                      fontFamily: 'Roboto')),
              onTap: () {
                Navigator.pushReplacement<void, void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => Saved(),
                  ),
                );
              },
            ),

            const Padding(padding: EdgeInsets.only(bottom: 40)),

            //Profile
            MinimalButton(
              minimalbuttonheight: 50,
              minimalbuttonwidth: 300,
              minimaloutlinewidth: 1.0,
              minimaloutlinecolor: Color.fromARGB(255, 0, 0, 0),
              minimalbackgroundcolor: Color.fromARGB(70, 102, 102, 102),
              minimalshadowcolor: Color.fromARGB(255, 56, 56, 56),
              textobject: Text(
                'Profile',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.yellowAccent,
                    fontFamily: 'Roboto'),
              ),
              shadowheight: 4,
              onTap: () {
                Navigator.pushReplacement<void, void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => Profile(),
                  ),
                );
              },
            ),
            const Padding(padding: EdgeInsets.only(bottom: 40)),

            //SignOut

            const Padding(padding: EdgeInsets.only(bottom: 40)),

            //Post
            TextButton.icon(
              style: ButtonStyle(
                iconSize: MaterialStateProperty.all<double>(50),
                overlayColor: MaterialStateProperty.all<Color>(
                    const Color.fromARGB(129, 160, 172, 114)),
                textStyle: MaterialStateProperty.all<TextStyle>(
                    const TextStyle(fontSize: 30)),
                foregroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromARGB(255, 102, 102, 102)),
                backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromRGBO(245, 230, 92, 1)),
              ),
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text('New Post               '),
            ),

            const Padding(padding: EdgeInsets.only(bottom: 70)),
          ],
        ),
      ),
    );
  }
}
