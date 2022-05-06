// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:arfit/Screens/Profile/components/background.dart';
import 'package:arfit/components/rounded_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:arfit/Screens/BrowseChallenges/components/challenge_card.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  Future<List> getChallenges() async {
    CollectionReference challenges =
        FirebaseFirestore.instance.collection('challenges');
    QuerySnapshot querySnapshot = await challenges.get();

    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Total height and width of screen

    // List challengeList = [];
    getChallenges().then((list) {
      print(list[0]);
    });

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
          LimitedBox(
            maxHeight: 300,
            child: FutureBuilder<List>(
              future: getChallenges(),
              builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.builder(
                    physics: ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data?.length,
                    itemBuilder: (
                      BuildContext context,
                      int index,
                    ) {
                      return ChallengeCard(
                        id: snapshot.data![index]['id'],
                        name: snapshot.data![index]['name'],
                        length: snapshot.data![index]['length'],
                        description: snapshot.data![index]['description'],
                        photo: snapshot.data![index]['photo'],
                        goal: snapshot.data![index]['goal'],
                      );
                    },
                  );
                }
              },
            ),
          ),
          // ListView.builder(
          //   scrollDirection: Axis.vertical,
          //   shrinkWrap: true,
          //   itemBuilder: (
          //     BuildContext context,
          //     int index,
          //   ) {
          //     return ChallengeCard(
          //         id: challengeList,
          //         name: name,
          //         length: length,
          //         description: description);
          //   },
          // ),
          // ListView(
          //   scrollDirection: Axis.vertical,
          //   shrinkWrap: true,
          //   children: [
          //     ChallengeCard(
          //       id: 'weights',
          //       name: 'Weights Challenge',
          //       length: '10 days',
          //       description:
          //           'This 10-day Weights Challenge works every muscle in your body!',
          //     ),
          //     ChallengeCard(
          //       id: 'abs',
          //       name: 'Abs Challenge',
          //       length: '30 days',
          //       description:
          //           'This 30-day Abs Challenge will sculpt your core in 4 weeks!',
          //     ),
          //     ChallengeCard(
          //       id: 'weight_loss',
          //       name: 'Weight Loss Challenge',
          //       length: '7 days',
          //       description:
          //           'This ultimate 7-day weight loss challenge will help you burn fat like crazy!',
          //     ),
          //   ],
          // ),
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
