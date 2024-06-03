import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_login_model/shop_categories_model.dart';
import 'package:shop_app/models/shop_login_model/shop_changefavourite_model.dart';
import 'package:shop_app/models/shop_login_model/shop_favourite_model.dart';
import 'package:shop_app/models/shop_login_model/shop_home_model.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/end_points/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shop_layout/shop_app/shop_states.dart';
import 'package:shop_app/shop_pages/shop_layout_pages/categories_screen.dart';
import 'package:shop_app/shop_pages/shop_layout_pages/favourite_screen.dart';
import 'package:shop_app/shop_pages/shop_layout_pages/products_screen.dart';
import 'package:shop_app/shop_pages/shop_layout_pages/settings_screen.dart';

import '../../models/shop_login_model/shop_login_model.dart';

class ShopCubit extends Cubit<ShopStates>{

  ShopCubit(): super(ShopInitialState());

  static ShopCubit get(context)=> BlocProvider.of(context);

  List<Widget> shopScreens=[
    ProductsScreen(),
    CategoriesScreen(),
    FavouritesScreen(),
    SettingsScreen(),
  ];
  List<BottomNavigationBarItem> ShopBottomList=[
    BottomNavigationBarItem(icon:Icon(Icons.home) ,label:'Products' ),
    BottomNavigationBarItem(icon:Icon(Icons.apps) ,label:'Categories' ),
    BottomNavigationBarItem(icon:Icon(Icons.favorite) ,label:'Favorite' ),
    BottomNavigationBarItem(icon:Icon(Icons.settings) ,label:'Settings' ),
  ];
   int currentIndex=0;

   void ChangeBottomNav(int index){
     currentIndex=index;
     emit(ShopChangeBottomNavBar());
   }
 HomeModel? homeModel;
   Map<int?,bool?> favourite={};
   void getHomeData(){
     emit(ShopLoadingHomeDataState());
      DioHelper.getData(
          url: HOME,
           token:token,
      ).then((value) {

        homeModel=HomeModel.fromJason(value!.data);
        // print(homeModel!.status);
        // printFullText(homeModel!.data!.banners![0].image.toString());
        homeModel!.data!.products!.forEach((element) {
          favourite.addAll({
            element.id:element.in_favorites,
          });
        });
      // print(favourite.toString());
        emit(ShopSuccessHomeDataState(homeModel!));
      }).catchError((error){
        print(error.toString());
        emit(ShopErrorHomeDataState(error.toString()));
      });

   }
  CategoriesModel? categoriesModel;
  void getCategoriesData(){
    DioHelper.getData(
      url: CATEGORIES,
      token:token,
    ).then((value) {
      categoriesModel=CategoriesModel.fromJason(value!.data);

      emit(ShopSuccessCategoriesDataState(categoriesModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorCategoriesDataState(error.toString()));
    });
  }
  // bool isPressed=false;
  // void changeFavIcon(){
  //   isPressed=!isPressed;
  //   emit(ShopChangeFavIconState());
  // }
FavouriteModel? favouriteModel;
  void ChangeFavourite(int productId){

    favourite[productId]=!favourite[productId]!;
    emit(ShopChangeFavIconState());
    DioHelper.postData(
        url: FAVOURITE,
        token: token,
        data: {
          'product_id':productId,
        }).then((value) {
      favouriteModel=FavouriteModel.forJason(value.data);
      // print(value.data);
      if(!favouriteModel!.status!){
        favourite[productId]=!favourite[productId]!;
      }else{
        getFavData();
      }
          emit(ShopSuccessChangeFavouriteState(favouriteModel!));
    }).catchError((error){
      favourite[productId]=!favourite[productId]!;
          emit(ShopErrorChangeFavouriteState(error));
    });

  }
  FavModel? favModel;
  void getFavData(){
    emit(ShopFavLoadingState());
    DioHelper.getData(
      url: FAVOURITE,
      token:token,
    ).then((value) {
      favModel=FavModel.fromJson(value!.data);
      // printFullText(value.data.toString());
      emit(ShopSuccessFavDataState(favModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorFavDataState(error.toString()));
    });
  }
  ShopLoginModel? userModel;
  void getUserData(){
    emit(ShopLoadingGetUserDataState());
    DioHelper.getData(
      url: PROFILE,
      token:token,
    ).then((value) {
      userModel=ShopLoginModel.fromJason(value!.data);
       printFullText(userModel!.data!.name!);
      emit(ShopSuccessGetUserDataState(userModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorGetUserDataState(error.toString()));
    });
  }
  void upDateUserData({
    required String name,
    required String email,
    required String phone
}){
    emit(ShopLoadingUpDateUserDataState());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      token:token,
      data:{
        'name':name,
        'email':email,
        'phone':phone

      }
    ).then((value) {
      userModel=ShopLoginModel.fromJason(value.data);
      printFullText(userModel!.data!.name!);
      emit(ShopSuccessUpDateUserDataState(userModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorUpDateUserDataState(error.toString()));
    });
  }


}