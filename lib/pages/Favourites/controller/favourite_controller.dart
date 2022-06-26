import 'package:get/get.dart';
import 'package:quote_app/pages/constant/constant.dart';
import 'package:sqflite/sqflite.dart';

class FavouriteController extends GetxController {
  List<dynamic> favourites = [].obs;
  Database? database;
  String tableName = 'favourites';

  @override
  void onInit() {
    super.onInit();
    readFromDatabase();
  }

  @override
  void onClose() {
    database!.close();
  }

  Future<bool> databaseExists() async =>
      await databaseFactory.databaseExists(databasePath);

  Future<void> readFromDatabase() async {
    if (!await databaseExists() && database == null) {
      createDatabase();
      return;
    } else {
      copyIntoObject();
    }
  }

  Future<bool> checkForDatabase() async {
    if (!await databaseExists()) {
      createDatabase();
      return false;
    }
    database = await openDatabase(
      databasePath,
      version: 1,
    );
    return true;
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
    checkForDatabase();
    List<Map> list = await database!.rawQuery('SELECT * FROM $tableName');
    favourites.clear();
    favourites.add(list);
    print(favourites);
    update();
  }

  Future<void> addtoDatabase(String authorId, String authorName, String content,
      List<String> tags) async {
    checkForDatabase();
    String tagsDB = tags.join(",");
    String newContent = content.replaceAll(' ', '_');
    // String dataFinal = '$authorId, $authorName, $newContent, $tagsDB';
    await database!.transaction((txn) async {
      await txn.rawInsert(
          'INSERT INTO $tableName (authorId,authorName,content,tags) VALUES(? ,?, ?, ?)',
          [authorId, authorName, newContent, tagsDB]);
    });
    favourites.add({authorId, authorName, newContent, tags});
    print(favourites);
    update();
  }

  Future<void> deleteFromDatabase(String authorId) async {
    checkForDatabase();
    authorId = authorId.replaceAll("{", "");
    try {
      await database!
          .rawDelete('DELETE FROM $tableName WHERE authorId = (?)', [authorId]);
    } catch (e) {
      Get.snackbar('Cannot Delete this item', 'Something went wrong');
      return;
    }
    copyIntoObject();
  }

  Future<void> deleteAll() async {
    if (!await checkForDatabase()) {
      await database!.rawDelete('DELETE FROM $tableName');
    }
    favourites.clear();
  }
}
