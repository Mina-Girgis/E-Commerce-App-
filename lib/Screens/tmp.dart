import 'package:e_commerce/Bloc/bloc_cubit.dart';
import 'package:e_commerce/Shared/Components/Network/Local/comments_database.dart';
import 'package:e_commerce/Shared/Components/Network/Local/orders_database.dart';
import 'package:e_commerce/Shared/Components/Network/Local/user_database.dart';
import 'package:e_commerce/Shared/Components/Network/Local/user_fav_database.dart';
import 'package:e_commerce/Shared/Components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TempScreen extends StatelessWidget {
  const TempScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = BlocCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        centerTitle: true,
        title: Text("hello",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: BlocConsumer<BlocCubit, BlocState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Center(
            child: Container(
              height: 50,
              width: 250,
              child: ElevatedButton(
                onPressed: () async {
                  String time = ActualTime();
                  CommentsDatabase.deleteAllData();
                  UsersDatabase.deleteAllData();
                  UserFavDatabase.deleteAllData();
                  OrdersDatabase.deleteDatabase();
                  // UsersDatabase.getUserById(UsersDatabase.database, 1);
                  // UsersDatabase.getUserById(UsersDatabase.database, 2);
                  // print(cubit.oldUsers);
                  // UsersDatabase.getUserById(UsersDatabase.database, 3);
                  // print(cubit.oldUsers);
                  // UsersDatabase.getUserById(UsersDatabase.database, 4);
                  // print(cubit.oldUsers);
                  // UsersDatabase.getUserById(UsersDatabase.database, 5);
                  // OrdersDatabase.getBest7();
                  // print(cubit.mapOfOrders.length);//1
                  // print(cubit.orderIds.length); // 1
                  // OrdersDatabase.deleteDatabase();
                  // await OrdersDatabase.insertDatabase(
                  //     userID: 1, productId: 11, orderID: "2020", quantity: 100);
                  // OrdersDatabase.getData(OrdersDatabase.database, 1);
                  // print(cubit.orderIds.length);
                },
                child: Text("click Me"),
              ),
            ),
          );
        },
      ),
    );
  }
}
