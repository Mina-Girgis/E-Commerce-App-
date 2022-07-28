import 'package:bloc/bloc.dart';
import 'package:e_commerce/Models/comments_model.dart';
import 'package:e_commerce/Models/order_model.dart';
import 'package:e_commerce/Models/productmodel.dart';
import 'package:e_commerce/Models/usermodel.dart';
import 'package:e_commerce/Shared/Components/Network/Local/comments_database.dart';
import 'package:e_commerce/Shared/Components/Network/Local/orders_database.dart';
import 'package:e_commerce/Shared/Components/Network/Local/user_database.dart';
import 'package:e_commerce/Shared/Components/Network/Local/user_fav_database.dart';
import 'package:e_commerce/Shared/Components/Network/Remote/diohelper.dart';
import 'package:e_commerce/Shared/Components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'bloc_state.dart';

class BlocCubit extends Cubit<BlocState> {
  BlocCubit() : super(BlocInitial());
  static BlocCubit get(context) => BlocProvider.of(context);
  int titleIndex = 0;
  static int currentUserID = 0;

  User currentUser = new User();
  int productQuantity = 1;


/********************************************/




  List<int> IDSFromDataBase = UserFavDatabase.userFavProductsID;
  // id list from database
  int findColor(int id) {
    // find its INDEX in all data by its ID
    for (int i = 0; i < allData.length; i++) {
      if (id == allData[i].id) {
        emit(FindColorSuccess());
        return i;
      }
    }
    emit(FindColorFail());
    return 0;
  }

  void SetFavProducts() {
    // set Fav when screen opens
    print("from setFav function length is ${IDSFromDataBase.length}");
    IDSFromDataBase.sort();
    int idIndex = 0;
    for (int i = 0; i < allData.length; i++) {
      if (idIndex >= IDSFromDataBase.length) break;
      if (allData[i].id == IDSFromDataBase[idIndex]) {
        allData[i].ChangeColor();
        print("colorChanged");
        idIndex++;
      }
    }
    emit(SetFavProductSuccess());
  }

  void ChangeProductColor(int id, context) {
    bool inDataBase = false;
    int index = -1;
    for (int i = 0; i < IDSFromDataBase.length; i++) {
      if (IDSFromDataBase[i] == id) {
        inDataBase = true;
        index = i;
        break;
      }
    }

    for (int i = 0; i < allData.length; i++) {
      if (allData[i].id == id) {
        if (inDataBase) {
          UserFavDatabase.deleteProductFromDatabase(currentUserID, id);
          SnackbarMessage(context, "item is removed");
        } else {
          UserFavDatabase.insertDatabase(userID: currentUserID, productId: id);
          SnackbarMessage(context, "item is added");
        }
        allData[i].ChangeColor();
        break;
      }
    }
    // print(IDSFromDataBase);
    emit(ChangeProductColorSuccess());
  }

/**********************************************/



  List<User> users = UsersDatabase.userData;
  List<dynamic> _AllData = [];
  List<dynamic> _Electronics = [];
  List<dynamic> _MenClothing = [];
  List<dynamic> _WomenClothing = [];
  List<dynamic> _Jewelery = [];
  Map<dynamic, dynamic> _SpecificProduct = {};

  List<Model> allData = [];
  List<Model> menData = [];
  List<Model> womenData = [];
  List<Model> jeweleryData = [];
  List<Model> electroData = [];
  List<Model> SpecificProductData = [];
  List<Model> cartData = [];
  List<CommentsInfo> commentsData = CommentsDatabase.Comments;
  Model model = Model();

  Map< String,List<ProductAndQuantity>>mapOfOrders =OrdersDatabase.mp;
  List<String>orderIds = OrdersDatabase.orderIds;
  List<int>topBestProduct = OrdersDatabase.topBestProduct;
  int numberOfBestProducts = 7;

  double totalPrice = 0.0;
  void AddToTotalPrice(double cost, int q){
    totalPrice+= (cost*q);
    emit(AddToTotalPriceSuccess());
  }
  void RemoveFromTotalPrice(double cost, int q){
    totalPrice-= (cost*q);
    emit(RemoveFromTotalPriceSuccess());
  }

