import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Queries{
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  Future<void> addUser(String fullName, String email) {
    // Call the user's CollectionReference to add a new user
    return users
        .add({
          'name': fullName,
          'email': email,
          'acceptedChallenges':[]
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
  Future<void> addUserChallenge(String userChallengeId, String challengeId, int goal, int reps, String friend, bool sent, bool accepted) {
    // Call the user's CollectionReference to add a new user
    return users
        .add({
          'challengeId': challengeId,
          'goal':goal,
          'reps':reps,
          'friend':friend,
          'sent':sent,
          'accepted':accepted
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}