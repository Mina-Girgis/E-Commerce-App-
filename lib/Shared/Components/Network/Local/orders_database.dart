import 'dart:collection';

import 'package:e_commerce/Bloc/bloc_cubit.dart';
import 'package:e_commerce/Models/order_model.dart';
import 'package:e_commerce/Models/usermodel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tuple/tuple.dart';

class OrdersDatabase {

  static late Database database;
  static Map<String,List<ProductAndQuantity>> mp = {};

  static List<String>orderIds=[];
  static Map<int,int>bestSellerData={};
  static List<int>topBestProduct=[];
  static Future<void> createDatabase() async {
    database = await openDatabase('orders.db', version: 1,
        onCreate: (database, version) {
          print("orders Database is created !!");
          database
              .execute(
              'CREATE TABLE orders (id INTEGER PRIMARY KEY, userID text, productId text , orderId text ,quantity text)')
              .then((value) {
            print('orders TABLE IS CREATED !!');
          }).catchError((error) {
            print(error.toString());
          });
        }, onOpen: (database) {
          print('orders Database is open !!');
          // getData(database , BlocCubit.currentUserID);
          getData(database , BlocCubit.currentUserID);
          getDataForBestSeller(database);
        });
  }

  static Future<void> getData(Database database , int userId) async {
    mp.clear();
    orderIds.clear();
    await database.rawQuery('SELECT * FROM orders where userId = ? ',[userId]).then((value) {
      value.forEach((element) {
          String s = element['orderID'].toString();
          ProductAndQuantity product =  ProductAndQuantity(
            quantity:  int.parse(element["quantity"].toString()),
            productId: int.parse(element["productId"].toString()),
          );
          // data for each order
          if(mp[s]?.length == null){mp[s]=[];}
          mp[s]?.add(product);
          }
      );
      mp.forEach((key, value) {
        orderIds.add(key);
      });
      print('From orders getData function Length is : ${orderIds.length}');
    }).catchError((error) {
      print(error.toString());
    });
  }

  static Future<void> getDataForBestSeller(Database database) async {
    bestSellerData.clear();
    topBestProduct.clear();
    await database.rawQuery('SELECT * FROM orders ').then((value) {
      value.forEach((element) {
        String s = element['orderID'].toString();

        // data for bestSeller
        int productId = int.parse(element["productId"].toString());
        if(bestSellerData[productId] == null) {bestSellerData[productId] = 0;}
        int val = int.parse(bestSellerData[productId].toString());
        bestSellerData[productId]=val+int.parse(element["quantity"].toString());
      }
      );
      getBest7();
      mp.forEach((key, value) {
        orderIds.add(key);
      });
      print('From orders getData function Length is : ${orderIds.length}');
    }).catchError((error) {
      print(error.toString());
    });
  }

  static Future<void> insertDatabase(
      { required int  userID,
        required int productId,
        required String orderID,
        required int quantity,}) async {
    await database.rawInsert(
        'INSERT INTO orders (userID,productId, orderId ,quantity) VALUES ( ?,?,?,?)',
        [userID, productId, orderID, quantity]).then((value) {
      print(" ordersDatabase Record $value is inserted !!");
      // getData(database,userID);
      // getData(database ,BlocCubit.currentUserID);
      // getDataForBestSeller(database);
    }).catchError((error) {
      print(error.toString());
    });
  }


  static void deleteDatabase() async {
    await database
        .rawDelete('DELETE FROM orders').then((value) {
      print(value);
    }).catchError((error) {
      print(error.toString());
    });
  }


  static void getBest7(){
    List<Tuple2<int,int>> myList =[];
    bestSellerData.forEach((key, value) {
      myList.add(Tuple2(value, key));
    });
    myList = myList..sort((a, b) => b.item1.compareTo(a.item1));

    myList.forEach((element) {
      topBestProduct.add(element.item2);
    });
  }

}
