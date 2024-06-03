import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shop_layout/shop_app/shop_cubit.dart';
import 'package:shop_app/shop_layout/shop_app/shop_states.dart';
import '../../shared/components/components.dart';
import '../../shop_pages/shop_layout_pages/shop_search_screen/shop_search_screen.dart';


class Shop_App_layout extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
     listener:(context,state){} ,
      builder:(context,state){
       ShopCubit cubit=ShopCubit.get(context);
       return Scaffold(
         appBar:  AppBar(
           title: Text('Sella'),
           actions: [IconButton(onPressed:(){
             navigateTo(context, ShopSearchScreen());
           }, icon: Icon(Icons.search))],
         ),
         bottomNavigationBar: BottomNavigationBar(
           onTap: (index){
             cubit.ChangeBottomNav(index);
           },
           currentIndex: cubit.currentIndex,
           items: cubit.ShopBottomList
         ),
         body: cubit.shopScreens[cubit.currentIndex],
       );
      } ,
    );
  }
}