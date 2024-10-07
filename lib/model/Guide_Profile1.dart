// import 'package:flutter/material.dart';
// import 'package:tourease/pages/guides_page.dart';

// class GuidesProfilePage extends StatelessWidget {
//   final Guide guide;
//   GuidesProfilePage({required this.guide});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Card(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15.0),
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 height: MediaQuery.of(context).size.height * .5,
//                 child: Stack(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(bottom: 40.0),
//                       child: Container(
//                         height: MediaQuery.of(context).size.height,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.only(
//                             bottomLeft: Radius.elliptical(
//                                 MediaQuery.of(context).size.width * 0.5, 100.0),
//                             bottomRight: Radius.elliptical(
//                                 MediaQuery.of(context).size.width * 0.5, 100.0),
//                           ),
//                           image: const DecorationImage(
//                             fit: BoxFit.cover,
//                             image: NetworkImage(
//                                 'https://i.pinimg.com/564x/1e/7f/85/1e7f85e354e1a11b4a439ac9d9f7e283.jpg'),
//                           ),
//                         ),
//                         child: ClipOval(
//                           child: Image.network(
//                             guide.image, // Replace with the URL you want to use
//                             height: 150,
//                             width: 150,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                     ),
//                     Align(
//                       alignment: Alignment.topCenter,
//                       child: Stack(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(left: 10, top: 10),
//                             child: Icon(
//                               Icons.close,
//                               color: Color(0xffC3C3C3),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(left: 10, top: 10),
//                             child: Align(
//                               alignment: Alignment.topCenter,
//                               child: Text(
//                                 guide.username,
//                                 style: TextStyle(
//                                   color: Color(0xffBDBDBD),
//                                   fontSize: 25,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Align(
//                       alignment: Alignment.bottomCenter,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           CircleAvatar(
//                             radius: 30,
//                             backgroundColor: Color(0xffD8D8D8),
//                             child: IconButton(
//                               icon: Icon(
//                                 Icons.chat,
//                                 size: 30,
//                                 color: Color(0xff6E6E6E),
//                               ),
//                               onPressed: () {
//                                 // Navigate to the MessagePage when the message icon is clicked
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => MessagePage()),
//                                 );
//                               },
//                             ),
//                           ),
//                           CircleAvatar(
//                             radius: 70,
//                             backgroundImage: NetworkImage(
//                                 'https://i.pinimg.com/564x/1e/7f/85/1e7f85e354e1a11b4a439ac9d9f7e283.jpg'),
//                           ),
//                           CircleAvatar(
//                             radius: 30,
//                             backgroundColor: Color(0xffD8D8D8),
//                             child: Icon(
//                               Icons.call,
//                               size: 30,
//                               color: Color(0xff6E6E6E),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
//                 child: Text(
//                   guide.about,
//                   style: TextStyle(fontSize: 15),
//                 ),
//               ),
//               // Row(
//               //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               //   children: [
//               //     Text(
//               //       'Hacker',
//               //       style: TextStyle(
//               //         fontWeight: FontWeight.bold,
//               //       ),
//               //     ),
//               //     Text(
//               //       '|',
//               //       style: TextStyle(
//               //         fontWeight: FontWeight.bold,
//               //       ),
//               //     ),
//               //     Text(
//               //       'Dev',
//               //       style: TextStyle(
//               //         fontWeight: FontWeight.bold,
//               //       ),
//               //     ),
//               //     Text(
//               //       '|',
//               //       style: TextStyle(
//               //         fontWeight: FontWeight.bold,
//               //       ),
//               //     ),
//               //     Text(
//               //       'Android',
//               //       style: TextStyle(
//               //         fontWeight: FontWeight.bold,
//               //       ),
//               //     ),
//               //     Text(
//               //       '|',
//               //       style: TextStyle(
//               //         fontWeight: FontWeight.bold,
//               //       ),
//               //     ),
//               //     Text(
//               //       'Travel',
//               //       style: TextStyle(
//               //         fontWeight: FontWeight.bold,
//               //       ),
//               //     ),
//               //   ],
//               // ),
//               Container(
//                 color: Color(0xffF8F8F8),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(bottom: 16.0),
//                       child: Column(
//                         children: [
//                           Text('Article'),
//                           SizedBox(
//                             height: 15,
//                           ),
//                           Text(
//                             '20',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       height: 50,
//                       width: 1,
//                       color: Colors.black,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(bottom: 16.0),
//                       child: Column(
//                         children: [
//                           Text('Followers'),
//                           SizedBox(
//                             height: 15,
//                           ),
//                           Text(
//                             '200',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       height: 50,
//                       width: 1,
//                       color: Colors.black,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(bottom: 16.0),
//                       child: Column(
//                         children: [
//                           Text('Following'),
//                           SizedBox(
//                             height: 15,
//                           ),
//                           Text(
//                             '80',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class MessagePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Message Page'),
//       ),
//       body: Center(
//         child: Text('This is the Message Page'),
//       ),
//     );
//   }
// }
