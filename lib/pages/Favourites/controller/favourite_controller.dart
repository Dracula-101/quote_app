import 'dart:developer';

import 'package:get/get.dart';
import 'package:quote_app/pages/constant/constant.dart';
import 'package:sqflite/sqflite.dart';

class FavouriteController extends GetxController {
  RxList favourites = [].obs;
  Database? database;
  String tableName = 'favourites';

  @override
  void onInit() {
    readFromDatabase();
    super.onInit();
  }

  Future<bool> databaseExists() async =>
      await databaseFactory.databaseExists(databasePath);

  Future<void> readFromDatabase() async {
    checkForDatabase().then((value) => copyIntoObject());
  }

  Future<void> checkForDatabase() async {
    if (!await databaseExists() || database == null) {
      createDatabase();
    } else {
      database = await openDatabase(
        databasePath,
        version: 1,
      );
    }
  }

  Future<void> createDatabase() async {
    database = await openDatabase(databasePath, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE $tableName (id INTEGER PRIMARY KEY, authorId TEXT ,authorName TEXT, content TEXT,tags TEXT);');
    });
    print("created DB");
  }

  Future<void> copyIntoObject() async {
    List<Map<String, dynamic>> records = await database!.query(tableName);
    favourites.clear();
    for (int i = 0; i < records.length; i++) {
      favourites.add(records.elementAt(i));
    }
    log(favourites.toString());
    update();
  }

  Future<void> addtoDatabase(String authorId, String authorName, String content,
      List<String> tags) async {
    String tagsDB = tags.join(",");
    String newContent = content.replaceAll(' ', '_');
    // String dataFinal = '$authorId, $authorName, $newContent, $tagsDB';
    try {
      await database!.transaction((txn) async {
        await txn.rawInsert(
            'INSERT INTO $tableName (authorId,authorName,content,tags) VALUES(? ,?, ?, ?)',
            [authorId, authorName, content, tagsDB]);
      });
    } on Exception catch (e) {
      Get.snackbar('Something went wrong', 'Error while add to favourites');
    }
    // favourites.add([authorId, authorName, newContent, tagsDB]);
    copyIntoObject();
  }

  Future<void> deleteFromDatabase(String authorId) async {
    authorId = authorId.replaceAll("{", "");
    try {
      await database!
          .rawDelete('DELETE FROM $tableName WHERE authorId = (?)', [authorId]);
    } catch (e) {
      Get.snackbar('Cannot Delete this item', 'Something went wrong');
      return;
    }
    copyIntoObject();
    // favourites.rem;
  }

  Future<void> deleteAll() async {
    if (!await databaseExists()) {
      await database!.rawDelete('DELETE * FROM  $tableName');
      await database!.delete(tableName);
    }
    favourites.clear();
    update();
  }
}
