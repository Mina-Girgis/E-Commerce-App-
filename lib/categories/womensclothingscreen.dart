import 'package:e_commerce/Bloc/bloc_cubit.dart';
import 'package:e_commerce/Shared/Components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class WomenClothingScreen extends StatelessWidget {
  const WomenClothingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = BlocCubit.get(context);
    return BlocConsumer<BlocCubit, BlocState>(
        listener: (context, state) {},
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                ScreenItems(cubit.womenData),
                SizedBox(height: 20.0,),
              ],
            ),
          );
        });
  }
}
