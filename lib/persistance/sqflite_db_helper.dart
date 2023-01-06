import 'dart:async';

import 'package:sqflite/sqflite.dart';

const List<String> _migrations = [
  '''
  CREATE TABLE timers (id INTEGER PRIMARY KEY, work INTEGER NOT NULL, rest INTEGER, rounds INTEGER)
  ''',
  '''
  CREATE TABLE last_selected_timer (id INTEGER PRIMARY KEY, work INTEGER NOT NULL, rest INTEGER, rounds INTEGER)
  ''',
  '''
  INSERT INTO last_selected_timer(id, seconds) VALUES(1, 60)
  '''
];
const List<String> _downgrades = [
  '''
  DROP TABLE IF EXISTS timers
  ''',
  '''
  DROP TABLE IF EXISTS last_selected_timer
  ''',
  '''
  DELETE FROM last_selected_timer WHERE id = 1 
  '''
];

Future<Database> dbInitialization() async {
  return await openDatabase("solid_timer.db", version: _migrations.length, onCreate: _onCreate, onUpgrade: _onUpdate, onDowngrade: _onDowngrade);
}

Future<void> _onCreate(Database db, int version) async {
  for (int i = 0;i < version; i++) {
    db.execute(_migrations[i]);
  }
}

Future<void> _onUpdate(Database db, int oldVersion, int newVersion) async {
  for (int i = oldVersion;i < newVersion; i++) {
    db.execute(_migrations[i]);
  }
}

Future<void> _onDowngrade(Database db, int oldVersion, int newVersion) async {
  for (int i = --oldVersion;i >= newVersion; i--) {
    db.execute(_downgrades[i]);
  }
}