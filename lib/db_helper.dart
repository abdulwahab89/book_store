import 'package:book_store/book_list.dart';
import 'package:book_store/book_provider.dart';
import 'package:book_store/dart_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path/path.dart';

class DBHelper {
  static Database? _db;
  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'book.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE book(id INTEGER PRIMARY KEY, productId VARCHAR UNIQUE,productName TEXT,quantity INTEGER,image TEXT,productAuthor TEXT,initialPrice INTEGER,productPrice INTEGER )');
  }

  Future<BookModel> insert(BookModel book) async {
    var dbClient = await db;
    await dbClient?.insert('book', book.toMap());
    return book;
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return dbClient!.delete(
      'book',
      where: 'id=?',
      whereArgs: [id],
    );
  }

  Future<int> update(BookModel cart) async {
    var dbClient = await db;
    return dbClient!.update(
      'book',
      cart.toMap(),
      where: 'id=?',
      whereArgs: [cart.id],
    );
  }

  Future<List<BookModel>> getCartList() async {
    var dbClient = await db;
    final List<Map<String, Object?>> queryResult =
        await dbClient!.query('book');
    return queryResult.map((e) => BookModel.fromMap(e)).toList();
  }
}
