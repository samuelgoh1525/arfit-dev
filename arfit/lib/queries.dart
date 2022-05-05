import 'package:cloud_firestore/cloud_firestore.dart';

class Queries {
  // FirebaseFirestore firestore = FirebaseFirestore.instance;

  // CollectionReference users = FirebaseFirestore.instance.collection('users');
  static addUser(CollectionReference users, String username, String email) {
    // Call the user's CollectionReference to add a new user
    return users
        .doc(email)
        .set({
          'name': username,
          'acceptedChallenges': [],
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  static addUserChallenge(
      CollectionReference userChallenges,
      String userChallengeId,
      String challengeId,
      int goal,
      int reps,
      String friend,
      bool sent,
      bool accepted) {
    // Call the user's CollectionReference to add a new user
    return userChallenges
        .doc(userChallengeId)
        .set({
          'challengeId': challengeId,
          'goal': goal,
          'reps': reps,
          'friend': friend,
          'sent': sent,
          'accepted': accepted,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
