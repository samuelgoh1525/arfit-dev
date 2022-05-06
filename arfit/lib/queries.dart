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
      String challengeId,
      int goal,
      String receiver,
      String sender) {
    // Call the user's CollectionReference to add a new user
    return userChallenges
        .add({
          'challengeId': challengeId,
          'goal': goal,
          'repsr': 0,
          'repss': 0,
          'friend': receiver,
          'sender': sender,
          'accepted': false,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
  static addAcceptedChallenge(CollectionReference users, String userChallengeId, String email) {
    // Call the user's CollectionReference to add a new user
    return users
      .doc(email)
      .update({
        'acceptedChallenges': FieldValue.arrayUnion([userChallengeId])
      })
      .then((value) => print("User Added"))
      .catchError((error) => print("Failed to add user: $error"));
  }
  
  static acceptUserChallenge(CollectionReference userChallenges, String userChallengeID) {
    // Call the user's CollectionReference to add a new user
    return userChallenges
      .doc(userChallengeID)
      .update({
        'accepted': true
      })
      .then((value) => print("User Added"))
      .catchError((error) => print("Failed to add user: $error"));
  }


  static updateReps(CollectionReference userChallenges, String userChallengeID, int reps) {
    // Call the user's CollectionReference to add a new user
    return userChallenges
      .doc(userChallengeID)
      .update({
        'reps': reps
      })
      .then((value) => print("User Added"))
      .catchError((error) => print("Failed to add user: $error"));
  }

  
}
