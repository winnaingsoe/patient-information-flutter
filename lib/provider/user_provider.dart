import 'package:flutter/material.dart';
import '../databases/db.dart';
import 'package:sqflite/sqflite.dart';

import '../models/user.dart';

class UserProvider extends ChangeNotifier {
  late Database db;

  UserProvider() {
    _initDB();
  }

  Future _initDB() async {
    db = await UnionDB.db.database;
  }

  List<User> userlist = [];
  bool isSuccess = false;

  Future<bool> login(User user) async {
    userlist.clear();
    //db = await UnionDB.db.database;
    final List<Map<String, Object?>> queryResult = await db.query(
      'user',
      where: "name = ? and password = ?",
      whereArgs: [user.name, user.password],
    );
    userlist = queryResult.map((e) => User.fromMap(e)).toList();
    isSuccess = userlist.isNotEmpty ? true : false;

    return isSuccess;
  }
}
