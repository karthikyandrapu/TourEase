import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tourease/current_location.dart';
import 'package:tourease/nav_main.dart';
import 'package:tourease/pages/live_safe.dart';
import 'package:tourease/pages/profile_page.dart';
import 'package:tourease/user/user.dart';
import 'package:tourease/user/user_data.dart';
import 'package:tourease/view_full.dart';
import 'package:tourease/widget/custom_icon_button.dart';
import 'package:tourease/widget/location_card.dart';
import 'package:tourease/widget/nearby_places.dart';
import 'package:tourease/widget/recommended_places.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: iNavigationDrawer(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome",
              style: TextStyle(fontFamily: 'Bold-Poppins'),
            ),
            Text(
              _user.email,
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ],
        ),
        actions: const [
          // CustomIconButton(
          //   icon: Icon(Ionicons.search_outline),
          // ),
          Padding(
            padding: EdgeInsets.only(left: 8.0, right: 12),
            child: CustomIconButton(
              icon: Icon(Ionicons.notifications_outline),
            ),
          ),
        ],
      ),
      
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(14),
        children: [
          SearchBar(
            hintText: "Search",
            padding: MaterialStateProperty.all<EdgeInsets>(
                const EdgeInsets.symmetric(horizontal: 15)),
            leading: const Icon(Icons.search),
            elevation: MaterialStateProperty.all<double>(0),
            // trailing: const [Icon(Icons.mic)],
          ),
          // LOCATION CARD
          const LocationCard(),

          const SizedBox(
            height: 15,
          ),
          LiveSafe(),
          // CATEGORIES
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recommendation",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              TextButton(
                  onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ViewFull())),
                  child: const Text("View All"))
            ],
          ),
          const SizedBox(height: 10),
          const RecommendedPlaces(),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Nearby From You",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              TextButton(
                  onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ViewFull())),
                  child: const Text("View All"))
            ],
          ),
          const SizedBox(height: 10),
          const NearbyPlaces(),
        ],
      ),
      
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Ionicons.home_outline),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Ionicons.bookmark_outline),
            label: "Bookmark",
          ),
          BottomNavigationBarItem(
            icon: Icon(Ionicons.location),
            label: "Location",
          ),
          BottomNavigationBarItem(
            icon: Icon(Ionicons.person_outline),
            label: "Profile",
          )
        ],
        onTap: (int index) {
          
          if (index == 2) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => UserLocation()));
          }
          if (index == 3) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => ProfilePage()));
          }
        },
      ),
    );
  }
}
