import 'package:e_commerce/Bloc/bloc_cubit.dart';
import 'package:e_commerce/Models/productmodel.dart';
import 'package:e_commerce/Shared/Components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          appBar: AppBar(
            title: Text("Cart",style: TextStyle(color: Colors.black,fontSize: 25),),
            centerTitle: true,
          ),
          body: SafeArea(
            child: ListView.separated(
              separatorBuilder: (context,index){
                return Padding(
                  padding: const EdgeInsets.only(right: 10.0,left: 10.0),
                  child: Divider(
                    color: Colors.black38,
                    thickness: 1.0,
                  ),
                );
              },
              itemCount: cubit.cartData.length,
                itemBuilder:(context,index){
                return ProductCart(cubit.cartData[index],context);
                }),
          ),
        );
      },
    );
  }
}
