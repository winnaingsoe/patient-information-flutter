import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class UnionDB with ChangeNotifier {
  static Database? _database;
  static final UnionDB db = UnionDB._();
  UnionDB._();

  Future<Database> get database async {
    // If database exists, return database
    // If database don't exists, create one
    _database = await _initDB();
    return _database!;
  }

  _initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = p.join(documentsDirectory.path, 'union.db');
    var db = await openDatabase(
      path,
      version: 1,
      onCreate: _createTable,
      onUpgrade: _updateTable,
    );
    return db;
  }

  Future _updateTable(Database db, int oldVersion, int newVersion) async {
    /// alter table or field in update db version
  }

  Future _createTable(Database db, int version) async {
    await db.execute('CREATE TABLE IF NOT EXISTS user('
        'id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'
        'name TEXT NOT NULL,'
        'password TEXT NOT NULL'
        ')');

    await db.execute('CREATE TABLE IF NOT EXISTS patient('
        'id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'
        'name TEXT NOT NULL,'
        'sex TEXT NOT NULL,'
        'age INT NOT NULL,'
        'referdate TEXT NOT NULL,'
        'township TEXT NOT NULL,'
        'address TEXT NOT NULL,'
        'referfrom TEXT NOT NULL,'
        'referto TEXT NOT NULL,'
        'signandsymptom TEXT NOT NULL'
        ')');

    await db.execute('CREATE TABLE IF NOT EXISTS he_activity('
        'id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'
        'date TEXT NOT NULL,'
        'address TEXT NOT NULL,'
        'volunteer TEXT NOT NULL,'
        'heattendedslist TEXT NOT NULL,'
        'male INT NOT NULL,'
        'female INT NOT NULL'
        ')');

    await db.rawInsert(
        'INSERT INTO user(name, password) VALUES("user", "12345678")');
  }
}
