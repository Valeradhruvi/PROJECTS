import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimonial_application/api/api_service.dart';
import 'package:matrimonial_application/api/user_model.dart';
import 'package:matrimonial_application/login_and_register_area/user_register_page.dart';
import 'package:matrimonial_application/user_edit_add_pages/user_details.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  bool isAscending = true;
  String sortBy = "Name";
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = "";
  final ApiService apiService = ApiService();
  late Future<List<UserData>> userFuture;

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  void _fetchUsers() {
    setState(() {
      userFuture = apiService.getAllUser();
    });
  }

  List<UserData> getFilteredAndSortedUserList(List<UserData> users) {
    List<UserData> filteredUsers = users.where((user) {
      return (user.name?.toLowerCase().contains(searchQuery.toLowerCase()) ??
          false) ||
          (user.country?.toLowerCase().contains(searchQuery.toLowerCase()) ??
              false) ||
          (user.age?.toString().contains(searchQuery) ?? false);
    }).toList();

    filteredUsers.sort((a, b) {
      if (sortBy == "Name") {
        return isAscending
            ? (a.name ?? "").toLowerCase().compareTo((b.name ?? "").toLowerCase())
            : (b.name ?? "").toLowerCase().compareTo((a.name ?? "").toLowerCase());
      } else {
        return isAscending
            ? (a.age).compareTo(b.age )
            : (b.age).compareTo(a.age );
      }
    });

    return filteredUsers;
  }

  void _toggleFavorite(UserData user) async {
    try {
      await apiService.toggleFavorite(user.id!, user.isFav);
      _fetchUsers(); // Refresh after toggling
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to toggle favorite: $e')),
      );
    }
  }

  void _deleteUser(UserData user) async {
    try {
      await apiService.deleteUser(user.id!);
      _fetchUsers(); // Refresh after deleting
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete user: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('User List',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
        ),
        backgroundColor: const Color.fromRGBO(195, 120, 79, 0.8),
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
            child: Container(color: Colors.black.withOpacity(0.2)),
          ),
          FutureBuilder<List<UserData>>(
            future: userFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text("No Users Found"));
              } else {
                List<UserData> filteredUsers =
                getFilteredAndSortedUserList(snapshot.data!);
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Card(
                        elevation: 5,
                        color: Colors.white.withOpacity(0.9), // Added transparency
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _searchController,
                                  onChanged: (query) {
                                    setState(() {
                                      searchQuery = query;
                                    });
                                  },
                                  decoration: const InputDecoration(
                                    hintText: 'Search users...',
                                    border: InputBorder.none,
                                    prefixIcon: Icon(Icons.search),
                                  ),
                                ),
                              ),
                              DropdownButton<String>(
                                value: sortBy,
                                onChanged: (newValue) {
                                  setState(() {
                                    sortBy = newValue!;
                                  });
                                },
                                items: const [
                                  DropdownMenuItem(
                                      value: "Name", child: Text("Name")),
                                  DropdownMenuItem(
                                      value: "Age", child: Text("Age")),
                                ],
                              ),
                              TextButton(
                                child: Text(isAscending ? "ASC" : "DSC"),
                                onPressed: () {
                                  setState(() {
                                    isAscending = !isAscending;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: filteredUsers.length,
                        itemBuilder: (context, index) {
                          return getList(filteredUsers, index);
                        },
                      ),
                    ),
                  ],
                );
              }
            },
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

  Widget getList(List<UserData> users, int index) {
    var userData = users[index];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.white.withOpacity(0.9),
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: ListTile(
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => UserDetails(index: userData.id!),
              ),
            );
          },
          title: Text(
            userData.name ?? 'Unknown',
            style: GoogleFonts.habibi(
              textStyle: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            "${userData.age ?? 'N/A'} | ${userData.country ?? 'Unknown'}",
            style: GoogleFonts.habibi(
              textStyle: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ),
          trailing: Wrap(
            children: [
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.blue),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => UserRegisterPage(
                          index: userData.id,
                          isEdit: true,
                          userDetailss: userData),
                    ),
                  );
                  setState(() {});
                },
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => CupertinoAlertDialog(
                      title: const Text("Delete User"),
                      content:
                      const Text("Are you sure you want to delete this user?"),
                      actions: [
                        TextButton(
                          child: const Text("Cancel"),
                          onPressed: () => Navigator.pop(context),
                        ),
                        TextButton(
                          child: const Text("Delete",
                              style: TextStyle(color: Colors.red)),
                          onPressed: () {
                            Navigator.pop(context);
                            _deleteUser(userData);
                          },
                        ),
                      ],
                    ),
                  );
                },
                icon: const Icon(Icons.delete, color: Colors.black),
              ),
              IconButton(
                onPressed: () => _toggleFavorite(userData),
                icon: Icon(
                  userData.isFav ? Icons.favorite : Icons.favorite_outline,
                  color: userData.isFav ? Colors.red : Colors.black,
                ),
              ),
            ],
          ),
          leading: CircleAvatar(
            backgroundColor: const Color.fromRGBO(195, 120, 79, 1.0),
            child: Text(
              userData.name?[0].toUpperCase() ?? '?',
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}