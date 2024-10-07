import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:tourease/user/user.dart';

class UserData {
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static User_Profile myUser = User_Profile(
    image: "https://cbcs.ac.in/wp-content/uploads/2023/08/Shaswat.png",
    name: 'Enter Your Full Name',
    email: FirebaseAuth.instance.currentUser?.email ?? 'Enter You Gmail',
    phone: 'Enter You Phone No',
    aboutMeDescription: 'Enter About Yourself',
    isGuide: false,
    booking: false,
  );

  static User_Profile getUser() => myUser;

  static Future<void> updateUser(User_Profile user) async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      await _firestore
          .collection('users')
          .doc(currentUser.uid)
          .set(user.toJson());
    }
  }

  static StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>?
      listenToUserChanges(Function(User_Profile) onData) {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      return _firestore
          .collection('users')
          .doc(currentUser.uid)
          .snapshots()
          .listen((DocumentSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.exists) {
          User_Profile user = User_Profile.fromJson(snapshot.data()!);
          onData(user);
        }
      });
    } else {
      return null;
    }
  }

  static void disposeUserChangesListener(
      StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>?
          subscription) {
    subscription?.cancel();
  }
}
