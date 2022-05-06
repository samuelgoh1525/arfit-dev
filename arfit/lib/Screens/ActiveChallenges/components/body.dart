// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:arfit/Screens/ActiveChallenges/components/challenge_card.dart';
import 'package:arfit/Screens/Profile/components/background.dart';
import 'package:arfit/components/rounded_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  Future<List> getAllChallengesDetails(String? userID) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    DocumentSnapshot userSnapshot = await users.doc(userID).get();
    Map userDocument = userSnapshot.data() as Map;

    CollectionReference userChallenges =
        FirebaseFirestore.instance.collection('userChallenges');

    CollectionReference challenges =
        FirebaseFirestore.instance.collection('challenges');

    print(userDocument['acceptedChallenges']);
    List allChallengesDetails = [];

    // [gKlkdOha5qzNTllV3gHd, dAHoKHOhUvLEUU8syGHD, d5LfRtV4SdZBmGFGcN3L]

    for (String oneChallenge in userDocument['acceptedChallenges']) {
      QuerySnapshot userChallengeSenderQuerySnapshot = await userChallenges
          .where('challengeID', isEqualTo: oneChallenge)
          .where('accepted', isEqualTo: true)
          .where('sender', isEqualTo: userID)
          .get();

      QuerySnapshot userChallengeReceiverQuerySnapshot = await userChallenges
          .where('challengeID', isEqualTo: oneChallenge)
          .where('accepted', isEqualTo: true)
          .where('receiver', isEqualTo: userID)
          .get();

      for (DocumentSnapshot userChallengeSenderDocumentSnapshot
          in userChallengeSenderQuerySnapshot.docs) {
        DocumentSnapshot challengeSnapshot =
            await challenges.doc(oneChallenge).get();

        Map challengeDocument = challengeSnapshot.data() as Map;

        Map userChallengeSenderDocument =
            userChallengeSenderDocumentSnapshot.data() as Map;

        // want to know who received the challenge
        challengeDocument['friend'] = userChallengeSenderDocument['receiver'];
        challengeDocument['reps'] =
            userChallengeSenderDocument['repss'].toDouble();
        challengeDocument['goal'] =
            userChallengeSenderDocument['goal'].toDouble();
        challengeDocument['duedate'] =
            userChallengeSenderDocument['duedate'].toDate();
        challengeDocument['userchallengeid'] =
            userChallengeSenderDocumentSnapshot.id;

        allChallengesDetails.add(challengeDocument);
      }

      for (DocumentSnapshot userChallengeReceiverDocumentSnapshot
          in userChallengeReceiverQuerySnapshot.docs) {
        DocumentSnapshot challengeSnapshot =
            await challenges.doc(oneChallenge).get();

        Map challengeDocument = challengeSnapshot.data() as Map;

        Map userChallengeReceiverDocument =
            userChallengeReceiverDocumentSnapshot.data() as Map;

        // want to know who sent the challenge
        challengeDocument['friend'] = userChallengeReceiverDocument['sender'];
        challengeDocument['reps'] =
            userChallengeReceiverDocument['repsr'].toDouble();
        challengeDocument['goal'] =
            userChallengeReceiverDocument['goal'].toDouble();
        challengeDocument['duedate'] =
            userChallengeReceiverDocument['duedate'].toDate();
        challengeDocument['userchallengeid'] =
            userChallengeReceiverDocumentSnapshot.id;

        allChallengesDetails.add(challengeDocument);
      }
    }

    return allChallengesDetails;
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final String? userID = auth.currentUser?.email;

    getAllChallengesDetails(userID).then((acceptedChallengesList) {
      print(acceptedChallengesList);
    });

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
          LimitedBox(
            maxHeight: 300,
            child: FutureBuilder<List>(
              future: getAllChallengesDetails(userID),
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
                        photo: snapshot.data![index]['photo'],
                        duedate: snapshot.data![index]['duedate'],
                        friend: snapshot.data![index]['friend'],
                        goal: snapshot.data![index]['goal'],
                        reps: snapshot.data![index]['reps'],
                        length: snapshot.data![index]['length'],
                        userchallengeid: snapshot.data![index]
                            ['userchallengeid'],
                      );
                    },
                  );
                }
              },
            ),
          ),
          // ChallengeCard(
          //     id: 'challenge0',
          //     name: 'Challenge',
          //     length: '0 days',
          //     description: 'Challenge description here'),
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
