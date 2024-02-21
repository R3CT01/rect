import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

//Error Code Class For Displaying Errors In A Nice Fashon
class ErrorCodes extends StatelessWidget {
  final String errortext;
  final bool isvisible;
  final TextStyle textstyle;
  //
  const ErrorCodes({
    super.key,
    required this.errortext,
    required this.isvisible,
    required this.textstyle,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: isvisible,
        child: Text(
          errortext,
          style: textstyle,
        ));
  }
}
