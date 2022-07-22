import 'package:bloc/bloc.dart';
import 'package:e_commerce/Models/productmodel.dart';
import 'package:e_commerce/Shared/Components/Network/Remote/diohelper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
part 'bloc_state.dart';

class BlocCubit extends Cubit<BlocState> {
  BlocCubit() : super(BlocInitial());
  static BlocCubit get(context)=> BlocProvider.of(context);
  int titleIndex = 0 ;

  List <dynamic> _AllData=[];
  List <dynamic> _Electronics=[];
  List <dynamic> _MenClothing=[];
  List <dynamic> _WomenClothing=[];
  List <dynamic> _Jewelery=[];
  Map<dynamic,dynamic> _SpecificProduct={};

  List<Model>allData=[];
  List<Model>menData=[];
  List<Model>womenData=[];
  List<Model>jeweleryData=[];
  List<Model>electroData=[];
  List<Model>SpecificProductData = [];
  Model model = Model();

  void ChangeTitleIndex(int index){
    titleIndex = index;
    emit(CatTitleColor());
  }

  void getAll(){
    DioHelper.getData(url: "products", query: {"sort":"asc"} ).then((value) {
      _AllData=value.data;
      for(int i = 0 ; i < _AllData.length ; i++){
        allData.add(Model.fromJson(_AllData[i]));
      }
      emit(GetAllDataSuccess());
    } ).catchError((error){
      print(error.toString());
      emit(GetAllDataFail());
    });
  }

  void getElectronics(){
    DioHelper.getData(url: "products/category/electronics", query: {"sort":"asc"} ).then((value) {
      _Electronics=value.data;
      for(int i = 0 ; i < _Electronics.length ; i++){
        electroData.add(Model.fromJson(_Electronics[i]));
      }
      emit(GetElectronicsDataSuccess());
    } ).catchError((error){
      print(error.toString());
      emit(GetElectronicsDataFail());
    });
  }

  void getMenClothing(){
    DioHelper.getData(url: "products/category/men's clothing", query: {"sort":"asc"} ).then((value) {
      _MenClothing=value.data;
      for(int i = 0 ; i < _MenClothing.length ; i++){
        menData.add(Model.fromJson(_MenClothing[i]));
      }
      print(menData.length);
      emit(GetMenClothingDataSuccess());
    } ).catchError((error){
      print(error.toString());
      emit(GetMenClothingDataFail());
    });
  }

  void getWomenClothing(){
    DioHelper.getData(url: "products/category/women's clothing", query: {"sort":"asc"} ).then((value) {
      _WomenClothing=value.data;
      for(int i = 0 ; i < _WomenClothing.length ; i++) {
        womenData.add(Model.fromJson(_WomenClothing[i]));
      }
      emit(GetWomenClothingDataSuccess());
    } ).catchError((error){
      print(error.toString());
      emit(GetWomenClothingDataFail());
    });
  }

  void getJewelery(){
    DioHelper.getData(url: "products/category/jewelery", query: {"sort":"asc"} ).then((value) {
      _Jewelery=value.data;
      for(int i = 0 ; i < _Jewelery.length ; i++) {
        jeweleryData.add(Model.fromJson(_Jewelery[i]));
      }
      emit(GetJeweleryDataSuccess());
    } ).catchError((error){
      print(error.toString());
      emit(GetJeweleryDataFail());
    });
  }

  Model getSpecificItem(int id){
    // BinarySearch log(n)
    int start=0;
    int end = allData.length-1;
    while(start<=end){
      int mid = ((start+end)/2).toInt();
      if(allData[mid].id < id) start=mid+1;
      else if(allData[mid].id > id)end=mid-1;
      else return allData[mid];
    }
    emit(GetSpecificProductDataFail());
    return model;
  }


}
