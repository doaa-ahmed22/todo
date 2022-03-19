import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqfLiteApp {
  Database? database;
  static Database? _checkDatabase;
  Future<Database?> get checkDatabase async {
    if (_checkDatabase == null) {
      _checkDatabase = await createDatabase();
      return _checkDatabase;
    } else {
      return _checkDatabase;
    }
  }

  Future<Database> createDatabase() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');
    database = await openDatabase(path,
        version: 1, onCreate: _onCreateFunction, onUpgrade: _onUpgradeFunction);
    return database!;
  }

  _onUpgradeFunction(Database database, int oldVersion, int newVersion) {
    print("upGrade =============");
  }

  _onCreateFunction(Database database, int version) async {
    await database.execute(
        //id integer
        //string title
        //string date
        //string time
        //string state
        '''CREATE TABLE tasks (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, 
        title TEXT,
        date TEXT ,
        time TEXT,
        state TEXT)''');
    print('database created');
  }

  getDatabase() async {
    database = await checkDatabase;
    Future<List<Map<String, Object?>>> response =
        database!.rawQuery('SELECT * FROM tasks');
    return response;
  }

  insertData(String sql) async {
    database = await checkDatabase;
    Future<int> response = database!.rawInsert(sql);
    return response;
  }

  updateData(String sql) async {
    database = await checkDatabase;
    Future<int> response = database!.rawUpdate(sql);
    return response;
  }

  deleteData(String sql) async {
    database = await checkDatabase;
    Future<int> response = database!.rawDelete(sql);
    return response;
  }
}
