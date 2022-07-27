import 'package:e_commerce/Bloc/bloc_cubit.dart';
import 'package:e_commerce/Models/productmodel.dart';
import 'package:e_commerce/Screens/productinfo.dart';
import 'package:e_commerce/Shared/Components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AllScreen extends StatefulWidget {
  AllScreen({Key? key}) : super(key: key);

  @override
  State<AllScreen> createState() => _AllScreenState();
}

class _AllScreenState extends State<AllScreen> {
  @override
  Widget build(BuildContext context) {
    var cubit = BlocCubit.get(context);
    return BlocConsumer<BlocCubit, BlocState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(decoration: BoxDecoration(
              // border: Border.all(width: 0,color: Colors.grey,),
              borderRadius: BorderRadius.circular(10)
            ),
              child: Sliderrr(),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: const Text("All Products",
                    style: TextStyle(fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: Colors.deepOrange),),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(FontAwesomeIcons.angleRight),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              // width: 200,
              height: 270,
              child: ListView.separated(
                physics: ScrollPhysics(),
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) {
                  return SizedBox(width: 20,);
                },
                itemCount: 20,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (){
                    cubit.productQuantity = 1;
                    Navigator.push(context,MaterialPageRoute(builder: (context) =>  ProductInfo(model: cubit.allData[index],)));
                    },
                      child: ProductItem(cubit.allData[index] ,context));
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: const Text("Best Seller",
                    style: TextStyle(fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: Colors.deepOrange),),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(FontAwesomeIcons.angleRight),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              // width: 200,
              height: 270,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) {
                  return SizedBox(width: 20,);
                },
                itemCount: 20,
                itemBuilder: (context,int index) {
                  return InkWell(
                    onTap: (){
                      Model model = cubit.getSpecificItem(cubit.allData[index].id);
                      print(model.title);

                    },
                    child: ProductItem(cubit.allData[index],context),
                  );
                },
              ),
            ),
            const SizedBox(height: 20,)
          ],
        );
      },
    );
  }
}
