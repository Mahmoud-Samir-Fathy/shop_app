



import 'package:shop_app/models/shop_login_model/shop_changefavourite_model.dart';
import 'package:shop_app/models/shop_login_model/shop_favourite_model.dart';
import 'package:shop_app/models/shop_login_model/shop_home_model.dart';
import 'package:shop_app/models/shop_login_model/shop_login_model.dart';

import '../../models/shop_login_model/shop_categories_model.dart';

abstract class ShopStates{}

class ShopInitialState extends ShopStates{}

class ShopChangeBottomNavBar extends ShopStates{}
class ShopLoadingHomeDataState extends ShopStates{}
class ShopSuccessHomeDataState extends ShopStates{
  final HomeModel homeModel;

  ShopSuccessHomeDataState(this.homeModel);
}
class ShopErrorHomeDataState extends ShopStates{
  final String error;

  ShopErrorHomeDataState(this.error);
}
class ShopSuccessCategoriesDataState extends ShopStates{
  final CategoriesModel categoriesModel;

  ShopSuccessCategoriesDataState(this.categoriesModel);


}
class ShopErrorCategoriesDataState extends ShopStates{
  final String error;

  ShopErrorCategoriesDataState(this.error);
}
class ShopChangeFavIconState extends ShopStates{}
class ShopSuccessChangeFavouriteState extends ShopStates{
 final FavouriteModel favouriteModel;

  ShopSuccessChangeFavouriteState(this.favouriteModel);
}
class ShopErrorChangeFavouriteState extends ShopStates{
  final String error;

  ShopErrorChangeFavouriteState(this.error);
}
class ShopSuccessFavDataState extends ShopStates{
final FavModel favModel;

ShopSuccessFavDataState(this.favModel);


}
class ShopErrorFavDataState extends ShopStates{
  final String error;

  ShopErrorFavDataState(this.error);
}

class ShopFavLoadingState extends ShopStates{}

class ShopLoadingGetUserDataState extends ShopStates{}
class ShopSuccessGetUserDataState extends ShopStates{
  final ShopLoginModel userModel;

  ShopSuccessGetUserDataState(this.userModel);
}
class ShopErrorGetUserDataState extends ShopStates{
  final String error;

  ShopErrorGetUserDataState(this.error);
}
class ShopLoadingUpDateUserDataState extends ShopStates{}
class ShopSuccessUpDateUserDataState extends ShopStates{
  final ShopLoginModel userModel;

  ShopSuccessUpDateUserDataState(this.userModel);
}
class ShopErrorUpDateUserDataState extends ShopStates{
  final String error;

  ShopErrorUpDateUserDataState(this.error);
}