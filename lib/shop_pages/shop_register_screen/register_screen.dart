import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cashe_helper.dart';
import 'package:shop_app/shop_pages/shop_login_screen/login_screen.dart';
import 'package:shop_app/shop_pages/shop_register_screen/cubit.dart';
import 'package:shop_app/shop_pages/shop_register_screen/states.dart';



class ShopRegisterScreen extends StatelessWidget{
  var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var nameController=TextEditingController();
    var emailController=TextEditingController();
    var passwordController=TextEditingController();
    var phoneController=TextEditingController();

    return BlocProvider(
      create: (BuildContext context)=>ShopRegisterCubit(),
       child: BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
        listener: (context,state){
          if(state is ShopRegisterSuccessState){
            if(state.registerModel.status!=null&&state.registerModel.status==true){
              // print(state.loginModel.message);
              // print(state.loginModel.data!.token);

              CacheHelper.saveData(
                  key: 'token',
                  value: state.registerModel.data!.token).then((value) {
                token=state.registerModel.data!.token!;
                navigateAndFinish(context, ShopLoginScreen());

              });

            }else {
              // print(state.loginModel.message);
              showToast(
                  context,
                  icon: Icons.warning,
                  title: 'Error',
                  description: '${state.registerModel.message}',
                  state: ToastColorState.error
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body:  Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Register',style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
                        SizedBox(height: 5,),
                        Text('Register to browse our hot offers',style: TextStyle(color: Colors.grey,fontSize: 20),),
                        SizedBox(height: 30,),

                        defaultTextFormField(
                            controller: nameController,
                            KeyboardType: TextInputType.text,
                            validate: (value){
                              if(value!.isEmpty)
                              { return'Please enter your Full Name';}
                              else {return null;}
                            },
                            lable: 'Full Name',
                            prefix: Icons.person),
                        SizedBox(height: 20,),

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

                          // onSubmit: (value){
                          //   if(formKey.currentState!.validate()){
                          //     ShopLoginCubit.get(context).userLogin(
                          //         email: emailController.text,
                          //         password: passwordController.text);
                          //   }
                          // },
                          controller: passwordController,
                          KeyboardType: TextInputType.visiblePassword,
                          validate: (value){
                            if(value!.isEmpty)
                            { return'Password isn\'t correct';}
                            else {return null;}
                          },
                          lable: 'Password',
                          prefix: Icons.lock,
                          suffix: ShopRegisterCubit.get(context).suffixIcon,
                          isPassword:ShopRegisterCubit.get(context).isPasswordShown ,
                          suffixpressed: (){
                            ShopRegisterCubit.get(context).changePasswordVisibility();
                          },
                        ),
                        SizedBox(height: 20,),

                        defaultTextFormField(
                            controller: phoneController,
                            KeyboardType: TextInputType.phone,
                            validate: (value){
                              if(value!.isEmpty)
                              { return'Please enter your mobile number';}
                              else {return null;}
                            },
                            lable: 'Phone',
                            prefix: Icons.phone),
                        SizedBox(height: 20,),

                        ConditionalBuilder(
                          condition: (state is !ShopRegisterLoadingState),
                          builder:(context)=>defaultButton(
                              text: 'Register',
                              isUpperCase: true,
                              Function: (){
                                if(formKey.currentState!.validate()){
                                  ShopRegisterCubit.get(context).userRegister(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      phone: phoneController.text,


                                  );
                                }
                              }
                          ) ,
                          fallback:(context)=>Center(child: CircularProgressIndicator()) ,
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
    ),

    );
  }

}