import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:matrimonial_application/dashboard_page.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isRememberMe = false;

  // Function to save the remember me preference
  void saveRememberMePreference(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isRememberMe', value);
  }

  // Function to handle login and save the preference
  void handleLogin() async {
    if (_formKey.currentState!.validate()) {
      saveRememberMePreference(isRememberMe); // Save the preference

      // Navigate to DashboardPage
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => DashboardPage()),
      );
    }
  }

  // Check "Remember Me" status during app initialization
  void checkRememberMe() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool rememberMe = prefs.getBool('isRememberMe') ?? false;

    if (rememberMe) {
      // If the user selected "Remember Me", skip login and go directly to the dashboard
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => DashboardPage()),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    checkRememberMe(); // Check the "Remember Me" status on app start
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
                fit: BoxFit.cover,
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              color: Colors.black.withOpacity(0.2),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Sign in to MeetMe",
                    style: GoogleFonts.habibi(
                      textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),)
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(90, 50, 33, 1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: emailController,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: "Enter Your Email Address",
                              labelStyle: GoogleFonts.abel(textStyle: TextStyle(color: Colors.white70)),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white70),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your email address";
                              } else if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(value)) {
                                return "Please enter a valid email address";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          // Password field and Remember Me checkbox
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                controller: _passwordController,
                                obscureText: _obscurePassword,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  labelText: "Enter Password",
                                  labelStyle: GoogleFonts.abel(textStyle: TextStyle(color: Colors.white70)),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white70),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscurePassword ? Icons.visibility_off : Icons.visibility,
                                      color: Colors.white70,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _obscurePassword = !_obscurePassword;
                                      });
                                    },
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter a password";
                                  } else if (value.length < 6) {
                                    return "Password must be at least 6 characters long";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Checkbox(
                                    side: BorderSide(color: Colors.white),
                                    value: isRememberMe,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        isRememberMe = value ?? false;
                                      });
                                    },
                                  ),
                                  Text(
                                    "Remember Me",
                                    style: GoogleFonts.abel(textStyle: TextStyle(color: Colors.white)),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: handleLogin,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text("Sign In" , style: GoogleFonts.habibi(textStyle: TextStyle(color: Colors.black , fontWeight: FontWeight.bold)),),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      backgroundColor: const Color.fromRGBO(195, 120, 79, 0.8),
      persistentFooterButtons: [
        Text('MeetME' , style: TextStyle(fontWeight: FontWeight.bold , color: Colors.white),)
      ],
      persistentFooterAlignment: AlignmentDirectional.center,
    );
  }
}
