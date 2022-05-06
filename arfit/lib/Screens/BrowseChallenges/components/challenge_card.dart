// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:arfit/constants.dart';
import 'package:flutter/material.dart';

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
        showDialog<String>(
          context: context,
          builder: (_) => SimpleDialog(
            title: Text('Send to:'),
          ),
        );
        // AlertDialog(
        //       title: const Text('AlertDialog Title'),
        //       content: const Text('AlertDialog description'),
        //       actions: <Widget>[
        //         TextButton(
        //           onPressed: () => Navigator.pop(context, 'Cancel'),
        //           child: const Text('Cancel'),
        //         ),
        //         TextButton(
        //           onPressed: () => Navigator.pop(context, 'OK'),
        //           child: const Text('OK'),
        //         ),
        //       ],
        //     ));
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
