import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tourease/Introduction_Screens/splash_screen.dart';
import 'package:tourease/auth/otp_/phone.dart';
import 'package:tourease/auth/otp_/verify.dart';
import 'package:tourease/firebase_options.dart';
import 'package:tourease/home.dart';
import 'package:tourease/pages/auth_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'splash', // Set an initial route
      routes: {
        'splash': (context) => SplashScreen(),
       'auth': (context) => AuthPage(), // Define your authentication page
        'verify': (context) => MyVerify(),
        'phone': (context) => MyPhone(), // Define your verification page
        'home': (context) => HomePage(),
      },
    );
  }
}
