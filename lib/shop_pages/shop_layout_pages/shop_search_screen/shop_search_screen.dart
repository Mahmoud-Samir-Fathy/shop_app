
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shop_pages/shop_layout_pages/shop_search_screen/cubit.dart';
import 'package:shop_app/shop_pages/shop_layout_pages/shop_search_screen/states.dart';

class ShopSearchScreen extends StatelessWidget {
  var formKey=GlobalKey<FormState>();
  var textController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (BuildContext context)=>SearchCubit(),
    child: BlocConsumer<SearchCubit,SearchStates>(
      listener: (context,state){

      },
      builder: (context,state){
        return Scaffold(
          appBar:  AppBar(),
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  defaultTextFormField(
                      controller: textController,
                      KeyboardType: TextInputType.text,
                      validate: (value){
                        if(value!.isEmpty){
                          return 'please enter what you looking for';
                        }else{
                          return null;
                        }
                      },
                      onChanged: (String text){

                          SearchCubit.get(context).search(text);


                      },
                      // onSubmit: (String text){
                      // SearchCubit.get(context).search(text);
                      // },
                      lable: 'Search',
                      prefix: Icons.search),
                  SizedBox(height: 15,),
                  if(state is SearchLoadingState)
                    LinearProgressIndicator(),
                  if(state is SearchSuccessState)
                  Expanded(child: ListView.separated(

                      itemBuilder: (context,index)=>buildListProduct(SearchCubit.get(context).searchModel!.data!.data![index],context,isOldPrice: false),
                      separatorBuilder: (context,index)=>mySeparator(),
                      itemCount: SearchCubit.get(context).searchModel!.data!.data!.length))
                ],
              ),
            ),
          ),

        );
      },
    ),
    
    );
  }

}