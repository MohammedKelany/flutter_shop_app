import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/shared/constants/constants.dart';
import 'package:shop_app/shared/network/local/catch_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shop_binding.dart';
import 'package:shop_app/themes/Themes.dart';
import 'package:shop_app/view/login_screen.dart';
import 'package:shop_app/view/on_boarding_screen.dart';
import 'package:shop_app/view/shop_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CatchHelper.init();
  DioHelper.init();
  token = CatchHelper.getData(key: 'token');
  bool? onBoarding = CatchHelper.getData(key: 'onBoarding');
  Widget startWidget;
  if (onBoarding != null) {
    if (token != null) {
      startWidget = const ShopLayout();
    } else {
      startWidget = LoginScreen();
    }
  } else {
    startWidget = const OnBoardingScreen();
  }
  runApp(
    MyApp(
      startWidget: startWidget,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.startWidget,
  }) : super(key: key);
  final Widget startWidget;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: startWidget,
      debugShowCheckedModeBanner: false,
      theme: Themes.lightTheme,
      initialBinding: ShopBinding(),
      darkTheme: Themes.darkTheme,
    );
  }
}
