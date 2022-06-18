import 'package:doan6/controller/all_produce_controller.dart';
import 'package:doan6/controller/cart_controller.dart';
import 'package:doan6/controller/heart_product_controller.dart';
import 'package:doan6/controller/location_controller.dart';
import 'package:doan6/controller/login_controller.dart';
import 'package:doan6/controller/popular_controller.dart';
import 'package:doan6/controller/recommended_controller.dart';
import 'package:doan6/controller/user_controller.dart';
import 'package:doan6/data/api/api_client.dart';
import 'package:doan6/data/repository/cart.dart';
import 'package:doan6/data/repository/heart_food_repo.dart';
import 'package:doan6/data/repository/location_repo.dart';
import 'package:doan6/data/repository/login_repo.dart';
import 'package:doan6/data/repository/popular_product.dart';
import 'package:doan6/data/repository/recommened_product.dart';
import 'package:doan6/data/repository/user_repo.dart';
import 'package:doan6/utils/constants.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/order_controller.dart';
import '../data/repository/all_produce_repo.dart';
import '../data/repository/order_respon.dart';
Future<void> init()async {
  final sharedPreferences=await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);
  //api client
  Get.lazyPut(()=>ApiClient(appbaseUrl: AppConstants.BASE_URL,sharedPreferences: Get.find()));
  Get.lazyPut(() => LoginRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => UserRepo(apiClient: Get.find()));
  // repos
  Get.lazyPut(() => PopularProduce(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProduce(apiClient: Get.find()));
  Get.lazyPut(() => AllProduceRepo(apiClient: Get.find()));
  Get.lazyPut(() => Cart(sharedPreferences:Get.find()));
  Get.lazyPut(()=>HeartFoodRefo(sharedPreferences: Get.find()));
  //Get.lazyPut(()=>HeartProduceController(heartFoodRefo: heartFoodRefo))
  Get.lazyPut(() => LocationRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => OrderRepo(apiClient: Get.find()));



  //controllers
  Get.lazyPut(() => LoginController(loginRepo: Get.find()));
  Get.lazyPut(() => UserController(userRepo: Get.find()));
  Get.lazyPut(() => AllProduceController(allProduceRepo: Get.find()));
  Get.lazyPut(() => PopularController(popularProduce: Get.find()));
  Get.lazyPut(()=> HeartProduceController(heartFoodRefo: Get.find()));
  Get.lazyPut(() => RecommendedController(recommendedProduce: Get.find()));
  Get.lazyPut(() => CartController(cart: Get.find()));
  Get.lazyPut(() => LocationController(locationRepo:Get.find()));
  Get.lazyPut(()=>OrderController(orderRepo:Get.find()));
}