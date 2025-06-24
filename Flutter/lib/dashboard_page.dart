import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimonial_application/about_us_page.dart';
import 'package:matrimonial_application/favourite_users.dart';
import 'package:matrimonial_application/login_and_register_area/login_screen.dart';
import 'package:matrimonial_application/login_and_register_area/user_register_page.dart';
import 'package:matrimonial_application/user_edit_add_pages/user_list.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences
import 'utils/feedback.dart';

class DashboardPage extends StatefulWidget {
  List<Map<String, dynamic>> listToPrint = [];

  DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  // Function to log out the user and reset "Remember Me" status in SharedPreferences
  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isRememberMe', false); // Set "Remember Me" to false on logout

    // Navigate back to the login screen
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color.fromRGBO(195, 120, 79, 1);
    const Color secondaryColor = Color.fromRGBO(68, 54, 43, 1);
    const Color buttonColor = Color.fromRGBO(227, 159, 112, 0.8);
    const Color textColor = Colors.white;
    const double buttonElevation = 5.0; // Add elevation to the buttons
    const Color drawerHeaderColor = Color.fromRGBO(58, 62, 77, 1);
    const Color drawerBackgroundColor = Color.fromRGBO(191, 153, 143, 1);

    return Scaffold(
      body: Stack(
        children: [
          // Background image with blur effect
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/image/img_2.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Colors.black.withOpacity(0.2),
              ),
            ),
          ),
          ClipPath(
            clipper: WaveClipperTwo(flip: true),
            child: Container(
              height: 170,
              width: double.maxFinite,
              color: secondaryColor,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 50, 0, 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipOval(
                      child: Image.asset(
                        "assets/image/img_2.png",
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 10,),
                    Column(
                      children: [
                        Text("Welcome To," , style: TextStyle(color: Colors.white),),
                        SizedBox(height: 5,),
                        Text("MEETME",
                            style: GoogleFonts.aboreto(
                                textStyle: TextStyle(

                                    color: textColor,
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold)
                            )
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Center(
            // Center the button grid
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20.0), // Add horizontal padding
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // Evenly space buttons in the row
                    children: [
                      // Add User Button
                      buildDashboardButton(
                        icon: Icons.person_add_alt_outlined,
                        label: 'Add User',
                        onPressed: () async {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => UserRegisterPage(),
                            ),
                          );
                        },
                        buttonColor: buttonColor,
                        textColor: textColor,
                        borderColor: secondaryColor,
                        elevation: buttonElevation, // Add elevation
                      ),
                      // User List Button
                      buildDashboardButton(
                        icon: Icons.list_alt,
                        label: 'User List',
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => UserList(),
                            ),
                          );
                        },
                        buttonColor: buttonColor,
                        textColor: textColor,
                        borderColor: secondaryColor,
                        elevation: buttonElevation, // Add elevation
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // Evenly space buttons in the row
                    children: [
                      // Favourite Users Button
                      buildDashboardButton(
                        icon: Icons.favorite,
                        label: 'Favourites',
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => FavouriteUsers(),
                            ),
                          );
                        },
                        buttonColor: buttonColor,
                        textColor: textColor,
                        borderColor: secondaryColor,
                        elevation: buttonElevation, // Add elevation
                      ),
                      // About Us Button
                      buildDashboardButton(
                        icon: Icons.info,
                        label: 'About Us',
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => AboutUsPage(),
                            ),
                          );
                        },
                        buttonColor: buttonColor,
                        textColor: textColor,
                        borderColor: secondaryColor,
                        elevation: buttonElevation, // Add elevation
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      backgroundColor: primaryColor,
      persistentFooterButtons: [
        Text(
          'MeetME',
          style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
        )
      ],
      persistentFooterAlignment: AlignmentDirectional.center,
      drawer: Drawer(
          child: Container( // Wrap the Column in a Container
            color: drawerBackgroundColor, // Set the background color for the entire drawer
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    width: double.maxFinite,
                    color: secondaryColor, // Keep existing header color
                    child: Center(
                      child: Row(
                        children: [
                          ClipOval(
                            child: Image.asset(
                              "assets/image/img_2.png",
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 20,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "A Big Warm Hello!",
                                style: TextStyle(
                                    color: textColor,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Welcome to MeetME!",
                                style: TextStyle(color: textColor, fontSize: 15),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    color: buttonColor, // Keep existing content area color
                    child: ListView( // Use ListView for scrollable content
                      padding: EdgeInsets.zero, // Remove default padding
                      children: [
                        ListTile(
                          leading: Icon(Icons.settings, color: secondaryColor),
                          title: Text('Feedback', style: TextStyle(color: secondaryColor , fontWeight: FontWeight.bold)),
                          onTap: () {
                            // Handle settings tap
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>FeedbackForm())); // Close the drawer
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.help, color: secondaryColor),
                          title: Text('About Developer', style: TextStyle(color: secondaryColor, fontWeight: FontWeight.bold)),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AboutUsPage()));
                          },
                        ),
                        // Add more ListTiles for other options
                      ],
                    ),
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  color: secondaryColor, // Keep existing logout button color
                  child: Center(
                    child: TextButton.icon( // Use TextButton.icon for consistency
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return CupertinoAlertDialog(
                                title: Text(
                                  'LOGOUT',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                content: Text('Are you sure you want to logout?'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        logout();
                                      },
                                      child: Text("Yes")),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('No'))
                                ],
                              );
                            });
                      },
                      icon: Icon(Icons.logout, color: textColor),
                      label: Text("Logout", style: TextStyle(color: textColor)),
                    ),
                  ),
                )
              ],
            ),
          )
      ),
    );
  }

  // Helper function to build dashboard buttons
  Widget buildDashboardButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    required Color buttonColor,
    required Color textColor,
    required Color borderColor,
    double elevation = 0, // Add elevation parameter
  }) {
    return Material(
      // Wrap Container in Material widget for elevation
      elevation: elevation,
      borderRadius: BorderRadius.circular(10),
      color: buttonColor,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(
            10), // Match borderRadius for ripple effect
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: borderColor, width: 5),
            // Removed color here because it's handled by Material widget
          ),
          height: 130,
          width: 130,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: textColor, size: 50),
              const SizedBox(
                  height: 8), // Add some spacing between icon and label
              Text(
                label,
                style: TextStyle(color: textColor, fontSize: 15),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}