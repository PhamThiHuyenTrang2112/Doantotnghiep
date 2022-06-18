import 'package:doan6/controller/cart_controller.dart';
import 'package:doan6/controller/heart_product_controller.dart';
import 'package:doan6/controller/popular_controller.dart';
import 'package:doan6/pages/food/popular_food_detail.dart';
import 'package:doan6/pages/food/recommened_food.dart';
import 'package:doan6/pages/home/food_page_body.dart';
import 'package:doan6/pages/login/sign_in_page.dart';
import 'package:doan6/pages/login/sign_up_page.dart';
import 'package:doan6/pages/welcome/welcome.dart';
import 'package:doan6/routes/route_hepper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/recommended_controller.dart';
import 'pages/home/main_food_page.dart';
import 'helper/dependencies.dart' as dep;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //Get.find<PopularController>().getPopularProduceList();
    //Get.find<RecommendedController>().getRecommendedProduceList();
    Get.find<HeartProduceController>().getHeartdata();
    Get.find<CartController>().getCartdata();
    return GetBuilder<PopularController>(builder: (_){
      return GetBuilder<RecommendedController>(builder: (_){
         return  GetMaterialApp(
          title: 'Ung dụng giao đồ ăn',
          debugShowCheckedModeBanner: false,
         // home: SignInPage(),

          //home: Welcome(),
          initialRoute: RouteHelper.getWelcom() ,
         getPages: RouteHelper.routes,
        );
      });

    });

  }
}


