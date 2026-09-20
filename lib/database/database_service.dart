import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static Database? _database;

  // ==========================================================
  // GET DATABASE INSTANCE
  // ==========================================================

  static Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  // ==========================================================
  // INITIALIZE DATABASE
  // ==========================================================

  static Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();

    final path = join(
      databasePath,
      'digital_wellbeing.db',
    );

    return await openDatabase(
      path,

      // Database version increased from 1 to 2
      version: 2,

      // ======================================================
      // CREATE DATABASE
      // ======================================================

      onCreate: (db, version) async {
        // ----------------------------------------------------
        // DAILY USAGE SUMMARY
        // ----------------------------------------------------

        await db.execute('''
          CREATE TABLE daily_usage (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            date TEXT NOT NULL UNIQUE,
            total_usage INTEGER NOT NULL,
            app_switches INTEGER NOT NULL,
            session_count INTEGER NOT NULL,
            most_used_app TEXT,
            most_reopened_app TEXT
          )
        ''');

        // ----------------------------------------------------
        // INDIVIDUAL APP USAGE
        // ----------------------------------------------------

        await db.execute('''
          CREATE TABLE app_usage (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            date TEXT NOT NULL,
            package_name TEXT NOT NULL,
            usage_time INTEGER NOT NULL,
            session_count INTEGER NOT NULL,
            UNIQUE(date, package_name)
          )
        ''');
      },

      // ======================================================
      // DATABASE UPGRADE
      // ======================================================

      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          // Remove the old app_usage table.
          //
          // This is safe during development because we are
          // changing the database structure before final release.
          await db.execute(
            'DROP TABLE IF EXISTS app_usage',
          );

          // Create the new app_usage table with
          // UNIQUE(date, package_name).
          await db.execute('''
            CREATE TABLE app_usage (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              date TEXT NOT NULL,
              package_name TEXT NOT NULL,
              usage_time INTEGER NOT NULL,
              session_count INTEGER NOT NULL,
              UNIQUE(date, package_name)
            )
          ''');
        }
      },
    );
  }

  // ==========================================================
  // SAVE DAILY USAGE SUMMARY
  // ==========================================================

  static Future<void> saveDailyUsage({
    required String date,
    required int totalUsage,
    required int appSwitches,
    required int sessionCount,
    String? mostUsedApp,
    String? mostReopenedApp,
  }) async {
    final db = await database;

    await db.insert(
      'daily_usage',
      {
        'date': date,
        'total_usage': totalUsage,
        'app_switches': appSwitches,
        'session_count': sessionCount,
        'most_used_app': mostUsedApp,
        'most_reopened_app': mostReopenedApp,
      },

      // If today's date already exists,
      // replace the old summary with the latest one.
      conflictAlgorithm:
          ConflictAlgorithm.replace,
    );
  }

  // ==========================================================
  // SAVE INDIVIDUAL APP USAGE
  // ==========================================================

  static Future<void> saveAppUsage({
    required String date,
    required String packageName,
    required int usageTime,
    required int sessionCount,
  }) async {
    final db = await database;

    await db.insert(
      'app_usage',
      {
        'date': date,
        'package_name': packageName,
        'usage_time': usageTime,
        'session_count': sessionCount,
      },

      // If the same app has already been saved
      // for the same date, replace the old record.
      conflictAlgorithm:
          ConflictAlgorithm.replace,
    );
  }

  // ==========================================================
  // GET DAILY USAGE HISTORY
  // ==========================================================

  static Future<List<Map<String, dynamic>>>
      getDailyUsageHistory() async {
    final db = await database;

    return await db.query(
      'daily_usage',
      orderBy: 'date DESC',
    );
  }

  // ==========================================================
  // GET APP USAGE HISTORY
  // ==========================================================

  static Future<List<Map<String, dynamic>>>
      getAppUsageHistory() async {
    final db = await database;

    return await db.query(
      'app_usage',
      orderBy: 'date DESC, usage_time DESC',
    );
  }

  // ==========================================================
  // GET USAGE FOR A PARTICULAR DATE
  // ==========================================================

  static Future<List<Map<String, dynamic>>>
      getUsageForDate(String date) async {
    final db = await database;

    return await db.query(
      'app_usage',
      where: 'date = ?',
      whereArgs: [date],
      orderBy: 'usage_time DESC',
    );
  }

  // ==========================================================
  // VERIFY TODAY'S SAVED DAILY USAGE
  // ==========================================================

  static Future<Map<String, dynamic>?>
      getTodayDailyUsage(
    String date,
  ) async {
    final db = await database;

    final result = await db.query(
      'daily_usage',
      where: 'date = ?',
      whereArgs: [date],
      limit: 1,
    );

    if (result.isEmpty) {
      return null;
    }

    return result.first;
  }
}