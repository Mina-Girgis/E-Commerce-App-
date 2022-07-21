import 'package:e_commerce/Bloc/bloc_cubit.dart';
import 'package:e_commerce/Shared/Components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ElectronicsScreen extends StatelessWidget {
  const ElectronicsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = BlocCubit.get(context);
    return BlocConsumer<BlocCubit, BlocState>(
        listener: (context, state) {},
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  // color: Colors.grey,
                  child: GridView.builder(
                    shrinkWrap: true,
                    // scrollDirection: Axis.vertical,
                    physics: ScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: 0.6,

                    ),
                    itemCount: 6,
                    itemBuilder: (context,index){
                      return ProductItem(cubit.electroData[index]);
                    },
                  ),
                ),
                SizedBox(height: 20.0,),
              ],
            ),
          );
        });
  }
}