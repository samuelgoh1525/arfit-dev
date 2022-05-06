// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:arfit/Screens/Profile/components/background.dart';
import 'package:arfit/authentication_service.dart';
import 'package:arfit/components/rounded_button.dart';
import 'package:arfit/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:arfit/Screens/BrowseChallenges/components/challenge_card.dart';

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
            "BROWSE CHALLENGES",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          ChallengeCard(
              id: 'weights',
              name: 'Weights Challenge',
              length: '10 days',
              description:
                  'This 10-day Weights Challenge works every muscle in your body!'),
          ChallengeCard(
              id: 'abs',
              name: 'Abs Challenge',
              length: '30 days',
              description:
                  'This 30-day Abs Challenge will sculpt your core in 4 weeks!'),
          ChallengeCard(
              id: 'weight_loss',
              name: 'Weight Loss Challenge',
              length: '7 days',
              description:
                  'This ultimate 7-day weight loss challenge will help you burn fat like crazy!'),
          SizedBox(
            height: size.height * 0.03,
          ),
          RoundedButton(
              text: "BACK",
              press: () {
                Navigator.pop(context);
              })
        ]));
  }
}
