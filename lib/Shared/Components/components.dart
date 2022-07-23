import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce/Bloc/bloc_cubit.dart';
import 'package:e_commerce/Models/productmodel.dart';
import 'package:e_commerce/Screens/productinfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final urlImages = [
  'https://3udno63459u23yboa6366rls-wpengine.netdna-ssl.com/wp-content/uploads/2017/05/Best-Offers-In-Ecommerce.jpg',
  'https://3udno63459u23yboa6366rls-wpengine.netdna-ssl.com/wp-content/uploads/2017/05/Best-Offers-In-Ecommerce.jpg',
  'https://3udno63459u23yboa6366rls-wpengine.netdna-ssl.com/wp-content/uploads/2017/05/Best-Offers-In-Ecommerce.jpg',
  'https://thumbs.dreamstime.com/b/vector-illustration-cool-new-arrival-sticker-tag-banner-megaphone-vector-illustration-new-arrival-sticker-tag-banner-169160809.jpg',
  'https://thumbs.dreamstime.com/b/vector-illustration-cool-new-arrival-sticker-tag-banner-megaphone-vector-illustration-new-arrival-sticker-tag-banner-169160809.jpg',
];




Widget CategoriesTitle(String s, int index, context) {
  int num = BlocCubit.get(context).titleIndex;
  return BlocConsumer<BlocCubit, BlocState>(
    listener: (context, state) {},
    builder: (context, state) {
      return Container(
        height: 50.0,
        child: Text(
          s,
          style: TextStyle(
            fontSize: 20.0,
            color: num == index
                ? Colors.deepOrange
                : const Color.fromRGBO(149, 149, 149, 1.0),
          ),
        ),
      );
    },
  );
}

Widget ProductItem(Model model) {
  return Container(
    width: 190,
    height: 310,
    decoration: BoxDecoration(
      //color:Color.fromRGBO(231, 231, 231, 1.0),
      border: Border.all(
          width: 1 ,
          color: Colors.grey,
        ),
      borderRadius: BorderRadius.circular(15.0),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // SizedBox(height: 20.0,),
        Container(
          width: 180,
          height: 170,
          decoration: BoxDecoration(
              // color:Color.fromRGBO(231, 231, 231, 1.0),
              //   borderRadius: BorderRadius.circular(20.0),
              ),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: ClipRRect(
              // borderRadius: BorderRadius.circular(50.0),
              child: Image.network(
                model.image,
                // fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Text(
            model.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 18.0,
                color: Colors.blueGrey[400],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  "\$ ${model.price}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.w500),
                ),
              ),
              IconButton(
                onPressed: () {

                },
                icon: const Icon(FontAwesomeIcons.heart,),
                // icon heartCircleCheck
                iconSize: 26.0,
              )
            ],
          ),
        ),
      ],
    ),
  );
}

Widget Sliderrr() {
  return CarouselSlider.builder(
      itemCount: urlImages.length,
      options: CarouselOptions(height: 200,
      autoPlay: true,
      enlargeCenterPage: true,
      enlargeStrategy: CenterPageEnlargeStrategy.height,
      autoPlayInterval: const Duration(seconds: 2)),
      itemBuilder: (context, index, realIndex) {
        final urlImage = urlImages[index];
        return buildImage(urlImage, index);
      }
      );
}

Widget buildImage(String urlImage, int index) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(width: 1),
     color: Colors.grey,
    ),
    margin: const EdgeInsets.symmetric(horizontal: 12),
    child: Image.network(
      urlImage,
      fit: BoxFit.cover,
    ),
  );
}

Widget ScreenItems(List<Model>model){
  return Container(
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
        childAspectRatio: 0.65,
      ),
      itemCount: model.length,
      itemBuilder: (context,index){
        return InkWell(
            onTap: (){
              Navigator.push(context,MaterialPageRoute(builder: (context) =>  ProductInfo(model: model[index],)));
            },
            child: ProductItem(model[index])
        );
      },
    ),
  );
}