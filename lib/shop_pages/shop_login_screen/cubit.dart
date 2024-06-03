import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_login_model/shop_login_model.dart';
import 'package:shop_app/shared/network/end_points/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shop_pages/shop_login_screen/states.dart';


class ShopLoginCubit extends Cubit<ShopLoginStates>{

  ShopLoginCubit():super(ShopLoginInitialState());

  static ShopLoginCubit get(context)=> BlocProvider.of(context);

  ShopLoginModel? loginModel;
  IconData suffixIcon=Icons.visibility_off;
  bool isPasswordShown=true;
  void changePasswordVisibility(){
    isPasswordShown=!isPasswordShown;
    suffixIcon=isPasswordShown?Icons.visibility_off:Icons.visibility;
    emit(ShopChangePasswordShown());
  }

  void userLogin({
    required String email,
    required String password,
}){
    emit(ShopLoginLoadingState());
    DioHelper.postData(
        url: LOGIN,
        data:
    {
      'email':email,
      'password':password
    }

    ).then((value) {
     loginModel= ShopLoginModel.fromJason(value.data);
      // print(value.data);

     emit(ShopLoginSuccessState(loginModel!));
    }
    ).catchError((error){
      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
  }


}