import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/food_item.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  static Future<void> initialize() async {
    _database = await _initDatabase();
  }

  static Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'food_ordering.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE food_items (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            cost REAL NOT NULL
          )
        ''');
      },
    );
  }

  Future<List<FoodItem>> getFoodItems() async {
    final db = _database!;
    final List<Map<String, dynamic>> foodMaps = await db.query('food_items');
    return foodMaps.map((item) => FoodItem.fromMap(item)).toList();
  }

  Future<void> insertFoodItem(FoodItem foodItem) async {
    final db = _database!;
    await db.insert('food_items', foodItem.toMap());
  }

  Future<void> deleteFoodItem(int id) async {
    final db = _database!;
    await db.delete('food_items', where: 'id = ?', whereArgs: [id]);
  }
}
