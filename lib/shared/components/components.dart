
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:shop_app/shop_layout/shop_app/shop_cubit.dart';


Widget defaultButton({
  double conthight=70,
  double width=double.infinity,
  double radius=5,
  Color color=Colors.blue,
  required String text,
  required Function,
  bool isUpperCase=true,
})=>Container(
  height: conthight,
  width: width,
  child:
  MaterialButton(
    onPressed: Function,
    child: Text(isUpperCase?text.toUpperCase():text,style: TextStyle(color: Colors.white),),
  ),
  decoration: BoxDecoration(borderRadius: BorderRadiusDirectional.circular(radius),
      color: color
  ),
);

Widget defaultTextFormField({
  required TextEditingController? controller,
  required TextInputType? KeyboardType,
  Function(String)? onChanged,
  Function(String)? onSubmit,
  VoidCallback?onTap,
  required String? Function(String?)? validate,
  required String? lable,
  required IconData? prefix,
  bool isPassword = false,
  IconData? suffix,
  Function()? suffixpressed,
})=>TextFormField(
  controller: controller,
  keyboardType: KeyboardType,
  obscureText: isPassword,
  onChanged:onChanged,
  onFieldSubmitted:onSubmit,
  onTap: onTap,
  validator: validate,
  decoration: InputDecoration(
    prefixIcon: Icon(prefix),
    labelText: lable,
    border: OutlineInputBorder(),
    suffixIcon: suffix !=null?IconButton(icon: Icon(suffix),onPressed: suffixpressed,):null,

  ),
);


Widget mySeparator()=>Padding(
  padding: const EdgeInsets.all(15.0),
  child: Container(
    color: Colors.grey,
    height: 1,
    width: double.infinity,
  ),
);


void navigateTo(context,widget){
  Navigator.push(context, MaterialPageRoute(builder: (context)=>widget));
}
void navigateAndFinish(context,widget){
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>widget), (route) => false);
}

void showToast(context,{
  required String title,
  required String description,
  required ToastColorState state,
  required IconData icon,

})=> MotionToast(
  icon: icon,
  title: Text(title),
  description: Text(description,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
  animationType: AnimationType.fromBottom,
  animationCurve: Curves.decelerate,
  primaryColor: chooseToastColor(state),
  dismissable: true,
).show(context);

enum ToastColorState{success,error,warning}

Color chooseToastColor(ToastColorState state){
  Color color;
  switch (state)
  {
    case ToastColorState.success:
       color=Colors.green;
        break;
       case ToastColorState.error:
       color=Colors.red;
       break;
    case ToastColorState.warning:
       color=Colors.amber;
       break;
  }
   return color;
}
Widget buildListProduct(model,context,{bool isOldPrice=true})=>Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120,
    child: Row(
      children: [
        Stack(alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage('${model.image}'),
              width:120,
              height: 120,
            ),
            if(model.discount!=0&& isOldPrice) Container(
              color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text('DISCOUNT',style: TextStyle(fontSize: 8,color: Colors.white),),
              ),
            )
          ],
        ),
        SizedBox(width: 20,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${model.name}',
                //model.name
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),),
              Spacer(),
              Row(
                children: [
                  Text('${model.price.round()}',style: TextStyle(color: primaryColor,fontSize: 14),),
                  SizedBox(width: 10,),
                  Text(model.discount!=0 && isOldPrice?'${model.oldPrice.round()}':'',style: TextStyle(color: Colors.grey,decoration: TextDecoration.lineThrough,fontSize: 12),

                  ),
                  Spacer(),
                  IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: (){
                        ShopCubit.get(context).ChangeFavourite(model.id);
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
  ),
);