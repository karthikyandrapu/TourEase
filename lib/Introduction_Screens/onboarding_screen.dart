import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final int lastPage = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 50.0), // Add a SizedBox for top spacing
          Expanded(
            child: IntroductionScreen(
              globalBackgroundColor: Colors.white,
              scrollPhysics: BouncingScrollPhysics(),
              pages: [
                PageViewModel(
                  titleWidget: Text(
                    "Revolutionize Your Travel Experience",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  body:
                      "Say goodbye to outdated guidebooks and hello to a dynamic, interactive travel experience. Our innovative app puts the power of local insights, real-time information, and personal connections right in your hands.",
                  image: Lottie.asset(
                    'lib/images/animation_screen4.json',
                    height: 400,
                    width: 400,
                  ),
                ),
                PageViewModel(
                  titleWidget: Text(
                    "Seamless, Personalized Adventures Await",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  body:
                      "No more one-size-fits-all itineraries. With our app, you become the guide. Connect with knowledgeable locals, get up-to-the-minute recommendations, and craft a journey that's uniquely yours.",
                  image: Lottie.asset(
                    "lib/images/animation_screen2.json",
                    height: 400,
                    width: 400,
                  ),
                ),
                PageViewModel(
                  titleWidget: Text(
                    "Empowering You with Every Tap",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  body:
                      "Experience travel like never before. Our app offers features like location-based services. It's time to make every moment count.",
                  image: Lottie.asset(
                    "lib/images/animation_screen5.json",
                    height: 400,
                    width: 400,
                  ),
                ),
              ],
              onDone: () {
                Navigator.pushNamed(context, "auth");
              },
              onSkip: () {
                Navigator.pushNamed(context, "auth");
              },
              showSkipButton: true,
              skip: Text(
                "Skip",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFF6C63FF),
                ),
              ),
              next: Icon(
                Icons.arrow_forward,
                color: Color(0xFF6C63FF),
              ),
              done: Text(
                "Done",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFF6C63FF),
                ),
              ),
              dotsDecorator: DotsDecorator(
                size: Size.square(10.0),
                activeSize: Size(20.0, 10.0),
                color: Colors.black26,
                activeColor: Color(0xFF6C63FF),
                spacing: EdgeInsets.symmetric(horizontal: 3.0),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
