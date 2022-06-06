import 'package:path/path.dart';
import 'package:reto_login_sqlite/Models/user.dart';
import 'package:sqflite/sqflite.dart';

class db {
  static final db instance = db._init();

  static Database _db;

  db._init();

  Future<Database> get database async {
    if (_db != null) return _db;

    _db = await _initDB('users.db');
    return _db;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';

    await db.execute('''
  CREATE TABLE users ( 
  ${Users.id} $idType, 
  ${Users.gmail} $textType, 
  ${Users.userName} $textType,
  ${Users.password} $textType
  )
''');
  }

  Future<User> create(User user) async {
    final db = await instance.database;
    final id = await db.insert("users", user.toJson());
    return user.copy(id: id);
  }

  Future<User> read(User user) async {
    final db = await instance.database;

    final maps = await db.query(
      "users",
      columns: Users.values,
      where: '${Users.userName} = ?',
      whereArgs: [user.userName],
    );

    if (maps.isNotEmpty) {
      return User.fromJson(maps.first);
    } else {
      return null;
      throw Exception('ID $user.userName not found');
    }
  }

  Future<List<User>> readAll() async {
    final db = await instance.database;

    final result = await db.query("users");

    return result.map((json) => User.fromJson(json)).toList();
  }

  Future<int> update(User user) async {
    final db = await instance.database;

    return db.update(
      "users",
      user.toJson(),
      where: '${user.userName} = ?',
      whereArgs: [user.userName],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      "users",
      where: '${Users.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
