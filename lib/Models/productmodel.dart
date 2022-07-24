import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Model {
  Color color = Colors.black38;
  dynamic title;
  dynamic id;
  dynamic price;
  dynamic description;
  dynamic category;
  dynamic image;
  dynamic rate;
  dynamic countRate;
  int? quantity = 1;
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

  Model.fromModel(Model m){
    this.quantity=m.quantity;
    this.price = m.price;
    this.title = m.title;
    this.image=m.image;
    this.id = m.id;
    this.rate = m.rate;
    this.description = m.description;
    this.countRate = m.countRate;
    this.category = m.category;
  }

  void ChangeQuantity(int q){
    quantity = q;
  }

  void ChangeColor(){
    if(color == Colors.black38)
      color=Colors.red;
    else
      color = Colors.black38;
  }


}