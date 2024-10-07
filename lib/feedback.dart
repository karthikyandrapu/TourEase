import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RatingFeedbackScreen extends StatefulWidget {
  @override
  _RatingFeedbackScreenState createState() => _RatingFeedbackScreenState();
}

class _RatingFeedbackScreenState extends State<RatingFeedbackScreen> {
  double rating = 0;
  final TextEditingController feedbackController = TextEditingController();

  void _handleRating(double value) {
    setState(() {
      rating = value;
    });
  }

  void _handleSubmit() {
    String feedback = feedbackController.text;
    // Implement your feedback submission logic here

    // Reset the form after submission if needed
    setState(() {
      rating = 0;
      feedbackController.clear();
    });

    // Show a toast message after submission
    Fluttertoast.showToast(
        msg: "Feedback submitted!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black45,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rating and Feedback'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RatingBar.builder(
              initialRating: rating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 45,
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: _handleRating,
            ),
            SizedBox(height: 20),
            Text(
              "How was your experience?",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 250.0,
              child: AnimatedTextKit(
                animatedTexts: [
                  TyperAnimatedText(
                    'Provide your feedback below:',
                    textStyle: TextStyle(fontSize: 20),
                    speed: Duration(milliseconds: 100),
                  ),
                ],
                isRepeatingAnimation: false,
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextFormField(
                controller: feedbackController,
                decoration: InputDecoration(
                  labelText: 'Feedback',
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _handleSubmit,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Flutter Rating and Feedback',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: RatingFeedbackScreen(),
  ));
}
