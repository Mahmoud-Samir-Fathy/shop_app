import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cashe_helper.dart';
import 'package:shop_app/shop_pages/shop_login_screen/login_screen.dart';


void signout(context){

    CacheHelper.removeData(key: 'token').then((value) {
      if(value) {
        navigateAndFinish(context, ShopLoginScreen());
      };
  });
}

void printFullText(String text){
  final pattern=RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match)=> print(match.group(0)));
}
String? token;