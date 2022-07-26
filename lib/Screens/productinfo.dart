import 'package:e_commerce/Bloc/bloc_cubit.dart';
import 'package:e_commerce/Models/productmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProductInfo extends StatelessWidget {
  Model? model;

  ProductInfo({Key? key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = BlocCubit.get(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height / 2.5,
                ),
                padding: const EdgeInsets.only(
                    top: 60.0, left: 30.0, right: 30.0, bottom: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[Image(image: NetworkImage(model!.image))],
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(222, 222, 221, 0.30196078431372547),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 5,
                              width: 70,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "\$ ${model!.price}",
                              style: const TextStyle(
                                  fontSize: 30, color: Colors.deepOrange),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              cubit.ChangeProductColor(model!.id);
                            },
                            icon: const Icon(FontAwesomeIcons.heart),
                            iconSize: 30,
                            color:
                                cubit.allData[cubit.findColor(model!.id)].color,
                          )
                        ],
                      ),
                      Text(
                        "${model!.category}",
                        style:
                            const TextStyle(fontSize: 20, color: Colors.black),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "${model!.title}",
                        style: const TextStyle(
                            fontSize: 20, color: Colors.deepOrange),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          RatingBarIndicator(
                            rating: model!.rate + .0,
                            itemBuilder: (context, index) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemCount: 5,
                            itemSize: 30.0,
                            direction: Axis.horizontal,
                          ),
                          Expanded(
                            child: Text(
                              "${model!.rate}",
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.deepOrange),
                            ),
                          ),
                          Text(
                            "(${model!.countRate}) reviews",
                            style: const TextStyle(
                                fontSize: 20, color: Colors.deepOrange),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        "Description",
                        style: TextStyle(fontSize: 17, color: Colors.black),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "${model!.description}",
                        style: const TextStyle(
                            fontSize: 17,
                            color: Color.fromRGBO(
                                113, 113, 158, 0.5843137254901961)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Model m = Model.fromModel(model!);
                            int index = cubit.SearchInCartData(m.id);
                            if (index != -1) {
                              int? q = cubit.cartData[index].quantity! +
                                  cubit.productQuantity;
                              cubit.cartData[index].ChangeQuantity(q);
                              // ChangeQuantity();
                            } else {
                              m.ChangeQuantity(cubit.productQuantity);
                              cubit.AddProductInCart(m);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.deepOrange,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          icon: const Icon(
                            // <-- Icon
                            FontAwesomeIcons.cartPlus,
                            size: 24.0,
                          ),
                          label: const Text(
                            'Add To Cart',
                            style: TextStyle(fontSize: 19),
                          ), // <-- Text
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    if (cubit.productQuantity != 1) {
                                      cubit.ChangeProductQuantityMinus();
                                    }
                                  },
                                  icon: Icon(
                                    FontAwesomeIcons.minus,
                                    size: 15.0,
                                  ),
                                ),
                                Text(
                                  "${cubit.productQuantity}",
                                  style: TextStyle(fontSize: 20.0),
                                ),
                                IconButton(
                                  onPressed: () {
                                    if (cubit.productQuantity < 5) {
                                      cubit.ChangeProductQuantityPlus();
                                    }
                                  },
                                  icon: Icon(
                                    FontAwesomeIcons.plus,
                                    size: 15.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Show Comments",
                              style: TextStyle(
                                  fontSize: 17, color: Colors.deepOrange),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
