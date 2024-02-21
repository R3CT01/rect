// ignore_for_file: prefer_const_constructors

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

//Error Code Class For Displaying Errors In A Nice Fashon
class MinimalButton extends StatelessWidget {
  final GestureTapCallback onTap;
  final GestureTapCallback? onDoubleTap;
  final ValueChanged<bool>? onHover;
  final Color? minimaloutlinecolor;
  final Color? minimalbackgroundcolor;
  final Text textobject;
  final double shadowheight;
  final double? minimaloutlinewidth;
  final double minimalbuttonwidth;
  final double minimalbuttonheight;
  final Color minimalshadowcolor;
  //Minimal Button Class
  const MinimalButton({
    super.key,
    this.minimaloutlinecolor,
    this.minimaloutlinewidth,
    this.minimalbackgroundcolor,
    required this.minimalshadowcolor,
    required this.shadowheight,
    this.onHover,
    required this.minimalbuttonheight,
    required this.minimalbuttonwidth,
    this.onDoubleTap,
    required this.textobject,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: minimalbuttonwidth,
      height: minimalbuttonheight,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
            elevation: shadowheight!,
            shadowColor: minimalshadowcolor,
            side: BorderSide(
                width: minimaloutlinewidth!, color: minimaloutlinecolor!),
            backgroundColor: minimalbackgroundcolor),
        child: textobject,
      ),
    );
  }
}


/**/

//   foregroundColor: MaterialStateProperty.all<Color>(minimalcolor!)