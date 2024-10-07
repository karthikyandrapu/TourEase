import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tourease/profile_edit/edit_description.dart';
import 'package:tourease/profile_edit/edit_email.dart';
import 'package:tourease/profile_edit/edit_image.dart';
import 'package:tourease/profile_edit/edit_name.dart';
import 'package:tourease/profile_edit/edit_phone.dart';
import 'package:tourease/user/user_data.dart';
import 'package:tourease/user/user.dart';
import 'package:tourease/widget/display_image_widget.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>?
      _subscription;
  late User_Profile _user;

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

  Future<void> addRecordToFirestore() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Check if the user already has a record with the same Gmail
      QuerySnapshot querySnapshot = await firestore
          .collection('guides')
          .where('email', isEqualTo: _user.email)
          .get();

      if (querySnapshot.docs.isEmpty) {
        // If no record with the same Gmail exists, create a new record
        Map<String, dynamic> data = {
          'username': _user.name,
          'image': _user.image,
          'about': _user.aboutMeDescription,
          'rating': '4.0',
          'email': _user.email, // Assuming email is a unique identifier
        };

        await firestore.collection('guides').add(data);

        setState(() {
          _user.isGuide = true; // Update _user object
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Record added to guide!'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        // If a record with the same Gmail exists, show a message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Record already exists!'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print('Error adding record to Firestore: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred. Please try again later.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<bool> showConfirmationDialog() async {
    return await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Confirmation'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text(
                        'Have you read and accepted the terms and conditions?'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Yes'),
                  onPressed: () {
                    Navigator.of(context)
                        .pop(true); // Close the dialog with true
                  },
                ),
                TextButton(
                  child: Text('No'),
                  onPressed: () {
                    Navigator.of(context)
                        .pop(false); // Close the dialog with false
                  },
                ),
              ],
            );
          },
        ) ??
        false; // Return false if dialog is dismissed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: Text(
              '',
              style: TextStyle(color: Colors.black),
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              iconSize: 20,
              color: Colors.black,
              icon: const Icon(Ionicons.chevron_back),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                'Edit Profile',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: Color.fromRGBO(64, 105, 225, 1),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              navigateSecondPage(EditImagePage());
            },
            child: DisplayImage(
              imagePath: _user.image,
              onPressed: () {},
            ),
          ),
          SizedBox(
            height: 20,
          ),
          buildUserInfoDisplay(_user.name, 'Full Name', EditNameFormPage()),
          SizedBox(
            height: 15,
          ),
          buildUserInfoDisplay(_user.phone, 'Phone No', EditPhoneFormPage()),
          SizedBox(
            height: 15,
          ),
          buildUserInfoDisplay(_user.email, 'Email', EditEmailFormPage()),
          Expanded(
            child: buildAbout(_user),
            flex: 4,
          )
        ],
      ),
    );
  }

  Widget buildUserInfoDisplay(String getValue, String title, Widget editPage) =>
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                fontFamily: 'Bold-Poppins',
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 1,
            ),
            Container(
              width: 350,
              height: 45,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 163, 212, 237)
                        .withOpacity(0.1), // Shadow color
                    spreadRadius: 1, // Spread radius
                    blurRadius: 4, // Blur radius
                    offset: Offset(0, 2), // Offset from the top
                  ),
                ],
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.grey), // Add border here
                        borderRadius: BorderRadius.circular(
                            5), // Optional: Add border radius
                      ),
                      child: TextButton(
                        onPressed: () {
                          navigateSecondPage(editPage);
                        },
                        child: Text(
                          getValue,
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.4,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Icon(
                  //   Icons.keyboard_arrow_right,
                  //   color: Colors.grey,
                  //   size: 40.0,
                  // ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget buildAbout(User_Profile user) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Text(
              'About',
              style: TextStyle(
                fontSize: 15,
                fontFamily: 'Bold-Poppins',
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 5),
            Container(
              width: 350,
              height: 75,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey), // Add border here
                borderRadius:
                    BorderRadius.circular(10), // Optional: Add border radius
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        navigateSecondPage(EditDescriptionFormPage());
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Center(
                          child: Container(
                            child: Text(
                              user.aboutMeDescription,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins',
                                  height: 1.4,
                                  color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Icon(
                  //   Icons.keyboard_arrow_right,
                  //   color: Colors.grey,
                  //   size: 40.0,
                  // ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                bool accepted = await showConfirmationDialog();
                if (accepted) {
                  addRecordToFirestore();
                }
              },
              child: Text('Add to Guide'),
            )
          ],
        ),
      );

  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  void navigateSecondPage(Widget editForm) {
    Route route = MaterialPageRoute(builder: (context) => editForm);
    Navigator.push(context, route).then(onGoBack);
  }
}
