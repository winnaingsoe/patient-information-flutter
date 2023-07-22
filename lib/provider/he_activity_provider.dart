import 'package:flutter/material.dart';
import '../databases/db.dart';
import 'package:sqflite/sqflite.dart';

import '../models/he_activity.dart';

class HEActivityProvider extends ChangeNotifier {
  late Database db;

  List<HEActivity> heactivitylist = [];

  getHEActivity() async {
    heactivitylist.clear();
    db = await UnionDB.db.database;
    final List<Map<String, Object?>> queryResult = await db.query(
      'he_activity',
    );
    heactivitylist = queryResult.map((e) => HEActivity.fromMap(e)).toList();

    return heactivitylist;
  }

  insertHEActivity(HEActivity heActivity) async {
    db = await UnionDB.db.database;
    heactivitylist.add(heActivity);
    await db.insert(
      'he_activity',
      heActivity.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    notifyListeners();
    return heactivitylist;
  }
}
