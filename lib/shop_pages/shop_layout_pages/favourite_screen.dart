import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shop_layout/shop_app/shop_cubit.dart';
import 'package:shop_app/shop_layout/shop_app/shop_states.dart';


class FavouritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){},
        builder: (context,state){
          return ConditionalBuilder(
              condition: state is !ShopFavLoadingState,
              builder: (context)=>ListView.separated(
                  itemBuilder: (context,index)=>buildListProduct(ShopCubit.get(context).favModel!.data!.data![index].product!,context),
                  separatorBuilder: (context,index)=>mySeparator(),
                  itemCount: ShopCubit.get(context).favModel!.data!.data!.length),
              fallback: (context)=>Center(child: CircularProgressIndicator())
          );
        });
  }

}

