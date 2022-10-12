import 'package:sqlite/models/contact.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DbHelper{
  static DbHelper _dbHelper;
  static Database _database;

  DbHelper._createPbject();

  factory DbHelper() =>
    _dbHelper ??= DbHelper._createPbject();
  

  static Future<Database> initDb() async{
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}/contact.db';
    var contactDatabase = openDatabase(path, version: 1, onCreate: _createDb);
    return contactDatabase;
  
  }

  static void _createDb(Database db, int version) async{
    await db.execute('''
  CREATE TABLE contact(
      id INTEGER, 
      name TEXT, 
      phone TEXT 
        )
  ''');
  }

  // static Future<Database> get database async =>
  //   _database ??= await initDb();
  
  static Future<Database> get database async =>
    _database ??= await initDb();
    

  //create (C)
  static Future<int> insert(Contact object) async{
    Database db = await database;
    int count = await db.insert('contact', object.toMap());
    return count;
  }

    //read (R)
  static Future<List<Map<String, dynamic>>> select() async{
    Database db = await database;
    var mapList = await db.query('contact', orderBy: 'name');
    return mapList;
  }

    //update (U)
  static Future<int> update(Contact object) async{
    Database db = await database;
    int count = await db.update('contact', object.toMap(),
    where: 'id=?', whereArgs: [object.id]);
    return count;
  }

    //delete (D)
  static Future<int> delete(int id) async{
    Database db = await database;
    int count = await db.delete('contact', where: 'id=?', whereArgs: [id]);
    return count;
  }

  static Future<List<Contact>> getContactList() async {
    var contactMapList = await select();
    int count = contactMapList.length;

    List<Contact> contactList = [];
    for (int i = 0; i < count; i++){
      contactList.add(Contact.fromMap(contactMapList[i]));
    }
    return contactList;
  }


}