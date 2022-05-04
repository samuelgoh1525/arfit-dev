// ignore_for_file: prefer_const_constructors

import 'package:arfit/Screens/Login/login_screen.dart';
import 'package:arfit/Screens/Signup/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:arfit/components/rounded_button.dart';
import 'package:arfit/constants.dart';
import 'package:arfit/Screens/Welcome/components/background.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Total height and width of screen
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(width: double.infinity),
          Text(
            "JOIN THE FITNESS MOVEMENT",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          Image.asset(
            "assets/images/logo.png",
            height: size.height * 0.3,
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          RoundedButton(
            text: "LOGIN",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoginScreen();
                  },
                ),
              );
            },
          ),
          RoundedButton(
            text: "SIGN UP",
            color: kSuccessLightColor,
            textColor: Colors.black,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SignUpScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
