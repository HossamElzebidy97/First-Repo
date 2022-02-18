

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/Shop/ChangeFavritesModel.dart';
import 'package:shop_app/models/Shop/FavoritesModel.dart';
import 'package:shop_app/models/Shop/ShopCategoriesModel.dart';
import 'package:shop_app/models/Shop/ShopHomeModel.dart';
import 'package:shop_app/models/Shop/ShopLoginModel.dart';
import 'package:shop_app/modules/ShopApp/Categories/categoriesScreen.dart';
import 'package:shop_app/modules/ShopApp/Favorites/FavoritesScreen.dart';
import 'package:shop_app/modules/ShopApp/Products/ProductsScreen.dart';
import 'package:shop_app/modules/ShopApp/Settings/SettingsScreen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/endPoints.dart';
import 'package:shop_app/shared/network/remote/dioHelper.dart';

class ShopCubit extends Cubit<ShopStates>{

  ShopCubit():super(ShopInitialState());

  static ShopCubit get(context)=>BlocProvider.of(context);

  int currentIndex=0;
  List<Widget> bottomScreens=[
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen()
  ];

  void changeBottom(int index){
    currentIndex=index;
    emit(ShopChangeBottomNavState());
  }
  HomeModel? homeModel;
  int id=1;
  Map<int?, bool?> favorites = {};
  void  getHomeData(){
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel=HomeModel.fromJson(value.data);
      // print(homeModel!.data!.banners[0].id);
      // print(homeModel!.status);
      homeModel!.data!.products.forEach((element) {
        favorites.addAll({
          element.id:element.inFavorites,
        });
      });
      print(favorites.toString());
      emit(ShopSuccessHomeDataState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }
  CategoriesModel? categoriesModel;
  void  getCategories(){
    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((value) {
      categoriesModel=CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int productId)
  {
    favorites[productId] = !favorites[productId]!;

    emit(ShopChangeFavoritesState());

    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print(value.data);

      if (changeFavoritesModel!.status==false)
      {
        favorites[productId] = !favorites[productId]!;
      } else
      {
        getFavorites();
      }

      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;

      emit(ShopErrorChangeFavoritesState());
    });
  }

  FavoritesModel? favoritesModel;
  void  getFavorites(){
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel=FavoritesModel.fromJson(value.data);
      // print(value.data);
      emit(ShopSuccessGetFavoritesState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }
  ShopLoginModel? userModel;
  void  getUserData(){
    emit(ShopLoadingUserDataState());
    DioHelper.getData(
      url: PROFILE,
      token:token,
    ).then((value) {
      userModel=ShopLoginModel.fromJson(value.data);
      print(userModel!.data!.name);
      // print(value.data);
      emit(ShopSuccessUserDataState(userModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorUserDataState());
    });
  }
  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopLoadingUpdateUserState());

    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      print(userModel!.data!.name);

      emit(ShopSuccessUpdateUserState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateUserState());
    });
  }

}