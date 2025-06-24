import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:matrimonial_application/dashboard_page.dart';
import 'package:matrimonial_application/login_and_register_area/user_register_page.dart';
import 'package:matrimonial_application/login_and_register_area/login_screen.dart'; // Import LoginScreen

class WelcomePage extends StatefulWidget {
  WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  @override
  void initState() {
    super.initState();
    // Adding a delay before checking for "Remember Me"
    Future.delayed(Duration(seconds: 2), () {
      _checkLoginStatus();
    });
  }

  // Check the login status based on SharedPreferences
  _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isRememberMe = prefs.getBool('rememberMe') ?? false; // Default to false if not found

    if (isRememberMe) {
      // If "Remember Me" is true, navigate to Dashboard
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => DashboardPage()));
    } else {
      // If "Remember Me" is false, navigate to Login Screen
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/image/img_2.png'),
                  fit: BoxFit.fitHeight),
            ),
          ),
          Container(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Colors.black.withOpacity(0), // Transparent to let blur show through
              ),
            ),
          ),
          Center(
            child: Container(
              height: double.maxFinite,
              width: double.maxFinite,
              color: Colors.black38,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 60,
                    width: 80,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/image/rings-removebg-preview.png'),
                          fit: BoxFit.cover),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "MeetMe",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "💍Manifest your perfect match here!💍",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 30),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => DashboardPage()));
                  //   },
                  //   child: Text('Get Started'),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
