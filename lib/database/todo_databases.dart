// ignore_for_file: constant_identifier_names

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/models/todo_models.dart';
import 'package:todo_app/models/user_model.dart';

class TodoDatabase {
  static Database? _database;
  static const String TABLE_NAME = 'todos';
  static const String COLUMN_ID = 'id';
  static const String COLUMN_USER_ID = 'userId';
  static const String COLUMN_CONTENT = 'content';
  static const String COLUMN_TITLE = 'title';

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDb();
    return _database;
  }

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'todo5.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $TABLE_NAME (
            $COLUMN_ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            $COLUMN_USER_ID INTEGER,
            $COLUMN_TITLE TEXT,
            $COLUMN_CONTENT TEXT
          )
        ''');
      },
    );
  }

  Future<void> createTodos(TodoModel todo) async {
    final db = await database;
    await db?.insert(TABLE_NAME, todo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<TodoModel>> getTodosByUser(UserModel user) async {
    final db = await database;
    final result = await db
        ?.query(TABLE_NAME, where: '$COLUMN_USER_ID = ?', whereArgs: [user.id]);

    return result!.map((e) => TodoModel.fromMap(e)).toList();
  }

  Future<void> updateTodoStatus(TodoModel todo) async {
    final db = await database;
    await db?.update(
      TABLE_NAME,
      todo.toMap(),
      where: '$COLUMN_ID = ?',
      whereArgs: [todo.id],
    );
  }

  Future<void> deleteTodo(TodoModel todo) async {
    final db = await database;
    try {
      await db?.delete(
        TABLE_NAME,
        where: '$COLUMN_ID = ?',
        whereArgs: [todo.id],
      );
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
