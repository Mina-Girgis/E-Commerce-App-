import 'package:e_commerce/Bloc/bloc_cubit.dart';
import 'package:e_commerce/Shared/Components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class AllScreen extends StatelessWidget {
  const AllScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = BlocCubit.get(context);
    return  BlocConsumer<BlocCubit,BlocState>(
        listener: (context,state){},
        builder: (context,state){
          return Container(
            // width: 200,
            height: 300,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context,index){
                  return SizedBox(width: 20,);
                },
                itemCount: 20,
                itemBuilder: (context,index){
                  return ProductItem(cubit.allData[index]);
                },
            ),
          );
        },
    );
  }
}
