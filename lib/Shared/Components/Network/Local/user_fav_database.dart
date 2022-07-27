import 'package:e_commerce/Bloc/bloc_cubit.dart';
import 'package:e_commerce/Models/usermodel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class UserFavDatabase {

  static late Database database ;
  static List<int> userFavProductsID = [];

  static Future<void> createDatabase() async {
    database = await openDatabase('userFav.db', version: 1,
        onCreate: (database, version) {
          print("UserFavDatabase is created !!");
          database.execute('CREATE TABLE userFav (id INTEGER PRIMARY KEY, userId INTEGER, productId INTEGER)')
              .then((value) {
            print('UserFav TABLE IS CREATED !!');
          }).catchError((error) {
            print(error.toString());
          });
        }, onOpen: (database){
          print('UserFavDatabase is open !!');
          getData(database,BlocCubit.currentUserID);
        });
  }

  static Future<void> getData(Database database,int id) async {
    userFavProductsID.clear();
    await database.rawQuery('SELECT * FROM userFav WHERE userId = ?' ,[id]).then((value) {
      value.forEach((element) {
        // print(int.parse(element['productId'].toString()));
        userFavProductsID.add(int.parse(element['productId'].toString()));
      });
      print('From userFav getData function Length is : ${userFavProductsID.length}');
      print(userFavProductsID);
    }).catchError((error) {
      print(error.toString());
    });
  }

  static Future<void> insertDatabase({required  int userID, required int productId,}) async {
    userFavProductsID.clear();
    await database.rawInsert(
        'INSERT INTO userFav (userId,productId) VALUES (?,?)',
        [userID,productId]).then((value) {
      // print(" userFavDatabase Record ${userFavProductsID.length} is inserted !!");
      getData(database,userID);
    }).catchError((error) {
      print(error.toString());
    });
  }

  static void deleteProductFromDatabase(int userId,  int productId) async{
    await database.rawDelete('DELETE FROM userFav WHERE userId = ? AND productId = ?', [userId,productId]).then((value) {
      print(value);
      getData(database, userId);
    }).catchError((error) {
      print(error.toString());
    });
  }

  static void deleteAllData() async{
    await database.rawDelete('DELETE FROM userFav').then((value) {
      print('table deleted');
    }).catchError((error) {
      print(error.toString());
    });
    userFavProductsID.clear();
  }


}
