// ignore_for_file: prefer_const_constructors

import 'package:arfit/components/text_field_container.dart';
import 'package:arfit/constants.dart';
import 'package:flutter/material.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController textController;
  const RoundedPasswordField({
    Key? key,
    required this.onChanged,
    required this.textController,
  }) : super(key: key);

  @override
  State<RoundedPasswordField> createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool isHidden = true;
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: widget.textController,
        obscureText: isHidden,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: IconButton(
            icon:
                isHidden ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
            color: kPrimaryColor,
            onPressed: () {
              setState(() {
                isHidden = !isHidden;
              });
            },
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
