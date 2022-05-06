// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:arfit/Screens/ActiveChallenges/components/challenge_card.dart';
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
            "ACTIVE CHALLENGES",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          ChallengeCard(
              id: 'challenge0',
              name: 'Challenge',
              length: '0 days',
              description: 'Challenge description here'),
          SizedBox(
            height: size.height * 0.03,
          ),
          RoundedButton(
            text: "BACK",
            press: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
