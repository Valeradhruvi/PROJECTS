import 'dart:ui';

import 'package:flutter/material.dart';

class AddUser extends StatelessWidget {
  const AddUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add user'),
        backgroundColor: Colors.brown,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/image/img_6.png'),fit: BoxFit.cover)
            ),
          ),
          Container(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                  sigmaX: 5, sigmaY: 5), // Adjust blur intensity
              child: Container(
                color: Colors.black
                    .withOpacity(0), // Transparent to let blur show through
              ),
            ),
          ),
        ],
      ),
    );
  }
}
