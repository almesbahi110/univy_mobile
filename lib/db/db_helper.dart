import 'package:univy_mobile/models/task.dart';
import 'package:sqflite/sqflite.dart';
class DBHelper {

  static Database? _db;
  static final int _verson = 1;
  static final String _tableName = "task";
  static Future<void> iniDB() async
  {
    if (_db != null) {
      return;
    }
    try {
      String _path = await getDatabasesPath() + 'task.db';
      _db = await openDatabase(_path, version: _verson,
        onCreate: (db, verson) {
          print("create a new one 11111111111");
          return db.execute(
            "CREATE TABLE $_tableName("
                "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                "title STRING, note TEXT, date STRING, "
                "startTime STRING , endTime STRING, "
                "remind INTEGER, repeat STRING, "
                "color INTEGER, "
                "isCompleted INTEGER)",
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }
  static Future<int> intset(Task? task)async
  {
print("insert function calleed");
return await _db?.insert(x, task!.toJson())??1 ;
  }
  static Future<List<Map<String,dynamic>>> query()async
  {
    print("query function calleed");
    return await _db!.query(_tableName);
  }

static delete(Task task)async
{
return await _db!.delete(_tableName,where: 'id=?',whereArgs: [task.id]);
}

static update(int id)async{
  return await  _db!.rawUpdate('''
    UPDATE task
    SET isCompleted = ?
    WHERE id =?
    ''',[1,id]);
}




}