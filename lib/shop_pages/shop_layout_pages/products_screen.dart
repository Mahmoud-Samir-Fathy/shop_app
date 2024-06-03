import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_login_model/shop_categories_model.dart';
import 'package:shop_app/models/shop_login_model/shop_home_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shop_layout/shop_app/shop_cubit.dart';
import 'package:shop_app/shop_layout/shop_app/shop_states.dart';


import '../../../shared/styles/colors.dart';


class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener:(context,state){
          if(state is ShopSuccessChangeFavouriteState){
            if(!state.favouriteModel.status!){
              showToast(context,
                  title: 'Error',
                  description: state.favouriteModel.message!,
                  state: ToastColorState.error,
                  icon: Icons.warning);
            }
          }
        },
        builder: (context,state){
          return Scaffold(
            appBar:  AppBar(),
            body: ConditionalBuilder(
              condition: ShopCubit.get(context).homeModel !=null&&ShopCubit.get(context).categoriesModel !=null,
              builder: (context)=>ProductsBuilder(ShopCubit.get(context).homeModel,ShopCubit.get(context).categoriesModel,context),
              fallback:(context)=>Center(child: CircularProgressIndicator()) ,
            )

          );
        },
        );
  }
  Widget ProductsBuilder(HomeModel? model,CategoriesModel? categoriesModel,context)=>SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
            items: model!.data!.banners!.map((e) =>Image(
              image: NetworkImage('${e.image}'),
              width: double.infinity,
              fit: BoxFit.cover,
            )).toList(),
            options: CarouselOptions(
              height: 200,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
              aspectRatio: 16/9,
              viewportFraction: 0.8,
              enlargeCenterPage: true,
              enlargeFactor: 0.3,
            )
        ),
        SizedBox(height: 20,),

        Padding(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment:  CrossAxisAlignment.start,
            children: [
              Text('Categories',style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),),
              SizedBox(height: 20,),

              Container(
                height: 120,
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context,index)=>buildCategoryItem(categoriesModel.data!.categoriesData![index],context),
                      separatorBuilder: (context,index)=>SizedBox(width: 10,),
                      itemCount:categoriesModel!.data!.categoriesData!.length)),
              SizedBox(height: 15,),

              Text('New Products',style: TextStyle(fontSize:  26,fontWeight: FontWeight.bold),),
            ],
          ),
        ),
        SizedBox(height: 10,),

        Container(
          color: Colors.grey[300],
          child: GridView.count(
            childAspectRatio: 1/1.6,
            mainAxisSpacing: 1,
            crossAxisSpacing: 1,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 2,
            children:List.generate(model.data!.products!.length, (index) =>buildGridProduct(model.data!.products![index],context))
            // model.data!.products!.map((index) =>
            //     buildGridProduct(index)).toList(),
          ),
        ),

      ],
    ),
  );
  Widget buildCategoryItem(DataModel cmodel,context)=>Stack(
       alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image(image: NetworkImage('${cmodel.image}'),height: 120,width: 120,fit: BoxFit.cover,),
          Container(
            alignment: AlignmentDirectional.center,
            width: 120,height: 20,

              color: Colors.black.withOpacity(0.8),
               child: Padding(
                 padding: const EdgeInsetsDirectional.symmetric(horizontal: 5),
                 child: Text('${cmodel.name}',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),maxLines: 1,overflow: TextOverflow.ellipsis,),
               ))
    ],
  );

  Widget buildGridProduct(ProductData model,context)=>Container(color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Stack(alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage('${model.image}'),
              width: double.infinity,
              height: 200,
            ),
            if(model.discount!=0) Container(
              color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text('DISCOUNT',style: TextStyle(fontSize: 8,color: Colors.white),),
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${model.name}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),),
              Row(
                children: [
                  Text('${model.price.round()}',style: TextStyle(color: primaryColor,fontSize: 14),),
                  SizedBox(width: 10,),
                  Text(model.discount!=0?'${model.old_price.round()}':'',style: TextStyle(color: Colors.grey,decoration: TextDecoration.lineThrough,fontSize: 12),
                  ),
                  Spacer(),
                  IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: (){
                         ShopCubit.get(context).ChangeFavourite(model.id!);
                         print(model.id);

                      },
                      icon: ShopCubit.get(context).favourite[model.id]!?Icon(Icons.favorite,size: 17 ,):Icon(Icons.favorite_border_outlined,size: 17 ,)
                  )

                ],
              ),
            ],
          ),
        )
      ],
    ),
  );
}
