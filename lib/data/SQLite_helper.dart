import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLiteHelper {
  static Database? _database;
  static const String tableName = 'userCases';

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final path = join(await getDatabasesPath(), 'my_database.db');

    return openDatabase(
      path,
      version: 3,
      onUpgrade: onUpgrade,
      onCreate: (db, version) {
        return db.execute('''
        CREATE TABLE $tableName (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          date TEXT,
          name TEXT,
          image TEXT,
          time TEXT
        )
        ''');
      },
    );
  }

  Future<void> onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      if (oldVersion < 2) {
        await db.execute('''
        ALTER TABLE $tableName
        ADD COLUMN date TEXT;
        ADD COLUMN name TEXT;
        ADD COLUMN image TEXT;
        Add COLUMN time TEXT;
      ''');
      }
    }
  }

  Future<void> insertData(
      String date, String caseName, String imagePath, String time) async {
    final db = await database;

    await db.insert(tableName,
        {'date': date, 'name': caseName, 'image': imagePath, 'time': time});
  }

  Future<List<String>> getData() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);

    return List.generate(maps.length, (index) {
      return maps[index]['name']['date']['image']['time'] as String;
    });
  }

  Future<List<Map<String, dynamic>>> getAllData() async {
    Database database = await openDatabase(
      join(await getDatabasesPath(), 'my_database.db'),
    );
    List<Map<String, dynamic>> queryResult = await database.query(tableName);
    await database.close();

    return queryResult;
  }

  Future<void> clearDatabase() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'my_database.db');

    await deleteDatabase(path);
    print('Database cleared');
  }
}
