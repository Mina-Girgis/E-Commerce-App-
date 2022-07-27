import 'package:badges/badges.dart';
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
                padding: const EdgeInsets.all(13.0),
                child: Badge(
                  badgeColor: Colors.deepOrange,
                  badgeContent: Text(cubit.IDSFromDataBase.length.toString()),
                  child: const Icon(
                    FontAwesomeIcons.heart,
                  ),
                ),
              ),
            ],
            elevation: 2,
            title: const Text(
              "Favourites",
              style: TextStyle(color: Colors.deepOrange),
            ),
          ),
          body: (cubit.IDSFromDataBase.isEmpty)
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "No Favourites found",
                        style: TextStyle(fontSize: 22),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "Press ",
                            style: TextStyle(
                                fontSize: 17, color: Colors.deepOrange),
                          ),
                          Icon(FontAwesomeIcons.heart,
                              color: Colors.deepOrange),
                          Text(
                            " to add an item to your favourites",
                            style: TextStyle(fontSize: 17),
                          ),
                        ],
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
                    return ProductFavourite(cubit.getSpecificItem(cubit.IDSFromDataBase[index]), context);
                  }),
        );
      },
    );
  }
}
