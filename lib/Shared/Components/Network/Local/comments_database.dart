import 'package:e_commerce/Models/comments_model.dart';
import 'package:sqflite/sqflite.dart';

class CommentsDatabase {
  static late Database database;
  static List<CommentsInfo> Comments = [];

  static Future<void> createDatabase() async {
    database = await openDatabase('comments.db', version: 1,
        onCreate: (database, version) {
          print("CommentsDatabase is created !!");
          database
              .execute(
              'CREATE TABLE comments (id INTEGER PRIMARY KEY, userName text, productId INTEGER, title text,time text)')
              .then((value) {
            print('CommentsDatabase TABLE IS CREATED !!');
          }).catchError((error) {
            print(error.toString());
          });
        }, onOpen: (database) {
          print('CommentsDatabase is open !!');
          getData(database, 1);
        });
  }

  static Future<void> getData(Database database, int productId) async {
    Comments.clear();
    await database.rawQuery('SELECT * FROM comments WHERE productId = ?', [productId]).then(
            (value) {
          value.forEach((element) {
            // print(int.parse(element['productId'].toString()));
            Comments.add(CommentsInfo(
                name: element['userName'].toString(),
                comment: element['title'].toString(),
                image: "",
                time: element['time'].toString()));
          });
          print('From comments getData function Length is : ${Comments.length}');
          print(Comments);
        }).catchError((error) {
      print(error.toString());
    });
  }

  static Future<void> insertDatabase({
    required String userName,
    required int productId,
    required String title,
    required String time,
  }) async {
    await database.rawInsert(
        'INSERT INTO comments (userName,productId,title,time) VALUES (?,?,?,?)',
        [userName, productId, title, time]).then((value) {
      // print(" userFavDatabase Record ${userFavProductsID.length} is inserted !!");
      getData(database, productId);
    }).catchError((error) {
      print(error.toString());
    });
  }

  // static void deleteProductFromDatabase(int userId, int productId) {
  //   database.rawDelete(
  //       'DELETE FROM comments WHERE userId = ? AND productId = ?',
  //       [userId, productId]).then((value) {
  //     print(value);
  //     getData(database, userId);
  //   }).catchError((error) {
  //     print(error.toString());
  //   });
  // }

  static void deleteAllData() async{
    await database.rawDelete('DELETE FROM comments').then((value) {
      print('table deleted');
    }).catchError((error) {
      print(error.toString());
    });
    Comments.clear();
  }
}