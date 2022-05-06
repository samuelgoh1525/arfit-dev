// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:arfit/Screens/ActiveChallenges/active_challenges.dart';
import 'package:arfit/components/rounded_input_field.dart';
import 'package:arfit/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ChallengeCard extends StatelessWidget {
  // const ChallengeCard({Key? key}) : super(key: key);
  final String id;
  final String name;
  final DateTime duedate;
  final int length;
  final String friend;
  final String photo;
  final double reps;
  final double goal;
  final String userchallengeid;

  ChallengeCard({
    Key? key,
    required this.id,
    required this.name,
    required this.photo,
    required this.duedate,
    required this.friend,
    required this.reps,
    required this.goal,
    required this.length,
    required this.userchallengeid,
  }) : super(key: key);

  final TextEditingController repsController = TextEditingController();

  Future<void> updateReps(String newReps) async {
    CollectionReference userChallenges =
        FirebaseFirestore.instance.collection('userChallenges');
    DocumentSnapshot documentSnapshot =
        await userChallenges.doc(userchallengeid).get();
    Map document = documentSnapshot.data() as Map;
    if (document['sender'] == friend) {
      print("Friend is sender");
      return userChallenges
          .doc(userchallengeid)
          .update({'repsr': document['repsr'] + double.parse(newReps)});
    } else if (document['receiver'] == friend) {
      print("Friend is receiver");
      return userChallenges
          .doc(userchallengeid)
          .update({'repss': document['repss'] + double.parse(newReps)});
    }
  }

  @override
  Widget build(BuildContext context) {
    final timeLeft = duedate.difference(DateTime.now()).inDays + 1;
    final timeLeftPercent = 1 - timeLeft.toDouble() / length.toDouble();
    final progress = reps / goal;

    final emptyText = repsController.text.trim() == "";

    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Log your progress:'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RoundedInputField(
                  textController: repsController,
                  hintText: "Add reps completed",
                  icon: Icons.fitness_center_sharp,
                  onChanged: (value) {},
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Close',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  updateReps(repsController.text.trim())
                      .then((value) => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const ActiveChallenges())))
                      .catchError((onError) => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const ActiveChallenges())));
                },
                child: Text('Done!'),
              )
            ],
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        height: 110,
        width: double.maxFinite,
        child: Card(
          elevation: 5,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  // leading: Icon(Icons.album),
                  leading: Image.network(photo),
                  title: Padding(
                    padding: const EdgeInsets.only(
                      top: 15,
                      bottom: 15,
                    ),
                    child: Text(name),
                  ),
                  subtitle: LinearPercentIndicator(
                    width: 100,
                    lineHeight: 10,
                    percent: timeLeftPercent,
                    progressColor: timeLeftPercent < 0.33
                        ? Colors.green
                        : (timeLeftPercent < 0.66 ? Colors.amber : Colors.red),
                    barRadius: Radius.circular(5),
                    trailing: Text(
                      timeLeft.toString() + ' days left',
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontFamily: 'Futura Heavy',
                      ),
                    ),
                  ),
                  // subtitle: RichText(
                  //   text: TextSpan(
                  //     text: timeLeft.toString() +
                  //         (timeLeft != 1 ? ' days left' : ' day left') +
                  //         '\n',
                  //     style: TextStyle(
                  //         color: kPrimaryColor, fontFamily: 'Futura Heavy'),
                  //     // children: <TextSpan>[
                  //     //   TextSpan(
                  //     //     text: progress.toString() + ' %',
                  //     //     style: TextStyle(
                  //     //       color: Colors.grey.shade800,
                  //     //       fontFamily: 'Futura Heavy',
                  //     //     ),
                  //     //   ),
                  //     // ],
                  //   ),
                  // ),
                  trailing: Padding(
                    padding: const EdgeInsets.only(
                      top: 5,
                      right: 2,
                    ),
                    child: CircularPercentIndicator(
                      radius: 25,
                      percent: progress,
                      center: Text((progress * 100).toStringAsFixed(0) + '%'),
                      progressColor: progress < 0.33
                          ? Colors.red
                          : (progress < 0.66 ? Colors.amber : Colors.green),
                      circularStrokeCap: CircularStrokeCap.round,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
