import 'package:matrimonial_application/database/database.dart';
import 'package:sqflite/sqflite.dart';

class User {
  static final User _instance = User._internal();
  factory User() => _instance;
  User._internal();

  List<Map<String, dynamic>> userList = [];
  List<Map<String, dynamic>> favouriteUserList = [];

  Future<Database> get _db async => await MyDatabase().initDatabase();

  // Add User to the database
  void addUserInList({
    required String name,
    required String address,
    required String email,
    required String number,
    required String age,
    required String hEducation,
    required String occupation,
    required String country,
    required String state,
    required String city,
    required String gender,
    required String dob,
    required String hobby,
    required String password,
    required String confrimPassword,
  }) async {
    final db = await _db;

    print("Adding user to database: $name, $address, $email");

    try {
      await db.insert(
        MyDatabase.MATRIMONIALPP,
        {
          MyDatabase.NAME: name,
          MyDatabase.ADDRESS: address,
          MyDatabase.EMAIL: email,
          MyDatabase.NUMBER: number,
          MyDatabase.AGE: age,
          MyDatabase.HEDUCATION: hEducation,
          MyDatabase.OCCUPATION: occupation,
          MyDatabase.COUNTRY: country,
          MyDatabase.STATE: state,
          MyDatabase.CITY: city,
          MyDatabase.GENDER: gender,
          MyDatabase.DOB: dob,
          MyDatabase.HOBBY: hobby,
          MyDatabase.PASSWORD: password,
          MyDatabase.CONFIRMPASSWORD: confrimPassword,
          MyDatabase.ISFAVOURITE: 0, // Default as not favourite
        },
      );
      print("User added successfully to the database!");
    } catch (e) {
      print("Error adding user: $e");
    }
  }

  // Get all users from the database
  Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await _db;
    return await db.query(MyDatabase.MATRIMONIALPP);
  }

  // Get only favourite users from the database
  Future<List<Map<String, dynamic>>> getFavouriteUsers() async {
    final db = await _db;
    return await db.query(
      MyDatabase.MATRIMONIALPP,
      where: '${MyDatabase.ISFAVOURITE} = ?',
      whereArgs: [1], // Only favourite users
    );
  }

  // Update user in the database
  Future<void> updateUser({
    required String name,
    required String address,
    required String email,
    required String number,
    required String age,
    required String hEducation,
    required String occupation,
    required String country,
    required String state,
    required String city,
    required String gender,
    required String dob,
    required String hobby,
    required String password,
    required String confrimPassword,
    required int index, // This is actually the user ID
  }) async {
    final db = await _db;

    print("Updating user with ID: $index");

    int count = await db.update(
      MyDatabase.MATRIMONIALPP,
      {
        MyDatabase.NAME: name,
        MyDatabase.ADDRESS: address,
        MyDatabase.EMAIL: email,
        MyDatabase.NUMBER: number,
        MyDatabase.AGE: age,
        MyDatabase.HEDUCATION: hEducation,
        MyDatabase.OCCUPATION: occupation,
        MyDatabase.COUNTRY: country,
        MyDatabase.STATE: state,
        MyDatabase.CITY: city,
        MyDatabase.GENDER: gender,
        MyDatabase.DOB: dob,
        MyDatabase.HOBBY: hobby,
        MyDatabase.PASSWORD: password,
        MyDatabase.CONFIRMPASSWORD: confrimPassword,
      },
      where: '${MyDatabase.ID} = ?',
      whereArgs: [index], // ✅ Correct: Directly use the ID instead of relying on userList
    );

    if (count > 0) {
      print("User updated successfully!");
    } else {
      print("User update failed! No matching ID found.");
    }
  }


  // Delete user from the database
  void deleteUser(int userId) async {
    final db = await _db;
    await db.delete(
      MyDatabase.MATRIMONIALPP,
      where: '${MyDatabase.ID} = ?',  // Use the ID to delete the user
      whereArgs: [userId],
    );

    // Remove the user from the local list (if the list is loaded)
    userList.removeWhere((user) => user[MyDatabase.ID] == userId);
    favouriteUserList.removeWhere((user) => user[MyDatabase.ID] == userId);
  }

  // Toggle Favourite Status
    Future<void> toggleFavourite(Map<String, dynamic> user) async {
    final db = await _db;
    int userId = user[MyDatabase.ID];
    bool isFavourite = user[MyDatabase.ISFAVOURITE] == 1;

    await db.update(
      MyDatabase.MATRIMONIALPP,
      {MyDatabase.ISFAVOURITE: isFavourite ? 0 : 1}, // Toggle favourite status
      where: '${MyDatabase.ID} = ?',
      whereArgs: [userId],
    );

    if (isFavourite) {
      favouriteUserList.removeWhere((favUser) => favUser[MyDatabase.ID] == userId);
    } else if (!favouriteUserList.any((favUser) => favUser[MyDatabase.ID] == userId)) {
      favouriteUserList.add(user);
    }
  }
}
