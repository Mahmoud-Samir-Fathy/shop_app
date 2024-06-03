import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shop_layout/shop_app/shop_app_layout.dart';
import 'package:shop_app/shop_layout/shop_app/shop_cubit.dart';
import 'package:shop_app/shop_pages/shop_login_screen/login_screen.dart';
import 'shared/bloc_observer/bloc_observer.dart';
import 'shared/network/local/cashe_helper.dart';
import 'shared/styles/themes.dart';
import 'shop_pages/on_boarding/on_boarding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await DioHelper.init();
  await CacheHelper.init();

  bool? onBoarding = CacheHelper.getData(key: 'OnBoarding');
  token = CacheHelper.getData(key: 'token') ?? null;
  print(token);

  Widget widget;
  if (onBoarding != null) {
    if (token != null) {
      widget = Shop_App_layout();
    } else {
      widget = ShopLoginScreen();
    }
  } else {
    widget = On_BoardingScreen();
  }

  runApp(Myapp(startWidget: widget));
}

class Myapp extends StatelessWidget {
  final Widget startWidget;

  Myapp({required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ShopCubit>(
          create: (BuildContext context) => ShopCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightMode,
        darkTheme: darkMode,
        home: startWidget,
      ),
    );
  }
}
