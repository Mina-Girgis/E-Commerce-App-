import 'package:badges/badges.dart';
import 'package:e_commerce/Bloc/bloc_cubit.dart';
import 'package:e_commerce/Shared/Components/Network/Local/orders_database.dart';
import 'package:e_commerce/Shared/Components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CartScreen extends StatelessWidget {
  CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = BlocCubit.get(context);
    return BlocConsumer<BlocCubit, BlocState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          floatingActionButton:(cubit.cartData.length!=0)? FloatingActionButton.extended(
            onPressed: (){
                String Time = ActualTime();
                for(int i =0 ; i < cubit.cartData.length ; i++){
                  OrdersDatabase.insertDatabase(
                      userID: int.parse(cubit.currentUser.id.toString()) ,
                      productId: int .parse(cubit.cartData[i].id.toString()),
                      orderID: Time,
                      quantity: int.parse(cubit.cartData[i].quantity.toString()));
                }
                cubit.cartData.clear();
                OrdersDatabase.getData(OrdersDatabase.database, BlocCubit.currentUserID);
                OrdersDatabase.getDataForBestSeller(OrdersDatabase.database);
                cubit.totalPrice=0.0;
                // OrdersDatabase.getDataForBestSeller(OrdersDatabase.database);
                SnackbarMessage(context,"Items Added");
            },
            label: Text(" BUY NOW "),
            backgroundColor: Colors.deepOrange,
          ) : FloatingActionButton.small(onPressed: (){},backgroundColor: Colors.transparent,elevation: 0.0,),
          appBar: AppBar(
            elevation: 2,
            title: const Text(
              "Cart",
              style: TextStyle(color: Colors.deepOrange, fontSize: 25),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(top:10.0),
                child: Text(
                   '${cubit.totalPrice.toStringAsFixed(3)}',
                  style: TextStyle(
                      color: Colors.black ,
                    fontSize: 25.0
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Badge(
                  badgeColor: Colors.deepOrange,
                  badgeContent: Text(cubit.cartData.length.toString()),
                  child: const Icon(FontAwesomeIcons.cartShopping),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Text(cubit.cartData.length.toString(),
              //       style: TextStyle(color: Colors.black, fontSize: 25)),
              // ),
            ],
          ),
          body: (cubit.cartData.isEmpty)
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "There is no items in your cart.",
                        style: TextStyle(fontSize: 22),
                      ),
                      Text(
                        "Your cart lives to serve.",
                        style: TextStyle(fontSize: 17),
                      ),
                      Text(
                        "Give it purpose.",
                        style:
                            TextStyle(fontSize: 17, color: Colors.deepOrange),
                      ),
                    ],
                  ),
                )
              : SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height:MediaQuery.of(context).size.height-100,
                      child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return const Padding(
                              padding: EdgeInsets.only(right: 10.0, left: 10.0),
                              child: Divider(
                                color: Colors.black38,
                                thickness: 1.0,
                              ),
                            );
                          },
                          itemCount: cubit.cartData.length,
                          itemBuilder: (context, index) {
                            return ProductCart(cubit.cartData[index], context);
                          }),
                    ),
                  ],
                ),
              ),
        );
      },
    );
  }
}
