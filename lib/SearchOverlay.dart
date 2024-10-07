// import 'package:flutter/material.dart';

// class SearchOverlay {
//   OverlayEntry? overlayEntry;

//   void showOverlay(BuildContext context, List<String> relatedWords,
//       Function(String) onSelect) {
//     overlayEntry = OverlayEntry(
//       builder: (context) => Positioned(
//         top: 100.0, // Adjust as needed
//         left: 50.0, // Adjust as needed
//         child: Material(
//           child: Container(
//             width: 200.0, // Adjust as needed
//             height: 200.0, // Adjust as needed
//             child: ListView(
//               children: relatedWords
//                   .map((word) => ListTile(
//                         title: Text(word),
//                         onTap: () {
//                           onSelect(
//                               word); // Pass selected word to parent function
//                           removeOverlay();
//                         },
//                       ))
//                   .toList(),
//             ),
//           ),
//         ),
//       ),
//     );

//     Overlay.of(context).insert(overlayEntry!);
//   }

//   void removeOverlay() {
//     overlayEntry?.remove();
//   }
// }
