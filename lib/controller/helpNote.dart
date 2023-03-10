// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path/path.dart';

import '../model/dbModel.dart';

class HelpNote {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDB();
      return _db;
    } else {
      return _db;
    }
  }

  initialDB() async {
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "todoDB.db");
    var mydb = await openDatabase(path, version: 26, onCreate: _onCreate);
    return mydb;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE todo(id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE, description TEXT NOT NULL, title TEXT NOT NULL, date TEXT NOT NULL, done TEXT NOT NULL )");
  }

  Future<int> insertDB(Map<String, dynamic> data) async {
    Database? db_client = await db;
    var result = db_client!.insert("todo", data);
    return result;
  }

  delete_By_Id(int id) async {
    Database? db_client = await db;
    var result = db_client!.rawUpdate('DELETE FROM todo WHERE id ="$id"');
    return result;
  }

  update_By_Id(int id, String description) async {
    Database? db_client = await db;
    var result = db_client!.rawUpdate(
        'UPDATE todo SET description="$description" WHERE id = "$id"');
    return result;
  }

  getSingleRow(int id) async {
    Database? db_client = await db;
    var result = db_client!.query("todo", where: 'id"$id"');
    return result;
  }

  Future<List<DBModel>> getDB() async {
    List<DBModel> list = [];
    Database? db_client = await db;
    var result = await db_client!.query("todo");
    for (var i in result) {
      list.add(DBModel(
          description: i["description"],
          title: i["title"],
          date: i["date"],
          id: i["id"],
          done: i["done"]));
    }
    return list;
  }
}
