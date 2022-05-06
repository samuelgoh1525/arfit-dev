import 'package:cloud_firestore/cloud_firestore.dart';

class Queries {
  // FirebaseFirestore firestore = FirebaseFirestore.instance;

  // CollectionReference users = FirebaseFirestore.instance.collection('users');
  static addUser(
    CollectionReference users,
    String username,
    String email,
  ) {
    return users
        .doc(email)
        .set({
          'email': email,
          'name': username,
          'acceptedChallenges': [],
          'email': email,
          'photo': "https://cdn-icons-png.flaticon.com/512/64/64572.png",
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  static removeUserChallenge(
      CollectionReference userChallenges, String userChallengeID) {
    return userChallenges
        .doc(userChallengeID)
        .delete()
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  static addUserChallenge(
    CollectionReference userChallenges,
    String challengeId,
    int goal,
    int length,
    String receiver,
    String? sender,
  ) {
    return userChallenges
        .add({
          'challengeID': challengeId,
          'goal': goal,
          'repsr': 0,
          'repss': 0,
          'receiver': receiver,
          'sender': sender,
          'accepted': false,
          'duedate':
              Timestamp.fromDate(DateTime.now().add(Duration(days: length))),
        })
        .then((docRef) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  static addAcceptedChallenge(
      CollectionReference users, String challengeId, String email) {
    return users
        .doc(email)
        .update({
          'acceptedChallenges': FieldValue.arrayUnion([challengeId])
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  static acceptUserChallenge(
      CollectionReference userChallenges, String userChallengeID) {
    // Call the user's CollectionReference to add a new user
    return userChallenges
        .doc(userChallengeID)
        .update({'accepted': true})
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  static updateReps(
      CollectionReference userChallenges, String userChallengeID, int reps) {
    // Call the user's CollectionReference to add a new user
    return userChallenges
        .doc(userChallengeID)
        .update({'reps': reps})
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
