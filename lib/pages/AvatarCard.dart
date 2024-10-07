import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tourease/user/user.dart';
import 'package:tourease/user/user_data.dart';

class AvatarCard extends StatefulWidget {
  const AvatarCard({super.key});

  @override
  State<AvatarCard> createState() => _AvatarCardState();
}

class _AvatarCardState extends State<AvatarCard> {
  late User_Profile _user;
  late StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>?
      _subscription;

  @override
  void initState() {
    super.initState();

    // Initialize user data
    _user = UserData.myUser;

    // Listen for changes to user data
    _subscription = UserData.listenToUserChanges((User_Profile updatedUser) {
      setState(() {
        _user = updatedUser;
      });
    });
  }

  @override
  void dispose() {
    // Dispose of the subscription when the widget is disposed
    UserData.disposeUserChangesListener(_subscription);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.network(
          _user.image,
          width: 80,
          height: 80,
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _user.email,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 126, 123, 123),
              ),
            ),
            // Text(
            //   "Youtube Channel",
            //   style: TextStyle(
            //     fontSize: 16,
            //     color: Colors.grey.shade600,
            //   ),
            // )
          ],
        )
      ],
    );
  }
}
