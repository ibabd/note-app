import 'package:note/model/data_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper{
  Future<Database> initDb()async{
    String path=await getDatabasesPath();
    return openDatabase(
       join (path,'sqfLite.db'),
      version: 1,
      onCreate: (database,version)async{
         await database.execute(
           '''
           CREATE TABLE MYTable(
           id INTEGER PRIMARY KEY AUTOINCREMENT,
           title TEXT NOT NULL,
           subTitle TEXT NOT NULL
           )
           '''
         );
      }
    );
  }
  Future<bool> insertData(DataModel dataModel)async{
    final Database db=await initDb();
    db.insert('MYTable', dataModel.toMap());
    return true;
  }
  Future<List<DataModel>> getData()async{
    final Database db=await initDb();
    final List<Map<String,Object ?>>data=await db.query('MYTable');
   return data.map((e) => DataModel.fromJson(e)).toList();
  }
  Future<void> update(DataModel dataModel,int id)async{
    final Database db=await initDb();
    await db.update('MYTable', dataModel.toMap(),where: "id =?",whereArgs: [id]);
  }
  Future<void> delete(int id)async{
    final Database db=await initDb();
    await db.delete('MYTable',where: "id =?",whereArgs: [id]);
  }
}