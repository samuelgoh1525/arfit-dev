import 'package:arfit/constants.dart';
import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: size.height * 0.02,
      ),
      width: size.width * 0.8,
      child: Row(
        children: <Widget>[
          BuildDivider(),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Text(
              "OR",
              style: TextStyle(
                color: kPrimaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          BuildDivider(),
        ],
      ),
    );
  }
}

class BuildDivider extends StatelessWidget {
  const BuildDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Divider(
        color: kPrimaryColor,
        height: 1.5,
      ),
    );
  }
}
