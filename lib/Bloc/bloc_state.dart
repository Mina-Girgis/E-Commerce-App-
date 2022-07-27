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


class GetSpecificProductDataSuccess extends BlocState {}
class GetSpecificProductDataFail extends BlocState {}

class ChangeCurrentUserIdSuccess extends BlocState {}

class ChangeProductQuantityPlusSuccess extends BlocState {}
class ChangeProductQuantityMinusSuccess extends BlocState {}

class AddProductInCartSuccess extends BlocState {}

class RemoveProductInCartSuccess extends BlocState {}

class SetFavProductSuccess extends BlocState {}

class ChangeProductColorSuccess extends BlocState {}


class FindColorSuccess extends BlocState {}


class FindColorFail extends BlocState {}

class SearchInCartDataSuccess extends BlocState {}

class ChangeCurrentUserSuccess extends BlocState {}




// class UpdateFavFromDatabaseSuccess extends BlocState {}
//
// class GetItemIndexInAllDataByIdSuccess extends BlocState {}
//
// class GetItemIndexInAllDataByIdFail extends BlocState {}



