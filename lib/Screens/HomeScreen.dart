import 'package:e_commerce/Bloc/bloc_cubit.dart';
import 'package:e_commerce/Models/productmodel.dart';
import 'package:e_commerce/Shared/Components/components.dart';
import 'package:e_commerce/categories/all.dart';
import 'package:e_commerce/categories/electronicsscreen.dart';
import 'package:e_commerce/categories/jeweleryscreen.dart';
import 'package:e_commerce/categories/mensclothingscreen.dart';
import 'package:e_commerce/categories/womensclothingscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = BlocCubit.get(context);
    List<String> titles = [
      "All",
      "Electronics",
      "Men's Clothing",
      "Women's Clothing",
      "Jewelery",
    ];

    List<Widget> screens = [
      AllScreen(),
      ElectronicsScreen(),
      MenClothingScreen(),
      WomenClothingScreen(),
      JeweleryScreen(),
    ];

    return BlocConsumer<BlocCubit, BlocState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Zoba",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.seventeen_mp_outlined),
              )
            ],
            leading: const Icon(Icons.menu),
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20),
            child: Column(
              children: [
                const SizedBox(height: 20.0),
                Container(
                  height: 55.0,
                  child: TextFormField(
                    style: const TextStyle(fontSize: 18.0),
                    decoration: InputDecoration(
                      hintText: "Search Store",
                      hintStyle: const TextStyle(fontSize: 18.0),
                      prefixIcon: const Icon(
                        Icons.search,
                        size: 23.0,
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30.0),
                Container(
                  height: 30.0,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          width: 25.0,
                        );
                      },
                      itemBuilder: (context, index) {
                        return InkWell(
                            onTap: () {
                              cubit.ChangeTitleIndex(index);
                            },
                            child:
                                CategoriesTitle(titles[index], index, context));
                      }),
                ),
                const SizedBox(height: 20,),
                screens[cubit.titleIndex],
              ],
            ),
          ),
        );
      },
    );
  }
}
