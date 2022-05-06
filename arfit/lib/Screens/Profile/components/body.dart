// ignore_for_file: prefer_const_constructors

import 'package:arfit/Screens/ActiveChallenges/active_challenges.dart';
import 'package:arfit/Screens/BrowseChallenges/browse_challenges.dart';
import 'package:arfit/Screens/Profile/components/background.dart';
import 'package:arfit/authentication_service.dart';
import 'package:arfit/components/rounded_button.dart';
import 'package:arfit/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

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
            "PROFILE PAGE",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          SizedBox(
            height: size.height * 0.04,
          ),
          SvgPicture.asset(
            "assets/icons/chat.svg",
            height: size.height * 0.45,
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          RoundedButton(
            text: "BROWSE CHALLENGES",
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BrowseChallenges()));
            },
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          RoundedButton(
            text: "ACTIVE CHALLENGES",
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ActiveChallenges()));
            },
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          RoundedButton(
            text: "SIGN OUT",
            press: () {
              context.read<AuthenticationService>().signOut();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return AuthenticationWrapper();
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
