import 'package:flutter/material.dart';
import '../databases/db.dart';
import 'package:sqflite/sqflite.dart';

import '../models/patient.dart';

class PatientProvider extends ChangeNotifier {
  late Database db;

  List<Patient> patientlist = [];

  getPatient() async {
    patientlist.clear();
    db = await UnionDB.db.database;
    final List<Map<String, Object?>> queryResult = await db.query(
      'patient',
    );
    patientlist = queryResult.map((e) => Patient.fromMap(e)).toList();

    return patientlist;
  }

  insertPatient(Patient patient) async {
    db = await UnionDB.db.database;
    patientlist.add(patient);
    var result = await db.insert(
      'patient',
      patient.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    debugPrint('Patient $result');
    notifyListeners();
    return patientlist;
  }
}
