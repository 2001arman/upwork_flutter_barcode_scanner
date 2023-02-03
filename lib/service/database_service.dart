import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static const _databaseName = "book_database.db";
  static const _databaseVersion = 1;

  static const table = "saved_books_table";

  static const columnEan = 'ean';
  static const columnName = 'name';
  static const columnImageUrl = 'image_url';

  DatabaseService._privateConstructor();
  static final DatabaseService instance = DatabaseService._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnEan TEXT PRIMARY KEY,
        $columnName TEXT NOT NULL,
        $columnImageUrl TEXT
      )
    ''');
  }

  Future<List<Map<String, dynamic>>> getBooks() async {
    Database db = await instance.database;
    return await db.query(table, orderBy: "name ASC");
  }

  Future<bool> isSaved(String ean) async {
    Database db = await instance.database;
    var check = await db.query(table,
        where: "$columnEan = ?", whereArgs: [ean], limit: 1);
    return (check.isNotEmpty) ? true : false;
  }

  Future<int> insert(
      {required String ean, required String name, String? imageUrl}) async {
    Database db = await instance.database;

    // check if exist
    var isExist = await db.query(table,
        columns: [columnEan], where: "$columnEan = ?", whereArgs: [ean]);

    if (isExist.isNotEmpty) {
      return 1;
    }

    return await db.insert(table, {
      columnEan: ean,
      columnName: name,
      columnImageUrl: imageUrl,
    });
  }

  Future<int> delete(String ean) async {
    Database db = await instance.database;
    return await db.delete(table, where: "$columnEan = ?", whereArgs: [ean]);
  }
}
