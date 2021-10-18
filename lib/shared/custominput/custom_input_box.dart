import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mypost/shared/themes/app_colors.dart';

class MyCustomInputBox extends StatefulWidget {
  String label;
  String hint;
  TextEditingController controller;
  final Function? validator;

  MyCustomInputBox({
    Key? key,
    required this.label,
    required this.hint,
    required this.controller,
    this.validator,
  }) : super(key: key);

  @override
  _MyCustomInputBoxState createState() => _MyCustomInputBoxState();
}

class _MyCustomInputBoxState extends State<MyCustomInputBox> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 50, bottom: 8),
            child: Text(
              widget.label,
              style: const TextStyle(
                fontFamily: 'Product Sans',
                fontSize: 15,
                color: Color(0xff8f9db5),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(40, 0, 40, 15),
          child: TextFormField(
            controller: widget.controller,
            obscureText: widget.label == "Senha" ? true : false,
            onEditingComplete: () {},
            style: const TextStyle(
              fontSize: 19,
              color: Color(0xFFB1B0B8),
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
                hintText: widget.hint,
                hintStyle: TextStyle(
                  fontSize: 19,
                  color: Colors.grey[350],
                  fontWeight: FontWeight.w600,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 27,
                  horizontal: 25,
                ),
                focusColor: const Color(0xFFFF941A),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(27),
                  borderSide: const BorderSide(
                    color: Color(0xFFFF941A),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(27),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                  ),
                )),
          ),
        )
      ],
    );
  }
}
