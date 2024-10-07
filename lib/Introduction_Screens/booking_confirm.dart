import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class BookConfirm extends StatefulWidget {
  @override
  _BookConfirmState createState() => _BookConfirmState();
}

class _BookConfirmState extends State<BookConfirm> {
  @override
  void initState() {
    super.initState();
    // Add a delay of 4 seconds (4000 milliseconds)
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pop(context); // Go back to the previous page
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                'Booking Confirmed',
                style: TextStyle(
                  color: Color.fromARGB(255, 155, 183, 220),
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Center(child: Lottie.asset('lib/images/Animation_confirm.json')),
            SizedBox(height: 20),
            // Text(
            //   'Let We Be Your Path!',
            //   style: TextStyle(
            //     color: Colors.black54,
            //     fontSize: 18,
            //     fontFamily: 'Bold-Poppins',
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
