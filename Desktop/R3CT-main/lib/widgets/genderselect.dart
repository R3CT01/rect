import 'package:flutter/material.dart';

//Simple Custom class that extends RoundCheckBox to be able to single out Select Boxes
enum SingingCharacter { male, female, transgender, other }

//Gedner selection string that gets passed to AWS Function in registerpage.dart
String genderstring = '';

class RadioExample extends StatefulWidget {
  const RadioExample({super.key, required});

  @override
  State<RadioExample> createState() => _RadioExampleState();
}

class _RadioExampleState extends State<RadioExample> {
  SingingCharacter? _character = SingingCharacter.male;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Radio<SingingCharacter>(
          value: SingingCharacter.male,
          groupValue: _character,
          onChanged: (SingingCharacter? value) {
            setState(() {
              _character = value;
              genderstring = SingingCharacter.male.name;
            });
          },
        ),
        const Text(
          'Male',
          style: TextStyle(color: Colors.yellowAccent),
        ),
        Radio<SingingCharacter>(
          value: SingingCharacter.female,
          groupValue: _character,
          onChanged: (SingingCharacter? value) {
            setState(() {
              _character = value;
              genderstring = SingingCharacter.female.name;
            });
          },
        ),
        const Text(
          'Female',
          style: TextStyle(color: Colors.yellowAccent),
        ),
        Radio<SingingCharacter>(
          value: SingingCharacter.transgender,
          groupValue: _character,
          onChanged: (SingingCharacter? value) {
            setState(() {
              _character = value;
              genderstring = SingingCharacter.transgender.name;
            });
          },
        ),
        const Text(
          'Trans',
          style: TextStyle(color: Colors.yellowAccent),
        ),
        Radio<SingingCharacter>(
          value: SingingCharacter.other,
          groupValue: _character,
          onChanged: (SingingCharacter? value) {
            setState(() {
              _character = value;
              genderstring = SingingCharacter.other.name;
            });
          },
        ),
        const Text(
          'Other',
          style: TextStyle(color: Colors.yellowAccent),
        ),
      ],
    );
  }
}
