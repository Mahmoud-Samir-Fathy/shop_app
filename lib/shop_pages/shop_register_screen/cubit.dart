import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_login_model/shop_login_model.dart';
import 'package:shop_app/shared/network/end_points/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shop_pages/shop_register_screen/states.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>{

  ShopRegisterCubit():super(ShopRegisterInitialState());

static ShopRegisterCubit get(context)=> BlocProvider.of(context);

ShopLoginModel? registerModel;
IconData suffixIcon=Icons.visibility_off;
bool isPasswordShown=true;
void changePasswordVisibility(){
isPasswordShown=!isPasswordShown;
suffixIcon=isPasswordShown?Icons.visibility_off:Icons.visibility;
emit(ShopChangePassShown());
}

void userRegister({
  required String name,
  required String email,
  required String password,
  required String phone,

}){
emit(ShopRegisterLoadingState());
DioHelper.postData(
url: REGISTER,
data:
{
  'name':name,
  'email':email,
  'password':password,
  'phone':phone,
}

).then((value) {
  registerModel= ShopLoginModel.fromJason(value.data);
 print(value.data);

emit(ShopRegisterSuccessState(registerModel!));
}
).catchError((error){
print(error.toString());
emit(ShopRegisterErrorState(error.toString()));
});
}
}