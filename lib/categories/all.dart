import 'package:e_commerce/Bloc/bloc_cubit.dart';
import 'package:e_commerce/Shared/Components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllScreen extends StatelessWidget {
  const AllScreen({Key? key}) : super(key: key);

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
            const Text("All Products",
              style: TextStyle(fontWeight: FontWeight.w500,
              fontSize: 20,
              color: Colors.deepOrange),),
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
                itemBuilder: (context, index) {
                  return ProductItem(cubit.allData[index]);
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Best Seller",
              style: TextStyle(fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: Colors.deepOrange),),
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
                itemBuilder: (context, index) {
                  return ProductItem(cubit.allData[index]);
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
