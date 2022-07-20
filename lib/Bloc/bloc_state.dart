part of 'bloc_cubit.dart';

@immutable
abstract class BlocState {}

class BlocInitial extends BlocState {}
class CatTitleColor extends BlocState {}

class GetAllDataSuccess extends BlocState {}
class GetAllDataFail extends BlocState {}



class GetElectronicsDataSuccess extends BlocState {}
class GetElectronicsDataFail extends BlocState {}



class GetMenClothingDataSuccess extends BlocState {}
class GetMenClothingDataFail extends BlocState {}



class GetWomenClothingDataSuccess extends BlocState {}
class GetWomenClothingDataFail extends BlocState {}



class GetJeweleryDataSuccess extends BlocState {}
class GetJeweleryDataFail extends BlocState {}



