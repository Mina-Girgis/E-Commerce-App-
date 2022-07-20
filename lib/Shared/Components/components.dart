import 'package:e_commerce/Bloc/bloc_cubit.dart';
import 'package:e_commerce/Models/productmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

Widget CategoriesTitle(String s, int index, context) {
  int num = BlocCubit.get(context).titleIndex;

  return BlocConsumer<BlocCubit, BlocState>(
    listener: (context, state) {},
    builder: (context, state) {
      return Container(
        height: 50.0,
        child: Text(
          s,
          style: TextStyle(
            fontSize: 20.0,
            color: num == index
                ? Colors.orange
                : const Color.fromRGBO(149, 149, 149, 1.0),
          ),
        ),
      );
    },
  );
}

Widget ProductItem(Model model) {
  return Container(
    width: 190,
    height: 310,
    decoration: BoxDecoration(
    // color:Color.fromRGBO(231, 231, 231, 1.0),
      border: Border.all(width: 1.0),
      borderRadius: BorderRadius.circular(15.0),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // SizedBox(height: 20.0,),
          Container(
            width: 180,
            height: 200,
              decoration:  BoxDecoration(
              // color:Color.fromRGBO(231, 231, 231, 1.0),
              //   borderRadius: BorderRadius.circular(20.0),
              ),
              child: Padding(
                padding:  EdgeInsets.all(8.0),
                child: ClipRRect(
                  // borderRadius: BorderRadius.circular(50.0),
                  child: Image.network(
                    model.image ,
                    // fit: BoxFit.cover,
                  ),

                ),
              ),

          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0,right: 8.0),
            child: Text(
              model.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 18.0
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0 ,right: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text("\$ ${model.price}",
                    maxLines: 2,
                    //overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 20.0,
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.ten_k_sharp),
                    iconSize: 40.0,

                )
              ],
            ),
          ),



        ],
      ),
  );
}
