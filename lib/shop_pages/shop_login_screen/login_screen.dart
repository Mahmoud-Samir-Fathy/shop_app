import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cashe_helper.dart';
import 'package:shop_app/shop_layout/shop_app/shop_app_layout.dart';
import 'package:shop_app/shop_pages/shop_login_screen/cubit.dart';
import 'package:shop_app/shop_pages/shop_login_screen/states.dart';
import 'package:shop_app/shop_pages/shop_register_screen/register_screen.dart';



class ShopLoginScreen extends StatelessWidget{
  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
var emailController=TextEditingController();
var passwordController=TextEditingController();
    return BlocProvider(
      create: (BuildContext context)=>ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener: (context,state){
          if(state is ShopLoginSuccessState){
            if(state.loginModel.status!=null&&state.loginModel.status==true){
              // print(state.loginModel.message);
              // print(state.loginModel.data!.token);

              CacheHelper.saveData(
                  key: 'token',
                  value: state.loginModel.data!.token).then((value) {
                token=state.loginModel.data!.token!;
                navigateAndFinish(context, Shop_App_layout());

              });

            }else {
              // print(state.loginModel.message);
             showToast(
                 context,
                 icon: Icons.warning,
                 title: 'Error',
                 description: '${state.loginModel.message}',
                 state: ToastColorState.error
             );
            }
          }
        },
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Login',style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
                        SizedBox(height: 5,),
                        Text('Login to browse our hot offers',style: TextStyle(color: Colors.grey,fontSize: 20),),
                        SizedBox(height: 30,),
                        defaultTextFormField(
                            controller: emailController,
                            KeyboardType: TextInputType.emailAddress,
                            validate: (value){
                              if(value!.isEmpty)
                              { return'Please enter your email address';}
                              else {return null;}
                            },
                            lable: 'Email Address',
                            prefix: Icons.email_outlined),
                        SizedBox(height: 20,),
                        defaultTextFormField(

                          onSubmit: (value){
                            if(formKey.currentState!.validate()){
                              ShopLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                            controller: passwordController,
                            KeyboardType: TextInputType.visiblePassword,
                            validate: (value){
                              if(value!.isEmpty)
                              { return'Password isn\'t correct';}
                              else {return null;}
                            },
                            lable: 'Password',
                            prefix: Icons.lock,
                            suffix: ShopLoginCubit.get(context).suffixIcon,
                            isPassword:ShopLoginCubit.get(context).isPasswordShown ,
                            suffixpressed: (){
                              ShopLoginCubit.get(context).changePasswordVisibility();
                            },
                        ),
                        SizedBox(height: 20,),
                        ConditionalBuilder(
                          condition: (state is !ShopLoginLoadingState),
                          builder:(context)=>defaultButton(
                              text: 'LOGIN',
                              Function: (){
                                if(formKey.currentState!.validate()){
                                  ShopLoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              }
                          ) ,
                          fallback:(context)=>Center(child: CircularProgressIndicator()) ,
                        ),
                        SizedBox(height: 15,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account?easy ^_^'),
                            SizedBox(width: 5,),
                            TextButton(onPressed: (){
                              navigateTo(context, ShopRegisterScreen());
                            }, child: Text('Sign Up'))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}