  String GetUserById(int id){
    String s="";
      for(int i = 0 ; i < users.length;i++){
        if(id == int.parse(users[i].id)){
          // print("YESSS");
          s = users[i].name;
        }
      }
      // emit(GetUserNameByIdSuccess());
      return s;
  }
  void ChangeCurrentUser(User user) {
    currentUser = user;
    emit(ChangeCurrentUserSuccess());
  }

  void AddProductInCart(Model model) {
    cartData.add(model);
    print("Product added !!");
    emit(AddProductInCartSuccess());
  }

  void RemoveProductInCart(int index) {
    cartData.removeAt(index);
    print("Product removed !!");
    emit(RemoveProductInCartSuccess());
  }

  void ChangeProductQuantityPlus() {
    productQuantity++;
    emit(ChangeProductQuantityPlusSuccess());
  }

  void ChangeProductQuantityMinus() {
    productQuantity--;
    emit(ChangeProductQuantityMinusSuccess());
  }

  void ChangeTitleIndex(int index) {
    titleIndex = index;
    emit(CatTitleColor());
  }

  void getAll() {
    DioHelper.getData(url: "products", query: {"sort": "asc"}).then((value) {
      _AllData = value.data;
      for (int i = 0; i < _AllData.length; i++) {
        allData.add(Model.fromJson(_AllData[i]));
      }
      emit(GetAllDataSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(GetAllDataFail());
    });
  }

  void getElectronics() {
    DioHelper.getData(
        url: "products/category/electronics",
        query: {"sort": "asc"}).then((value) {
      _Electronics = value.data;
      for (int i = 0; i < _Electronics.length; i++) {
        electroData.add(Model.fromJson(_Electronics[i]));
      }
      emit(GetElectronicsDataSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(GetElectronicsDataFail());
    });
  }

  void getMenClothing() {
    DioHelper.getData(
        url: "products/category/men's clothing",
        query: {"sort": "asc"}).then((value) {
      _MenClothing = value.data;
      for (int i = 0; i < _MenClothing.length; i++) {
        menData.add(Model.fromJson(_MenClothing[i]));
      }
      print(menData.length);
      emit(GetMenClothingDataSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(GetMenClothingDataFail());
    });
  }

  void getWomenClothing() {
    DioHelper.getData(
        url: "products/category/women's clothing",
        query: {"sort": "asc"}).then((value) {
      _WomenClothing = value.data;
      for (int i = 0; i < _WomenClothing.length; i++) {
        womenData.add(Model.fromJson(_WomenClothing[i]));
      }
      emit(GetWomenClothingDataSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(GetWomenClothingDataFail());
    });
  }

  void getJewelery() {
    DioHelper.getData(url: "products/category/jewelery", query: {"sort": "asc"})
        .then((value) {
      _Jewelery = value.data;
      for (int i = 0; i < _Jewelery.length; i++) {
        jeweleryData.add(Model.fromJson(_Jewelery[i]));
      }
      emit(GetJeweleryDataSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(GetJeweleryDataFail());
    });
  }

  Model getSpecificItem(int id) {
    // BinarySearch log(n)
    int start = 0;
    int end = allData.length - 1;
    while (start <= end) {
      int mid = ((start + end) / 2).toInt();
      if (allData[mid].id < id)
        start = mid + 1;
      else if (allData[mid].id > id)
        end = mid - 1;
      else {
        emit(GetSpecificProductDataSuccess());
        return allData[mid];
      }
    }
    emit(GetSpecificProductDataFail());
    return model;
  }

  int SearchInCartData(int id) {
    int start = 0;
    int end = cartData.length - 1;
    int loc = -1;
    while (start <= end) {
      int mid = ((start + end) / 2).toInt();
      if (cartData[mid].id < id)
        start = mid + 1;
      else if (cartData[mid].id > id)
        end = mid - 1;
      else {
        loc = mid;
        break;
      }
    }
    emit(SearchInCartDataSuccess());
    return loc;
  }
}
