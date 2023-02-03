import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:path/path.dart';
import 'package:data/models/jokes/dt_joke.dart';
import 'package:sqflite/sqflite.dart';


const String _dbName = "rickmorty.db";

@singleton
class PraxisDatabase {
  Database? _database;

  PraxisDatabase();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB(_dbName);
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = "TEXT PRIMARY KEY";
    const jokeType = "TEXT NOT NULL";
    await db.execute("""
      CREATE TABLE $jokesTable (
      ${JokeFields.id} $idType,
      ${JokeFields.value} $jokeType
      )
      """);
  }

  Future<bool> insertJoke(DTJoke joke) async {
    final db = await database;
    return await db.insert(jokesTable, joke.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace) >
        0;
  }

  Future<bool> deleteAllJokes() async {
    final db = await database;
    return await db.delete(jokesTable) > 0;
  }

  Future<List<DTJoke>> getAllJokes() async {
    final db = await database;
    final jokeMapList = await db.query(jokesTable);
    final List<DTJoke> jokeList =
        jokeMapList.map((jokeMap) => DTJoke.dtJokeFromJson(jokeMap)).toList();
    return jokeList;
  }

  Future close() async {
    final db = await database;
    db.close();
  }
}
