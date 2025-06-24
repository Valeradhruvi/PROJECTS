import 'package:flutter/material.dart';
import 'package:matrimonial_application/about_us_page.dart';
import 'package:matrimonial_application/dashboard_page.dart';
import 'package:matrimonial_application/favourite_users.dart';
import 'package:matrimonial_application/login_and_register_area/user_register_page.dart';
import 'package:matrimonial_application/user_edit_add_pages/user_list.dart';

class W1 extends StatefulWidget {
   W1({super.key});

  @override
  State<W1> createState() => _W1State();
}

class _W1State extends State<W1> {
  bool isBottomNavigationBar = true;

  int selectedBottomIndex = 0;

  List<Widget> pages = [
    DashboardPage(),
    UserList(),
    UserRegisterPage(),
    FavouriteUsers(),
    AboutUsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:   pages[selectedBottomIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            selectedBottomIndex = index;
          });
        },
        currentIndex: selectedBottomIndex,
        type: BottomNavigationBarType.shifting,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.brown,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.dashboard_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.list_alt_outlined),
            label: 'Users',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.add),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.favorite_border_sharp),
            label: 'Favourites',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.perm_device_info),
            label: 'About Us',
          ),
        ],
      ),
    );
  }
}
