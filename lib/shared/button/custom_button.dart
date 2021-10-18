import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyCustomButton extends StatelessWidget {
  const MyCustomButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.focused)) return Colors.red;
          if (states.contains(MaterialState.hovered)) return Colors.green;
          if (states.contains(MaterialState.pressed)) return Colors.blue;
          return null; // Defer to the widget's default.
        }),
      ),
      onPressed: () {},
      child: Text('TextButton with custom overlay colors'),
    );
  }
}
