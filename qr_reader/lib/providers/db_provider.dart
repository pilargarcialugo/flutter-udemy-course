import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    _database ??= await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'ScanDB.db');
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE Scan(
            id INTEGER PRIMARY KEY,
            type TEXT,
            value TEXT
          );
        ''');
      }
    );
  }

  Future<int> createScan(ScanModel scanModel) async {
    final db = await database;
    return await db.insert('Scan', scanModel.toJson());
  }

  Future<ScanModel?> findScanById(int scanId) async {
    final db = await database;
    final res = await db.query('Scan', where: 'id = ?', whereArgs: [scanId]);
    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  Future<List<ScanModel>> findAllScans() async {
    final db = await database;
    final res = await db.query('Scan');
    return res.isNotEmpty ? res.map((e) => ScanModel.fromJson(e)).toList() : [];
  }

  Future<List<ScanModel>> findScansByType(String type) async {
    final db = await database;
    final res = await db.query('Scan', where: 'type = ?', whereArgs: [type]);
    return res.isNotEmpty ? res.map((e) => ScanModel.fromJson(e)).toList() : [];
  }

  Future<int> updateScan(ScanModel scanModel) async {
    final db = await database;
    final res = await db.update('Scan', scanModel.toJson(), where: 'id = ?', whereArgs: [scanModel.id]);
    return res;
  }

  Future<int> deleteScan(int scanId) async {
    final db = await database;
    final res = await db.delete('Scan', where: 'id = ?', whereArgs: [scanId]);
    return res;
  }

  Future<int> deleteAllScans() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Scan');
    return res;
  }
}
