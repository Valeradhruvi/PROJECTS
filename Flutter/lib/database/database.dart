import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class MyDatabase {
  static const String MATRIMONIALPP = 'matrimonialpp';

  static const String ID = 'id';
  static const String NAME = 'name';
  static const String ADDRESS = 'address';
  static const String EMAIL = 'email';
  static const String NUMBER = 'number';
  static const String AGE = 'age';
  static const String HEDUCATION = 'hEducation';
  static const String OCCUPATION = 'occupation';
  static const String COUNTRY = 'country';
  static const String STATE = 'state';
  static const String CITY = 'city';
  static const String GENDER = 'gender';
  static const String DOB = 'dob';
  static const String HOBBY = 'hobby';
  static const String PASSWORD = 'password';
  static const String CONFIRMPASSWORD = 'confirmPassword';
  static const String ISFAVOURITE = 'IsFavourite';

  int DB_VERSION = 2;  // Incremented database version for migrations

  Future<Database> initDatabase() async {
    final dbPath = await getDatabasesPath();
    print("Database path: $dbPath");  // Check the path

    final path = join(dbPath, 'Matrimony.db');
    print("Database file path: $path");

    return openDatabase(
      path,
      onCreate: (db, version) {
        print("Creating database and table...");
        return db.execute(
          'CREATE TABLE $MATRIMONIALPP ('  // Ensure column names match class constants
              '$ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, '
              '$NAME TEXT NOT NULL, '
              '$ADDRESS TEXT NOT NULL, '
              '$EMAIL TEXT NOT NULL, '
              '$NUMBER TEXT NOT NULL, '
              '$AGE TEXT NOT NULL, '
              '$HEDUCATION TEXT, '  // Allowing null for hEducation initially
              '$OCCUPATION TEXT NOT NULL, '
              '$COUNTRY TEXT NOT NULL, '
              '$STATE TEXT NOT NULL, '
              '$CITY TEXT NOT NULL, '
              '$GENDER TEXT NOT NULL, '
              '$DOB TEXT NOT NULL, '
              '$HOBBY TEXT NOT NULL, '
              '$PASSWORD TEXT NOT NULL, '
              '$CONFIRMPASSWORD TEXT NOT NULL, '
              '$ISFAVOURITE INTEGER DEFAULT 0 NOT NULL);',  // Include default for IsFavourite
        );
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          print("Upgrading to version 2...");

          // Add IsFavourite column first
          await db.execute('''ALTER TABLE $MATRIMONIALPP ADD COLUMN $ISFAVOURITE INTEGER DEFAULT 0;''');

          // Add hEducation column, make it nullable initially
          await db.execute('''ALTER TABLE $MATRIMONIALPP ADD COLUMN $HEDUCATION TEXT;''');
        }
      },
      version: DB_VERSION,
    );
  }
}
