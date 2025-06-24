import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FeedbackForm extends StatefulWidget {
  const FeedbackForm({Key? key}) : super(key: key);

  @override
  State<FeedbackForm> createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  double _rating = 0.0;
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Feedback",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromRGBO(195, 126, 84, 0.8),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/image/img_2.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              color: Color.fromRGBO(68, 54, 43, 1),
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView( // Make scrollable if content overflows
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Rate your experience:',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Center(
                      child: RatingBar.builder(
                        initialRating: _rating,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Color.fromRGBO(195, 126, 84, 1),
                        ),
                        onRatingUpdate: (rating) {
                          setState(() {
                            _rating = rating;
                            print(_rating);
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    const Text(
                      'Tell us more:',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    TextFormField(
                      controller: _descriptionController,
                      maxLines: 5,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Write your feedback here...',
                        hintStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.6),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () {
                        // Implement your feedback submission logic here
                        print('Rating: $_rating');
                        print('Description: ${_descriptionController.text}');

                        // Show a confirmation dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CupertinoAlertDialog(
                              title: const Text("Thank You!", style: TextStyle(color: Color.fromRGBO(195, 126, 84, 0.8))),
                              content: const Text("Your feedback has been submitted.", style: TextStyle(color: Colors.black)),
                              actions: [
                                TextButton(
                                  child: const Text("OK", style: TextStyle(color: Color.fromRGBO(195, 126, 84, 0.8))),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );


                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(195, 126, 84, 0.8),
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        textStyle: const TextStyle(fontSize: 18.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: const Text(
                        'Submit Feedback',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}