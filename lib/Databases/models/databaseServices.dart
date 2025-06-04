import 'dart:ffi';
import 'dart:io';

import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class Databaseservices {
  // creating a database contractor
  Databaseservices._privateConstractor();

  static final Databaseservices instance =
      Databaseservices._privateConstractor();

// intializing the database
  final _dbname = 'NMT';
  // table details
  static final _tableName = 'Payment';
  static final _columnID = 'ID';
  static final _Tokens = 'Tokens';
  static final _TransactionID = 'TransactionID';
  static final _PaidAmount = 'Amount';
  static final _Liters = 'Liters';
  static final _Time = 'Time';

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _intializeDb();

    return _database!;
  }

  _intializeDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, _dbname);

    return await openDatabase(
      path,
      version: 1,
      onCreate: createTable,
    );
  }

  final sql = '''

    CREATE TABLE $_tableName(
    $_columnID INTEGER PRIMARY KEY NOT NULL,
    $_Tokens TEXT NOT NULL,
    $_TransactionID TEXT NOT NULL,
    $_PaidAmount TEXT NOT NULL,
    $_Liters TEXT NOT NULL,
    $_Time TEXT NOT NULL 
    
    )

''';
  createTable(Database db, int version) {
    db.execute(sql);
    print("Payments table created");
  }

  insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    db.insert(_tableName, row);
  }

// Future<List<Map<String, dynamic>>>
  fetch() async {
    Database db = await instance.database;

    return db.query(_tableName);
  }

  DeleteALL() async {
    Database db = await instance.database;

    db.delete(_tableName);
  }
}
