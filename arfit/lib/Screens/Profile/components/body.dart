// ignore_for_file: prefer_const_constructors

import 'package:arfit/Screens/ActiveChallenges/active_challenges.dart';
import 'package:arfit/Screens/BrowseChallenges/browse_challenges.dart';
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

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Total height and width of screen

    CollectionReference userChallenges =
        FirebaseFirestore.instance.collection('userChallenges');

    final FirebaseAuth auth = FirebaseAuth.instance;
    final String? userEmail = auth.currentUser?.email;

    Future<Map> getName() async {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      DocumentSnapshot userDocument = await users.doc(userEmail).get();
      return userDocument.data() as Map;
    }

    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // StreamBuilder<QuerySnapshot>(
          //   stream: userChallenges.snapshots(),
          //   builder:
          //       (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          //     if (snapshot.hasError) {
          //       return Text('Something went wrong');
          //     }

          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return Text("Loading");
          //     }
          //     return ListView(
          //       scrollDirection: Axis.vertical,
          //       shrinkWrap: true,
          //       children: snapshot.data!.docs.map((DocumentSnapshot document) {
          //         Map<String, dynamic> data =
          //             document.data()! as Map<String, dynamic>;
          //         return ListTile(
          //           title: Text(data['receiver']),
          //           subtitle: Text(data['challengeId']),
          //         );
          //       }).toList(),
          //     );
          //   },
          // ),
          SizedBox(width: double.infinity),
          FutureBuilder(
            future: getName(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Column(
                  children: [
                    Text(
                      "Hi " + snapshot.data['name'] + "!",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    Image.network(
                      snapshot.data['photo'],
                      height: size.height * 0.2,
                    )
                  ],
                );
              }
            },
            // child: Text(
            //   "WELCOME!",
            //   style: TextStyle(
            //     fontWeight: FontWeight.bold,
            //     fontSize: 24,
            //   ),
            // ),
          ),
          SizedBox(
            height: size.height * 0.04,
          ),
          // SvgPicture.asset(
          //   "assets/icons/signup-fitness.svg",
          //   height: size.height * 0.4,
          // ),
          RoundedButton(
            text: "BROWSE CHALLENGES",
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BrowseChallenges()));
            },
          ),
          RoundedButton(
            text: "ACTIVE CHALLENGES",
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ActiveChallenges()));
            },
            color: Colors.green,
          ),
          // SizedBox(
          //   height: size.height * 0.01,
          // ),
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
            color: Colors.red,
          ),
          // RoundedButton(
          //   text: "Try this",
          //   press: () {
          //     showDialog(
          //       context: context,
          //       builder: (_) => AlertWidget(
          //           title: "Testing New Alert",
          //           caption: "Does this work?",
          //           actions: [
          //             TextButton(
          //               onPressed: () {},
          //               child: Text("Accept"),
          //             ),
          //             TextButton(
          //               onPressed: () {},
          //               child: Text("Reject"),
          //             ),
          //           ]),
          //     );
          //   },
          // ),
          // AlertDialog(
          //   title: Text("Accept?"),
          //   content: Text("Do you accept?"),
          // ),
        ],
      ),
    );
  }
}
