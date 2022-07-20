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

  void ChangeTitleIndex(int index){
    titleIndex = index;
    emit(CatTitleColor());
  }

  List <dynamic> _AllData=[];
  List <dynamic> _Electronics=[];
  List <dynamic> _MenClothing=[];
  List <dynamic> _WomenClothing=[];
  List <dynamic> _Jewelery=[];

  List<Model>allData=[];
  List<Model>menData=[];
  List<Model>womenData=[];
  List<Model>jeweleryData=[];
  List<Model>electroData=[];

  void getAll(){
    DioHelper.getData(url: "products", query: {} ).then((value) {
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
    DioHelper.getData(url: "products/category/electronics", query: {} ).then((value) {
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
    DioHelper.getData(url: "products/category/men'sclothing", query: {} ).then((value) {
      _MenClothing=value.data;
      for(int i = 0 ; i < _MenClothing.length ; i++){
        menData.add(Model.fromJson(_MenClothing[i]));
      }
      emit(GetMenClothingDataSuccess());
    } ).catchError((error){
      print(error.toString());
      emit(GetMenClothingDataFail());
    });
  }

  void getWomenClothing(){
    DioHelper.getData(url: "products/category/women'sclothing", query: {} ).then((value) {
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
    DioHelper.getData(url: "products/category/jewelery", query: {} ).then((value) {
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


}
