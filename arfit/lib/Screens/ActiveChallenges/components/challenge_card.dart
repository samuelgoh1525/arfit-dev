// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class ChallengeCard extends StatelessWidget {
  // const ChallengeCard({Key? key}) : super(key: key);
  final String id;
  final String name;
  final String length;
  final String description;

  const ChallengeCard(
      {required this.id,
      required this.name,
      required this.length,
      required this.description});

  // @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          showDialog<String>(
              context: context,
              builder: (BuildContext context) =>
                  SimpleDialog(title: Text('Done?')));
        },
        child: Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            height: 110,
            width: double.maxFinite,
            child: Card(
                elevation: 5,
                child:
                    Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  ListTile(
                      leading: Icon(Icons.album),
                      title: Text(name),
                      subtitle: Text(length + '\n' + description)),
                ]))));
  }
}
