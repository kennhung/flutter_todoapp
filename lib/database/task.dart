import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final String columnId = '_id';
final String columnName = 'name';
final String columnDueDate = 'dueDate';
final String columnFinished = 'finished';

class Task {
  int id;
  String name;
  DateTime dueDate;
  bool finished = false;

  Task({this.name, this.dueDate});

  Task.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    name = map[columnName];
    dueDate = map[columnDueDate];
    finished = (map[columnFinished] == 1);
  }

  // convenience method to create a Map from this Word object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnName: name,
      columnDueDate: dueDate,
      columnFinished: finished ? 1 : 0
    };

    if (id != null) {
      map[columnId] = id;
    }

    return map;
  }
}

class TaskDB {
  static Database database;

  static Future<Database> initDatabase() async {
    database = await openDatabase(
      join(await getDatabasesPath(), 'todo.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE tasks("
          "$columnId TEXT PRIMARY KEY, "
          "$columnName TEXT, "
          "$columnDueDate DATETIME, "
          "$columnFinished INTEGER"
          ")",
        );
      },
      version: 1,
    );
    return database;
  }

  static Future<Database> getDBConnect() async {
    if (database != null) {
      return database;
    }
    return await initDatabase();
  }

  static Future<List<Task>> getTasks() async {
    final Database db = await getDBConnect();
    final List<Map<String, dynamic>> maps = await db.query('tasks');
    return List.generate(maps.length, (i) {
      return Task.fromMap(maps[i]);
    });
  }

  static Future<void> addTodo(Task task) async {
    final Database db = await getDBConnect();
    await db.insert(
      'tasks',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> updateTodo(Task task) async {
    final Database db = await getDBConnect();
    await db.update(
      'tasks',
      task.toMap(),
      where: "id = ?",
      whereArgs: [task.id],
    );
  }

  static Future<void> deleteTodo(String id) async {
    final Database db = await getDBConnect();
    await db.delete(
      'tasks',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}

class TaskListTitle extends StatelessWidget {
  final Task task;
  final Function onToggleFinish;

  TaskListTitle({this.task, this.onToggleFinish});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(
          '${task.name}',
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20.0),
        ),
        subtitle: task.dueDate != null
            ? Text(
                '${DateFormat('yyyy-MM-dd kk:mm').format(task.dueDate.toLocal())}')
            : null,
        leading: IconButton(
          icon: Icon(
            task.finished
                ? Icons.check_circle_outline
                : Icons.radio_button_unchecked_outlined,
            color: Colors.black,
          ),
          onPressed: onToggleFinish,
        ));
  }
}
