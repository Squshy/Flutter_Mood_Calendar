import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

// class to intialize the local database with the database tables
class DBUtils {
  static Future<Database> init() async {
    var database = openDatabase(
      path.join(await getDatabasesPath(), 'mood_manager.db'),
      onCreate: (db, version) {
        //create the mood table
        db.execute(
            "CREATE TABLE moods(id INTEGER PRIMARY KEY, user_id Integer, mood INTEGER, mdate TEXT, feelingDescription TEXT, FOREIGN KEY(user_id) REFERENCES users(id))");
            //create the users table
        db.execute(
            "CREATE TABLE users(id INTEGER PRIMARY KEY, username TEXT, password TEXT, gender TEXT, birthday TEXT, isLoggedIn INTEGER, moodColorOne TEXT, moodColorTwo TEXT, moodColorThree TEXT, moodColorFour TEXT, moodColorFive TEXT, moodColorSix TEXT)");
      },
      version: 6,
    );
    return database;
  }
}
