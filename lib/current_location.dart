import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart'; // Import the geolocator package
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ionicons/ionicons.dart';

class UserLocation extends StatefulWidget {
  @override
  _UserLocationState createState() => _UserLocationState();
}

class _UserLocationState extends State<UserLocation> {
  GoogleMapController? _mapController;
  LatLng? _userLocation;
  bool _isLoading = false;
  late BitmapDescriptor userMarkerIcon;

  void addUserMarkerIcon() async {
    final icon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(10, 10)),
      'lib/images/user-marker.png',
    );
    setState(() {
      userMarkerIcon = icon;
    });
  }

  @override
  void initState() {
    addUserMarkerIcon();
    super.initState();
    _startLocationUpdates(); // Start updating the location
  }

  void _startLocationUpdates() {
    // Set up a timer to fetch location every second
    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      _listenForUserLocation();
    });
  }

  void _listenForUserLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      print('Location permission denied');
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _userLocation = LatLng(position.latitude, position.longitude);
    });

    _mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(
        _userLocation!,
        15.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Current location',
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
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Stack(
                children: [
                  GoogleMap(
                    onMapCreated: (controller) {
                      setState(() {
                        _mapController = controller;
                      });
                    },
                    initialCameraPosition: CameraPosition(
                      target: _userLocation ?? LatLng(28.6139, 77.2090),
                      zoom: 15.0,
                    ),
                    markers: {
                      if (_userLocation != null)
                        Marker(
                          markerId: MarkerId('userMarker'),
                          position: _userLocation!,
                          icon: userMarkerIcon,
                        ),
                    },
                  ),
                  if (_isLoading)
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
