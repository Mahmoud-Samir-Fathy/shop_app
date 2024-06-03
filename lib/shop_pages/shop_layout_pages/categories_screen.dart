import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_login_model/shop_categories_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shop_layout/shop_app/shop_cubit.dart';
import 'package:shop_app/shop_layout/shop_app/shop_states.dart';



class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
        builder: (context,state){
        return ListView.separated(
            itemBuilder: (context,index)=>buildCatItem(ShopCubit.get(context).categoriesModel!.data!.categoriesData![index]),
            separatorBuilder: (context,index)=>mySeparator(),
            itemCount: ShopCubit.get(context).categoriesModel!.data!.categoriesData!.length);
        });
  }
}

Widget buildCatItem(DataModel cmodel)=>Padding(
  padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
  child: Row(
    children: [
      Image(image: NetworkImage('${cmodel.image}'),
        height: 150,
        width: 150,
      ),
      SizedBox(width: 15,),
      Text('${cmodel.name}'),
      Spacer(),
      Icon(Icons.arrow_forward_ios_rounded)
    ],

  ),
);