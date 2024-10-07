import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tourease/Introduction_Screens/onboarding_screen.dart';
import 'package:tourease/pages/auth_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  Future<bool> _hasOnboardingBeenShown() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasBeenShown = prefs.getBool('onboarding_shown') ?? false;
    return hasBeenShown;
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(
      Duration(seconds: 4),
      () async {
        bool onboardingShown = await _hasOnboardingBeenShown();
        if (onboardingShown) {
          // Onboarding has been shown before, navigate to login or home page
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (_) => AuthPage()), // Change to your login page
          );
        } else {
          // Onboarding hasn't been shown before, navigate to OnBoardingScreen
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => OnBoardingScreen()),
          );

          // Set a flag in shared preferences to indicate onboarding has been shown
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool('onboarding_shown', true);
        }
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // decoration: const BoxDecoration(
            //   gradient: LinearGradient(
            //     colors: [Colors.white],
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                'Welcome to TourEase',
                style: TextStyle(
                  color: Color.fromARGB(255, 155, 183, 220),
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Center(child: Lottie.asset('lib/images/splash_screen.json')),
            SizedBox(height: 20),
            Text(
              'Let We Be Your Path!',
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18,
                  fontFamily: 'Bold-Poppins'),
            ),
          ],
        ),
      ),
    )));
  }
}
