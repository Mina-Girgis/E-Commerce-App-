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
        listener: (context, state)
    {},
    builder: (context, state) {
    return GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    crossAxisSpacing: 4.0,
    mainAxisSpacing: 4.0
    ),
    itemBuilder: (context,index){
      return Text("hello");
      });
    });
    
    }
  }
