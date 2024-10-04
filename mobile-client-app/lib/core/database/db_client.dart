import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbClient {
  static const _databaseName = "desiroo_app.db";
  static const _databaseVersion = 1;

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;

    // Lazily instantiate the database if unavailable
    _database = await _initDatabase();
    return _database!;
  }

  // Open the database, creating if it doesn't exist
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path + _databaseName;
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
           CREATE TABLE Wishlists (
             Id TEXT PRIMARY KEY,
             Name TEXT NOT NULL
           )
          ''');
    await db.execute('''
           CREATE TABLE Products (
            ProductId      TEXT PRIMARY KEY,
            WishlistId     TEXT NOT NULL,
            Name           TEXT NOT NULL,
            Link           TEXT NOT NULL,
            PriceCategory  TEXT NOT NULL,
            GiftImportance TEXT NOT NULL,
            PhotoPath TEXT NOT NULL,
            FOREIGN KEY(WishlistId) REFERENCES Wishlists(Id)
           )
          ''');
  }
}
