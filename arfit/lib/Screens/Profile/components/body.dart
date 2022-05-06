// ignore_for_file: prefer_const_constructors

import 'package:arfit/Screens/Profile/components/background.dart';
import 'package:arfit/authentication_service.dart';
import 'package:arfit/components/alert_widget.dart';
import 'package:arfit/components/rounded_button.dart';
import 'package:arfit/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:arfit/queries.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Total height and width of screen

    CollectionReference userChallenges =
        FirebaseFirestore.instance.collection('userChallenges');

    final FirebaseAuth auth = FirebaseAuth.instance;
    final String? userEmail = auth.currentUser?.email;

    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          StreamBuilder<QuerySnapshot>(
            stream: userChallenges.snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }

              // Map<String, dynamic> data = snapshot.data!.docs as Map<String, dynamic>;
              for (DocumentSnapshot document in snapshot.data!.docs) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                if (data['receiver'] == userEmail && data['accepted'] == false) {
                  return AlertWidget(
                      title: "You have been challenged by " + data['sender'],
                      caption: "Do you accept?",
                      actions: [
                        TextButton(
                          onPressed: () {
                            Queries.acceptUserChallenge(
                                userChallenges, document.id);
                            Queries.addAcceptedChallenge(
                                users, document.id, userEmail!);
                          },
                          child: Text("Accept"),
                        ),
                        TextButton(
                          onPressed: () {
                            // Queries.removeUserChallenge(userChallenges, document.id);
                            },
                          child: Text("Reject"),
                        ),
                      ]);
                }
              }
              return Text("No new challenges");

              // return ListView(
              //   scrollDirection: Axis.vertical,
              //   shrinkWrap: true,
              //   children: snapshot.data!.docs.map((DocumentSnapshot document) {
              //     Map<String, dynamic> data =
              //         document.data()! as Map<String, dynamic>;

              //     return ListTile(
              //       title: Text(data['receiver']),
              //       subtitle: Text(data['challengeId']),
              //     );
              //   }).toList(),
              // );
            },
          ),
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
            "assets/icons/signup-fitness.svg",
            height: size.height * 0.4,
          ),
          SizedBox(
            height: size.height * 0.03,
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
          RoundedButton(
            text: "Try this",
            press: () {
              showDialog(
                context: context,
                builder: (_) => AlertWidget(
                    title: "Testing New Alert",
                    caption: "Does this work?",
                    actions: [
                      TextButton(
                        onPressed: () {},
                        child: Text("Accept"),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text("Reject"),
                      ),
                    ]),
              );
            },
          ),
          // AlertDialog(
          //   title: Text("Accept?"),
          //   content: Text("Do you accept?"),
          // ),
        ],
      ),
    );
  }
}
