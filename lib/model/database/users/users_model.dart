import 'dart:async';
import 'package:sqflite/sqflite.dart';
import '../db_utils.dart';
import 'users.dart';

//users model class to handle local database interaction for sqflite
class UsersModel {

  //insert a user into the db
  Future<int> insertUsers(Users users) async {
    final db = await DBUtils.init();
    return db.insert(
      'users',
      users.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // update a current users information
  Future<void> updateUsers(Users users) async {
    final db = await DBUtils.init();
    await db.update(
      'users',
      users.toMap(),
      where: 'id = ?',
      whereArgs: [users.id],
    );
  }

  // update a current users password
  Future<void> updateUsersPassword(String password, int id) async {
    final db = await DBUtils.init();
    await db.rawUpdate('''
    UPDATE users 
    SET password = ? 
    WHERE id = ?
    ''', 
    [password, id]);
  }

  // used to delete a current user with there username and password
  Future<void> deleteUsersWithUsernameAndPassword(String name, String pwd) async {
    final db = await DBUtils.init();
    await db.delete(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [name, pwd],
    );
  }
  
  // displays all users in a list
  Future<List<Users>> getAllUsers() async {
    final db = await DBUtils.init();
    final List<Map<String, dynamic>> maps = await db.query('users');
    List<Users> result = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        result.add(Users.fromMap(maps[i]));
      }
    }
    return result;
  }

  // gets a current user using username and password
  Future<Users> getUserWithUsernameAndPassword(String name, String pwd) async {
    final db = await DBUtils.init();
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [name, pwd],
    );
    if(maps.isEmpty == true){
      return null;
    }else{
    return Users.fromMap(maps[0]);
    }
  }

  Future<Users> selectLoggedInUser() async {
    final loggedIn = 1;
    final db = await DBUtils.init();
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'isloggedIn = ?',
      whereArgs: [loggedIn],
    );
    if(maps.isEmpty == true){
      return null;
    } else {
      return Users.fromMap(maps[0]);
    }
  }
  Future<Users> getUserWithId(int id) async {
    final db = await DBUtils.init();
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
    if(maps.isEmpty == true){
      return null;
    } else {
      return Users.fromMap(maps[0]);
    }
  }

  // update a current users information
  Future<void> updateLogin(int login, Users user) async {
    final db = await DBUtils.init();
    await db.rawUpdate('''
    UPDATE users 
    SET isLoggedIn = ? 
    WHERE id = ?
    ''', 
    [login, user.id]);
  }
}
