// ignore_for_file: constant_identifier_names

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/models/todo_models.dart';

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
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'todo5.db');

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

  Future<void> createTodo(TodoModel todo) async {
    Database? db = await database;
    await db?.insert(TABLE_NAME, todo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<TodoModel>> getTodosByUserId(int? userId) async {
    Database? db = await database;
    List<Map<String, Object?>>? result = await db
        ?.query(TABLE_NAME, where: '$COLUMN_USER_ID = ?', whereArgs: [userId]);
    return result!.map((e) => TodoModel.fromMap(e)).toList();
  }

  Future<void> updateTodoStatus(TodoModel todo) async {
    Database? db = await database;
    await db?.update(
      TABLE_NAME,
      todo.toMap(),
      where: '$COLUMN_ID = ?',
      whereArgs: [todo.id],
    );
  }

  Future<void> deleteTodoById(int? todoId) async {
    Database? db = await database;
    try {
      await db?.delete(
        TABLE_NAME,
        where: '$COLUMN_ID = ?',
        whereArgs: [todoId],
      );
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
