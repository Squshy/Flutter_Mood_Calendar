import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';
import '../db_utils.dart';
import 'mood.dart';

class MoodModel {
  Future<int> insertMood(Mood mood) async {
    final db = await DBUtils.init();
    return db.insert(
      'moods',
      mood.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> updateMood(Mood mood) async {
    final db = await DBUtils.init();
    return await db.update(
      'moods',
      mood.toMap(),
      where: 'id = ?',
      whereArgs: [mood.id],
    );
  }

  Future<void> deleteMoodWithId(int id) async {
    final db = await DBUtils.init();
    await db.delete(
      'moods',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Mood>> getAllMoods() async {
    final db = await DBUtils.init();
    final List<Map<String, dynamic>> maps = await db.query('moods');
    List<Mood> result = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        result.add(Mood.fromMap(maps[i]));
      }
    }
    return result;
  }

  Future<Mood> getMoodWithId(int id) async {
    final db = await DBUtils.init();
    final List<Map<String, dynamic>> maps = await db.query(
      'moods',
      where: 'id = ?',
      whereArgs: [id],
    );
    return Mood.fromMap(maps[0]);
  }

  Future<Mood> getMoodWithDate(DateTime when) async {
    DateFormat formatter = DateFormat('yyyy-mm-dd');
    final db = await DBUtils.init();
    final List<Map<String, dynamic>> maps = await db.query(
      'mood',
      where: 'when = ?',
      whereArgs: [formatter.format(when)],
    );
    return Mood.fromMap(maps[0]);
  }

  Future<List<Mood>> getMoodForUser(int id) async {
    final db = await DBUtils.init();
    final List<Map<String, dynamic>> maps = await db.query(
      'moods',
      where: 'user_id = ?',
      whereArgs: [id],
    );
    List<Mood> result = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        result.add(Mood.fromMap(maps[i]));
      }
    }
    return result;
  }
}
