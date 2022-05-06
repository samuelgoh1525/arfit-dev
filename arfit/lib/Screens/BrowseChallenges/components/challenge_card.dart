// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:arfit/constants.dart';
import 'package:flutter/material.dart';
import 'package:arfit/queries.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChallengeCard extends StatelessWidget {
  // const ChallengeCard({Key? key}) : super(key: key);
  final String id;
  final String name;
  final int length;
  final int goal;
  final String description;
  final String photo;

  const ChallengeCard({
    Key? key,
    required this.id,
    required this.name,
    required this.length,
    required this.description,
    required this.photo,
    required this.goal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => SimpleDialog(
            title: Text('Send to a Friend'),
            children: <Widget>[UserInformation(id, goal, length, name)],
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
                        bottom: 5,
                      ),
                      child: Text(name),
                    ),
                    subtitle: RichText(
                      text: TextSpan(
                        text: 'Finish in ' +
                            length.toString() +
                            (length > 1 ? ' days' : ' day') +
                            '\n',
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontFamily: 'Futura Heavy',
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: description,
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontFamily: 'Futura Heavy',
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UserInformation extends StatefulWidget {
  final String id;
  final int goal;
  final int length;
  final String name;
  const UserInformation(this.id, this.goal, this.length, this.name);

  @override
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('users').snapshots();

  CollectionReference userChallenges =
      FirebaseFirestore.instance.collection('userChallenges');

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final String? userEmail = auth.currentUser?.email;
    return SizedBox(
        height: 200,
        width: 200,
        child: StreamBuilder<QuerySnapshot>(
          stream: _usersStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }

            return ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                if (data['email'] == userEmail) {
                  return SizedBox(
                    width: 0,
                    height: 0,
                  );
                }
                return SimpleDialogOption(
                  onPressed: () {
                    Queries.addUserChallenge(
                      userChallenges,
                      widget.id,
                      widget.goal,
                      widget.length,
                      data['email'],
                      userEmail,
                      widget.name,
                    );
                    Navigator.pop(context, data['name']);
                  },
                  child: Text(data['email'] == userEmail ? "" : data['name']),
                );
              }).toList(),
            );
          },
        ));
  }
}
