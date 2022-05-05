// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:arfit/Screens/Login/login_screen.dart';
import 'package:arfit/Screens/Signup/components/background.dart';
import 'package:arfit/authentication_service.dart';
import 'package:arfit/components/already_have_an_account_check.dart';
import 'package:arfit/components/rounded_button.dart';
import 'package:arfit/components/rounded_input_field.dart';
import 'package:arfit/components/rounded_password_field.dart';
import 'package:arfit/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  final Widget child;
  Body({
    Key? key,
    required this.child,
  }) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    CollectionReference users = FirebaseFirestore.instance.collection('users');

    Future<void> addUser() {
      // Call the user's CollectionReference to add a new user
      return users
          .add({
            'name': "testing123", // John Doe
            'acceptedChallenges': [], // Stokes and Sons
            'id': "idtesting123" // 42
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Text(
            //   "SIGN UP",
            //   style: TextStyle(
            //     fontWeight: FontWeight.bold,
            //     fontSize: 20,
            //   ),
            // ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/signup-fitness.svg",
              height: size.height * 0.35,
            ),
            // SizedBox(height: size.height * 0.03),
            RoundedInputField(
              textController: emailController,
              hintText: "Your Email",
              icon: Icons.person,
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              textController: passwordController,
              onChanged: (value) {},
            ),
            RoundedButton(
              text: "SIGN UP",
              press: () {
                context.read<AuthenticationService>().signUp(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                    );

                addUser();

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
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            // OrDivider(),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: <Widget>[
            //     SocialIcon(
            //       iconSrc: "assets/icons/facebook.svg",
            //       press: () {},
            //     ),
            //     SocialIcon(
            //       iconSrc: "assets/icons/twitter.svg",
            //       press: () {},
            //     ),
            //     SocialIcon(
            //       iconSrc: "assets/icons/google-plus.svg",
            //       press: () {},
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
