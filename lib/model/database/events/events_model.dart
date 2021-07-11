import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';
import '../db_utils.dart';
import 'events.dart';

class EventsModel {

Future<int> insertEvent(Events event) async {
    final db = await DBUtils.init();
    return db.insert(
      'events',
      event.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateEvent(Events event) async {
    final db = await DBUtils.init();
    await db.update(
      'events',
      event.toMap(),
      where: 'id = ?',
      whereArgs: [event.id],
    );
  }

  Future<void> deleteEventWithId(int id) async {
    final db = await DBUtils.init();
    await db.delete(
      'events',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Events>> getAllEvents() async {
    final db = await DBUtils.init();
    final List<Map<String, dynamic>> maps = await db.query('events');
    List<Events> result = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        result.add(Events.fromMap(maps[i]));
      }
    }
    return result;
  }

  Future<Events> getEventWithId(int id) async {
    final db = await DBUtils.init();
    final List<Map<String, dynamic>> maps = await db.query(
      'events',
      where: 'id = ?',
      whereArgs: [id],
    );
    return Events.fromMap(maps[0]);
  }

  Future<Events> getEventWithDate(DateTime when) async {
    DateFormat formatter = DateFormat('yyyy-mm-dd');
    final db = await DBUtils.init();
    final List<Map<String, dynamic>> maps = await db.query(
      'events',
      where: 'when = ?',
      whereArgs: [formatter.format(when)],
    );
    return Events.fromMap(maps[0]);
  }



}