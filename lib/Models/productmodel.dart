import 'package:flutter/foundation.dart';

class Model {
  dynamic title;
  dynamic id;
  dynamic price;
  dynamic description;
  dynamic category;
  dynamic image;
  dynamic rate;
  dynamic countRate;

  Model({this.image,this.title,this.category,this.countRate,this.id,this.price,this.rate,this.description});

  factory Model.fromJson(Map<dynamic,dynamic> data){
    return Model(
      title: data['title'],
      id : data['id'],
      price: data['price'],
      description: data['description'],
      category: data['category'],
      image: data['image'],
      rate: data['rating']['rate'],
      countRate: data['rating']['count'],
    );
  }


}