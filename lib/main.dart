import 'package:flutter/material.dart';
import 'package:flutter_todoapp/pages/addTask.dart';
import 'package:flutter_todoapp/pages/home.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Home(),
      '/add': (context) => AddTask(),
    },
  ));
}
