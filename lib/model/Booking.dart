// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:tourease/pages/guides_page.dart';

// class Booking {
//   final User user; // User ID
//   final Guide guide; // Guide details
//   final DateTime bookingDate; // Booking date

//   Booking({
//     required this.user,
//     required this.guide,
//     required this.bookingDate,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'user': user,
//       'guide': guide.toMap(),
//       'bookingDate': bookingDate,
//     };
//   }

//   Booking.fromMap(Map<String, dynamic> map)
//       : user = map['user'],
//         guide = Guide.fromMap(map['guide']),
//         bookingDate = (map['bookingDate'] as Timestamp).toDate();
// }

// Future<void> bookGuide(String userId, Guide guide) async {
//   try {
//     // Create a new booking instance
//     Booking booking = Booking(
//       user: ,
//       guide: guide,
//       bookingDate: DateTime.now(),
//     );

//     // Add the booking data to a Firestore collection
//     final bookingDoc = await FirebaseFirestore.instance
//         .collection('bookings')
//         .add(booking.toMap());

//     // Update the user and guide documents to reference the booking
//     await FirebaseFirestore.instance.collection('users').doc(userId).update({
//       'bookingReference': bookingDoc,
//     });

//     await FirebaseFirestore.instance.collection('guides').doc(guide.id).update({
//       'bookingReference': bookingDoc,
//       'booking': true,
//     });
//   } catch (e) {
//     print("Error updating Firestore: $e");
//   }
// }
