import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

/// Opens the app SQLite file and runs schema migration on first launch.
class AppDatabase {
  AppDatabase(this._db);

  final Database _db;

  Database get database => _db;

  static const _fileName = 'streakly.sqlite3';
  static const _version = 1;

  static Future<AppDatabase> open() async {
    final dir = await getApplicationDocumentsDirectory();
    final path = p.join(dir.path, _fileName);
    final db = await openDatabase(
      path,
      version: _version,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE habits (
            id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            icon_key TEXT NOT NULL,
            created_at TEXT NOT NULL,
            sort_order INTEGER NOT NULL DEFAULT 0,
            reminder_enabled INTEGER NOT NULL DEFAULT 0,
            reminder_time_minutes INTEGER,
            archived INTEGER NOT NULL DEFAULT 0
          )
        ''');
        await db.execute('''
          CREATE TABLE habit_day_status (
            id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
            habit_id INTEGER NOT NULL,
            day_key TEXT NOT NULL,
            status INTEGER NOT NULL,
            updated_at TEXT NOT NULL,
            habit_id_day_key TEXT NOT NULL UNIQUE,
            FOREIGN KEY (habit_id) REFERENCES habits (id) ON DELETE CASCADE
          )
        ''');
        await db.execute(
          'CREATE INDEX idx_habit_day_status_day ON habit_day_status (day_key)',
        );
        await db.execute(
          'CREATE INDEX idx_habit_day_status_habit ON habit_day_status (habit_id)',
        );
        await db.execute('''
          CREATE TABLE insurance_ledger (
            id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
            month_key TEXT NOT NULL UNIQUE,
            tokens_used INTEGER NOT NULL DEFAULT 0,
            updated_at TEXT NOT NULL
          )
        ''');
      },
    );
    return AppDatabase(db);
  }
}
