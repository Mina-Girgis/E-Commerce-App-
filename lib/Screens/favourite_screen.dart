import 'package:e_commerce/Bloc/bloc_cubit.dart';
import 'package:e_commerce/Shared/Components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FavouriteScreen extends StatelessWidget {
  FavouriteScreen({Key? key}) : super(key: key);

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
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Icon(
                      FontAwesomeIcons.heart,
                      color: Colors.red,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    // cubit.IDSFromDataBase.length.toString(),
                    Text(
                      (cubit.IDSFromDataBase.length > 100)
                          ? "100+"
                          : cubit.IDSFromDataBase.length.toString(),
                      style: const TextStyle(color: Colors.black, fontSize: 30),
                    ),
                  ],
                ),
              ),
            ],
            elevation: 2,
            title: const Text(
              "Favourites",
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: (cubit.IDSFromDataBase.isEmpty)
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "No Favourites Added",
                        style: TextStyle(fontSize: 22),
                      ),
                      Text(
                        "Please add some items to your favourites.",
                        style: TextStyle(fontSize: 17),
                      ),
                    ],
                  ),
                )
              : ListView.separated(
                  separatorBuilder: (context, index) {
                    return const Padding(
                      padding: EdgeInsets.only(right: 10.0, left: 10.0),
                      child: Divider(
                        color: Colors.black38,
                        thickness: 1.0,
                      ),
                    );
                  },
                  itemCount: cubit.IDSFromDataBase.length,
                  itemBuilder: (context, index) {
                    return ProductFavourite(
                        cubit.getSpecificItem(cubit.IDSFromDataBase[index]),
                        context);
                  }),
        );
      },
    );
  }
}
