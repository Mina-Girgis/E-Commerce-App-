import 'package:e_commerce/Bloc/bloc_cubit.dart';
import 'package:e_commerce/Models/productmodel.dart';
import 'package:e_commerce/Screens/productinfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  TextEditingController ProductName = TextEditingController();
  List<Model> searchItems = [];

  var formKey = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    var cubit = BlocCubit.get(context);

    return BlocConsumer<BlocCubit, BlocState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
            // appBar: AppBar(),
            body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                Container(
                  height: 70,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      // borderRadius: BorderRadius.circular(30),
                      color: Color.fromRGBO(255, 255, 255, 0.3411764705882353)),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Form(
                      key: formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(3),
                        child: TextFormField(
                          controller: ProductName,
                          decoration: const InputDecoration(
                            hintText: "Search Store",
                            hintStyle: TextStyle(fontSize: 17.0),
                            prefixIcon: Icon(
                              Icons.search,
                              size: 20.0,
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                              // borderRadius: BorderRadius.circular(40),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                          ),
                          onChanged: (value) {
                            searchItems = cubit.allData
                                .where((element) => element.title
                                    .toString()
                                    .toLowerCase()
                                    .contains(value))
                                .toList();
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: ListView.separated(
                      itemCount: ProductName.text.isNotEmpty
                          ? searchItems.length
                          : cubit.allData.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(
                          thickness: 2,
                        );
                      },
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            if (searchItems.isEmpty) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProductInfo(
                                          model: cubit.allData[index])));
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProductInfo(
                                          model: searchItems[index])));
                            }
                            cubit.productQuantity = 1;
                          },
                          leading: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Image.network(ProductName.text.isNotEmpty
                                ? searchItems[index].image
                                : cubit.allData[index].image),
                          ),
                          title: Text(ProductName.text.isNotEmpty
                              ? searchItems[index].title
                              : cubit.allData[index].title),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
      },
    );
  }
}
