import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tourease/Introduction_Screens/booking_confirm.dart';
import 'package:tourease/login/my_button.dart';
import 'package:tourease/pages/chat_page.dart';
import 'package:tourease/pages/guides_page.dart';

class GuidesProfilePage extends StatelessWidget {
  final Guide guide;
  GuidesProfilePage({required this.guide});
  Future<void> bookGuide(Guide guide) async {
    try {
      // Get the current user's email (you should have authenticated the user with Firebase)
      final user = FirebaseAuth.instance.currentUser;
      final userEmail = user?.email;

      if (userEmail != null) {
        // Find the guide's document by their email
        final guideQuery = await FirebaseFirestore.instance
            .collection('guides')
            .where('email', isEqualTo: guide.email)
            .get();

        if (guideQuery.docs.isNotEmpty) {
          final guideDoc = guideQuery.docs.first;

          // Create a reference to the guide's document
          final guideRef =
              FirebaseFirestore.instance.collection('guides').doc(guideDoc.id);

          // Create a new booking document under the guide's document
          final bookingRef = guideRef.collection('bookings').doc();

          // Define the booking data to be stored
          final bookingData = {
            'userEmail': userEmail,
            'timestamp': FieldValue
                .serverTimestamp(), // This adds a server-generated timestamp
          };

          // Set the booking data in the booking document
          await bookingRef.set(bookingData);

          // Update the guide's booking status (you can also add additional checks here)
          await guideRef.update({
            'booking': true,
          });

          // Navigate to the booking confirmation page
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => BookConfirm()),
          // );
        } else {
          // Handle the case where no matching guide was found
          print('Guide not found.');
        }
      } else {
        // Handle the case where the user is not authenticated
        print('User is not authenticated.');
      }
    } catch (e) {
      print("Error booking guide: $e");
    }
  }

  Future<void> updateGuideBookingField() async {
    try {
      // Query Firestore to find the guide by some unique attribute (e.g., name or email)
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('guides')
          .where('email', isEqualTo: guide.email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Update the "guide booking field" for the first matching guide
        await querySnapshot.docs[0].reference.update({
          'booking': true,
        });
      } else {
        // Handle the case where no matching guide was found
        print('Guide not found.');
      }
    } catch (e) {
      print("Error updating Firestore: $e");
    }
  }

  Future<bool> checkGuideBookingStatus() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('guides')
          .where('email', isEqualTo: guide.email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs[0]['booking'] == true;
      } else {
        // Handle the case where no matching guide was found
        print('Guide not found.');
        return false;
      }
    } catch (e) {
      print("Error checking guide booking status: $e");
      return false;
    }
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * .5,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 40.0),
                      child: Container(
                        height: 330,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                'https://wallpapers.net/blurry-city-lights/download/2560x1440.jpg'),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10, top: 10),
                              child: Icon(
                                Icons.arrow_back,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, top: 10),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Text(
                                guide.username.toUpperCase(),
                                style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Color(0xffD8D8D8),
                            child: IconButton(
                              icon: Icon(
                                Icons.chat,
                                size: 30,
                                color: Color(0xff6E6E6E),
                              ),
                              onPressed: () {
                                // Navigate to the MessagePage when the message icon is clicked
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChatPage(
                                      receiveruserEmail: guide.email,
                                      receiverUserID: guide.username,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          CircleAvatar(
                            radius: 70,
                            child: ClipOval(
                              child: Image.network(
                                guide.image,
                                height: 150,
                                width: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Color(0xffD8D8D8),
                            child: Icon(
                              Icons.call,
                              size: 30,
                              color: Color(0xff6E6E6E),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: Column(
                  children: [
                    Icon(
                      Ionicons.star,
                      color: Colors.yellow[800],
                      size: 15,
                    ),
                    Text(
                      '${guide.rating}',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: Container(
                    width: 400,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 195, 222, 245),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        guide.about,
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              MyButton(
                onTap: () async {
                  final isGuideBooked = await checkGuideBookingStatus();
                  if (isGuideBooked) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Guide Already Booked'),
                          content: Text('This guide has already been booked.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    updateGuideBookingField();
                    bookGuide(guide);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BookConfirm()),
                    );
                  }
                },
                text: "Book Now",
                color: Colors.black,
              ),
              Container(
                color: Color(0xffF8F8F8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Add your additional UI elements here if needed
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MessagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Message Page'),
      ),
      body: Center(
        child: Text('This is the Message Page'),
      ),
    );
  }
}
