import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

import '../models/person_model.dart';

class SQLHelper {

  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE people(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        adult TEXT,
        gender NUM,
        id_person NUM,
        known_for_department TEXT,
        name TEXT,
        popularity NUM,
        profile_path TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'movies.db',
      version: 4,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Create new people
  static Future<int> createListPeople(List<PersonModel>? people) async {
    final db = await SQLHelper.db();
    deleteAll();
    for(PersonModel personModel in people!){
      final id = await db.insert('people', personModel.toJson(),
          conflictAlgorithm: sql.ConflictAlgorithm.replace);
    }
    return 0;
  }

  // Read all people
  static Future<List<PersonModel>> getPeople() async {
    List<PersonModel>? people = [];
    final db = await SQLHelper.db();
    List<Map<String, dynamic>> peopleDB = await db.query('people');
    for(var personModel in peopleDB){
      people.add(PersonModel.fromJsonSQLDB(personModel));
    }
    return people;
  }

  // Read a single item by id
  // The app doesn't use this method but I put here in case you want to see it
  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelper.db();
    return db.query('people', where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Update an item by id
  static Future<int> updateItem(
      int id, String title, String? descrption) async {
    final db = await SQLHelper.db();

    final data = {
      'title': title,
      'description': descrption,
      'createdAt': DateTime.now().toString()
    };

    final result =
    await db.update('people', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Delete
  static Future<void> deleteItem(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("people", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }  // Delete All people

  static Future<void> deleteAll() async {
    final db = await SQLHelper.db();
    try {
      await db.delete("people");
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}