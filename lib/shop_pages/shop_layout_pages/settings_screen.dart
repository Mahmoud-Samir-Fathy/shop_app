import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shop_layout/shop_app/shop_cubit.dart';
import 'package:shop_app/shop_layout/shop_app/shop_states.dart';



class SettingsScreen extends StatelessWidget {
  var formKey=GlobalKey<FormState>();
  var nameController=TextEditingController();
  var emailController=TextEditingController();
  var phoneController=TextEditingController();

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ShopCubit,ShopStates>(
      listener:(context,state){

      },
      builder:(context,state){

        var model=ShopCubit.get(context).userModel;

        nameController.text=model!.data!.name!;
        emailController.text=model.data!.email!;
        phoneController.text=model.data!.phone!;


        return ConditionalBuilder(
          condition:ShopCubit.get(context).userModel!=null ,
          builder:(context)=>Scaffold(
              appBar:  AppBar(),
              body: Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(

                      children: [
                        SizedBox(height: 20,),
                        if(state is ShopLoadingUpDateUserDataState) LinearProgressIndicator(),
                        SizedBox(height: 20,),

                        defaultTextFormField(
                            controller: nameController,
                            KeyboardType: TextInputType.text,
                            validate: (value){
                              if(value!.isEmpty){
                                return 'Please enter Full Name';
                              } return null;
                            },
                            lable: 'Name',
                            prefix: Icons.person),
                        SizedBox(height: 20,),
                        defaultTextFormField(
                            controller: emailController,
                            KeyboardType: TextInputType.emailAddress,
                            validate: (value){
                              if(value!.isEmpty){
                                return 'Email must not be empty';
                              } return null;
                            },
                            lable: 'Email',
                            prefix: Icons.email),
                        SizedBox(height: 20,),
                  
                        defaultTextFormField(
                            controller: phoneController,
                            KeyboardType: TextInputType.phone,
                            validate:  (value){
                              if(value!.isEmpty){
                                return 'Please enter your phone number';
                              } return null;
                            },
                            lable: 'Phone',
                            prefix: Icons.phone_android_outlined),
                        SizedBox(height: 30,),
                        defaultButton(text: 'UpDate',
                            Function: (){
                          if(formKey.currentState!.validate()){
                            ShopCubit.get(context).upDateUserData(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text);
                          }
                            }),
                        SizedBox(height: 30,),
                        defaultButton(text: 'Sign out',
                            Function: (){
                              signout(context);
                            })
                      ],
                    ),
                  ),
                ),
              )
          ) ,
          fallback:(context)=>Center(child: CircularProgressIndicator()) ,
        );
        }
        );
  }
}