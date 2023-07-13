// ignore_for_file: constant_identifier_names

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/models/user_model.dart';

class UserDatabase {
  static Database? _database;
  static const String TABLE_NAME = 'user';
  static const String COLUMN_ID = 'id';
  static const String COLUMN_USERNAME = 'username';
  static const String COLUMN_PASSWORD = 'password';

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDb();
    return _database;
  }

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'user5.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $TABLE_NAME (
            $COLUMN_ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            $COLUMN_USERNAME TEXT,
            $COLUMN_PASSWORD TEXT
          )
        ''');
      },
    );
  }

  Future<void> createUser(UserModel user) async {
    Database? db = await database;
    await db?.insert(TABLE_NAME, user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<UserModel?> getUserByUserName(String? userName) async {
    Database? db = await database;
    List<Map<String, Object?>> result = await db!.query(TABLE_NAME,
        where: '$COLUMN_USERNAME = ?', whereArgs: [userName], limit: 1);

    return result.isNotEmpty ? UserModel.fromMap(result.first) : null;
  }

  Future<void> updateUserStatus(UserModel user) async {
    Database? db = await database;
    await db?.update(
      TABLE_NAME,
      user.toMap(),
      where: '$COLUMN_ID = ?',
      whereArgs: [user.id],
    );
  }

  Future<void> deleteUserById(int userId) async {
    Database? db = await database;
    try {
      await db?.delete(
        TABLE_NAME,
        where: '$COLUMN_ID = ?',
        whereArgs: [userId],
      );
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
