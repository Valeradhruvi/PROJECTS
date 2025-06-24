// api/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'user_model.dart';

class ApiService {
  String baseUrl = "https://66718917e083e62ee43c0012.mockapi.io/matrimony";

  Future<List<UserData>> getAllUser() async {
    try {
      final res = await http.get(Uri.parse(baseUrl));

      if (res.statusCode == 200) {
        List<dynamic> data = jsonDecode(res.body);
        List<UserData> users = data.map((element) => UserData.toUser(element)).toList();
        return users;
      } else {
        print("Failed to fetch users. Status code: ${res.statusCode}");
        return []; // Or throw an exception
      }
    } catch (e) {
      print("Error fetching users: $e");
      return []; // Or throw an exception
    }
  }

  Future<void> addUser(UserData user) async {
    try {
      var res = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(user.toMap()),
      );

      print(res.body);
      print(res.statusCode);

      if (res.statusCode != 201 && res.statusCode != 200) { // Check for success status (201 Created is common)
        print("Failed to add user. Status code: ${res.statusCode}");
        print("Response body: ${res.body}");
        throw Exception('Failed to add user'); // Propagate the error
      }
    } catch (e) {
      print("Error adding user: $e");
      throw e; // Re-throw the exception for handling in UI
    }
  }

  Future<void> deleteUser(String id) async {
    var res = await http.delete(Uri.parse("$baseUrl/$id"));
    print("Delete User Response: ${res.statusCode}");
  }

  Future<void> updateUser(UserData user) async {
    try {
      final url = Uri.parse('$baseUrl/${user.id}');
      final headers = {'Content-Type': 'application/json'};
      final body = jsonEncode(user.toMap());

      final response = await http.put(url, headers: headers, body: body);

      print("Update User Response: ${response.statusCode}, ${response.body}");

      if (response.statusCode != 200) {
        print("Failed to update user. Status code: ${response.statusCode}");
        throw Exception('Failed to update user. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print("Error updating user: $e");
      throw Exception('Error updating user: $e');
    }
  }

  Future<UserData> getUserById(String id) async {
    final res = await http.get(Uri.parse('$baseUrl/$id'));

    if (res.statusCode == 200) {
      dynamic u = jsonDecode(res.body);
      UserData user = UserData.toUser(u);
      return user;
    } else {
      print("Failed to get user by ID. Status code: ${res.statusCode}");
      throw Exception('Failed to load user');
    }
  }

  // Toggles the favorite status and updates the API.
  Future<void> toggleFavorite(String userId, bool currentIsFav) async {
    try {
      final url = Uri.parse('$baseUrl/$userId');
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'isFav': !currentIsFav}),
      );

      if (response.statusCode == 200) {
        print('Favorite status updated successfully');
      } else {
        print('Failed to update favorite status. Status code: ${response.statusCode}');
        throw Exception('Failed to update favorite status');
      }
    } catch (error) {
      print('Error toggling favorite status: $error');
      throw Exception('Error toggling favorite status: $error');
    }
  }


  // Get favorite users.  This fetches all users and filters them.
  Future<List<UserData>> getFavoriteUsers() async {
    List<UserData> allUsers = await getAllUser();
    return allUsers.where((user) => user.isFav == true).toList(); // Corrected condition
  }

}