// ignore_for_file: prefer_const_constructors

import 'package:arfit/Screens/Profile/components/background.dart';
//import 'package:arfit/Screens/PopUpScreens/send_to.dart' show SendTo;
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

    final FirebaseAuth auth = FirebaseAuth.instance;
    final String? userEmail = auth.currentUser?.email;

    //CollectionReference users = FirebaseFirestore.instance.collection('users');

    // users.doc(documentId).get();

    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
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
                builder: (_) => SimpleDialog(
                  title: Text('Send to a Friend'),
                  children: <Widget>[UserInformation()],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

/*class SimpleDialogItem extends StatelessWidget {
  const SimpleDialogItem({Key? key})
      : super(key: key);

 
  List<String> text = UserInformation();

  @override
  Widget build(BuildContext context) {
    List<Widget> name_Options = [];
    for (String name in text){
      name_Options.add(SimpleDialogOption(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 16.0),
            child: Text(name),
          ),
        ],
      ),
    );
    );
    }
    return name_Options;
  }
}*/

class UserInformation extends StatefulWidget {
  @override
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('users').snapshots();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
            height: 200,
            width: 200,
            child: StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
            print(data['name']);
            return ListTile(
              title: Text(data['name']),
            );
          }).toList(),
        );
      },
    ));
  }
}
