// favourite_users.dart
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimonial_application/api/api_service.dart';
import 'package:matrimonial_application/api/user_model.dart';
import 'package:matrimonial_application/user_edit_add_pages/user_details.dart';

class FavouriteUsers extends StatefulWidget {
  const FavouriteUsers({super.key});

  @override
  _FavouriteUsersState createState() => _FavouriteUsersState();
}

class _FavouriteUsersState extends State<FavouriteUsers> {
  String searchQuery = "";
  ApiService apiService = ApiService();
  late Future<List<UserData>> favoriteUsersFuture;

  @override
  void initState() {
    super.initState();
    _fetchFavoriteUsers();
  }

  void _fetchFavoriteUsers() {
    setState(() {
      favoriteUsersFuture = apiService.getFavoriteUsers();
    });
  }

  Future<void> _toggleFavorite(UserData user) async {
    try {
      await apiService.toggleFavorite(user.id!, user.isFav);
      // Re-fetch the favorite users to update the list.
      _fetchFavoriteUsers();
    } catch (e) {
      // Handle error: Show a snackbar or dialog.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to toggle favorite: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Favourite Users',
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
            child: Container(color: Colors.black.withOpacity(0)),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  onChanged: (query) {
                    setState(() {
                      searchQuery = query;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search users...',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                    prefixIcon: const Icon(Icons.search),
                  ),
                ),
              ),
              Expanded(
                child: FutureBuilder<List<UserData>>(
                  future: favoriteUsersFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text("Error: ${snapshot.error}"));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text("No Favourite Users"));
                    } else {
                      List<UserData> favouriteUsers = snapshot.data!;
                      List<UserData> filteredUsers = favouriteUsers
                          .where((user) =>
                      (user.name?.toLowerCase().contains(searchQuery.toLowerCase()) ?? false) ||
                          (user.country?.toLowerCase().contains(searchQuery.toLowerCase()) ?? false))
                          .toList();

                      return ListView.builder(
                        itemCount: filteredUsers.length,
                        itemBuilder: (context, index) {
                          UserData userData = filteredUsers[index];
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(9.0, 7, 9, 0),
                            child: Card(
                              color: Colors.white.withOpacity(0.9),
                              elevation: 6,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => UserDetails(index: userData.id),
                                  ));
                                },
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      userData.name ?? 'Unknown',
                                      style: GoogleFonts.habibi(
                                          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Text(
                                          '${userData.age ?? ''} | ',
                                          style: GoogleFonts.habibi(
                                              textStyle: const TextStyle(fontSize: 13, color: Colors.black45)),
                                        ),
                                        Text(
                                          userData.country ?? 'Unknown',
                                          style: GoogleFonts.habibi(
                                              textStyle: const TextStyle(fontSize: 13, color: Colors.black45)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.favorite, color: Colors.black),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return CupertinoAlertDialog(
                                          title: const Text("Remove From Favourites"),
                                          content: const Text("Are you sure you want to unfavorite this person?"),
                                          actions: [
                                            CupertinoButton(
                                              child: const Text("Yes"),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                _toggleFavorite(userData);
                                              },
                                            ),
                                            CupertinoButton(
                                              child: const Text("No"),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            )
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                                leading: CircleAvatar(
                                  backgroundColor: index % 2 == 0 ? Colors.brown : Colors.grey,
                                  child: Text(
                                    userData.name?[0] ?? '?',
                                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      backgroundColor: const Color.fromRGBO(195, 120, 79, 0.8),
      persistentFooterButtons: const [
        Text('MeetME', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))
      ],
      persistentFooterAlignment: AlignmentDirectional.center,
    );
  }
}