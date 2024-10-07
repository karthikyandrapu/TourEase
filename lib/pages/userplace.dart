// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class MapScreen extends StatefulWidget {
//   final LatLng destination;

//   MapScreen({required this.destination});

//   @override
//   _MapScreenState createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
//   late GoogleMapController mapController;
//   Directions directions = GoogleMapsDirections(apiKey: 'YOUR_API_KEY');

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Route Map'),
//       ),
//       body: GoogleMap(
//         initialCameraPosition: CameraPosition(
//           target: widget.destination,
//           zoom: 14.0,
//         ),
//         onMapCreated: (GoogleMapController controller) {
//           setState(() {
//             mapController = controller;
//           });
//           _showRoute();
//         },
//       ),
//     );
//   }

//   Future<void> _showRoute() async {
//     DirectionsResponse response = await directions.route(
//       Location(
//         lat: mapController.cameraPosition.target.latitude,
//         lng: mapController.cameraPosition.target.longitude,
//       ),
//       Location(
//         lat: widget.destination.latitude,
//         lng: widget.destination.longitude,
//       ),
//       travelMode: TravelMode.driving,
//     );

//     if (response.isOkay) {
//       final route = response.routes.first;
//       final overview = route.overviewPolyline;
//       List<LatLng> points = PolylinePoints().decodePolyline(overview.points);

//       mapController.animateCamera(
//         CameraUpdate.newLatLngBounds(route.bounds!),
//       );

//       mapController.addPolyline(Polyline(
//         polylineId: PolylineId('route'),
//         points: points,
//         color: Colors.blue,
//         width: 5,
//       ));
//     } else {
//       // Handle error when no route is found
//     }
//   }
// }
