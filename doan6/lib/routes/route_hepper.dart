import 'package:doan6/pages/address/add_address.dart';
import 'package:doan6/pages/cart/page_cart.dart';
import 'package:doan6/pages/food/heart_food.dart';
import 'package:doan6/pages/food/popular_food_detail.dart';
import 'package:doan6/pages/food/recommened_food.dart';
import 'package:doan6/pages/home/home_page.dart';
import 'package:doan6/pages/home/main_food_page.dart';
import 'package:doan6/pages/login/sign_in_page.dart';
import 'package:doan6/pages/welcome/welcome.dart';
import 'package:get/get.dart';

import '../models/order_model.dart';
import '../pages/home/search_page.dart';
import '../pages/payment/pay_success.dart';
import '../pages/payment/payment_page.dart';

class RouteHelper{
  static const String welcomePage="/welcome-page";
  static const String initial="/";
  static const String popularFood="/foodpopular";
  static const String recommentFood="/recommentfood";
  static const String cartPage="/cart-page";
  static const String signin="/sign-in";
  static const String addAddress="/add-address";
  static const String search="/search_food";
  static const String heart="/heart_food";
  static const String payment = '/payment';
  static const String paysuccess = '/paymentsucces';


  static String getWelcom()=>'$welcomePage';
  static  String getInitial()=>'$initial';
  static  String getPopularfood(int idfood,String page)=>'$popularFood?idfood=$idfood &page=$page';
  static  String getRecommentfood(idfood,String page)=>'$recommentFood?idfood=$idfood &page=$page';
  static  String getCartpage()=>'$cartPage';
  static  String getSignin()=>'$signin';

  static  String getAddress()=>'$addAddress';
  static  String getsearch()=>'$search';
  static  String getHeart()=>'$heart';
  static String getPaymentPage(String id, int userID) => '$payment?id=$id&userID=$userID';
  static  String getPay()=>'$paysuccess';


  static List<GetPage> routes=[
    GetPage(name: welcomePage, page:()=> Welcome()),
    GetPage(name: initial, page: (){
      return HomePage();
    },transition: Transition.fade),
    GetPage(name: search, page: (){
      return SearchFood();
    },transition: Transition.fade),
    GetPage(name: heart, page: (){
      return const HeartFood();
    }),
    GetPage(name: signin, page: (){
      return SignInPage();
  },transition: Transition.fade ),
    GetPage(name: popularFood, page:(){
      var idfood=Get.parameters['idfood'];
      var page=Get.parameters['page'];
     // print("popular food detail");
      return FoodDetail(idfood: int.parse(idfood!),page:page!);

    },
      transition: Transition.fadeIn
    ),
    GetPage(name: recommentFood, page:(){
      var idfood=Get.parameters['idfood'];
      var page=Get.parameters['page'];
      return RecommenedFood(idfood: int.parse(idfood!),page:page!);
    },
        transition: Transition.fadeIn
    ),
    GetPage(name: cartPage, page: (){
      return PageCart();
    },
        transition: Transition.fadeIn),
    GetPage(name: addAddress, page: (){
      return AddAddressPage();
    }),
    GetPage(name: payment, page: () =>
        PaymentScreen(orderModel:
        OrderModel(
            id: int.parse(Get.parameters['id']!),
            userId: int.parse(Get.parameters['userID']!))
        )),
    GetPage(name: paysuccess, page: (){
      return const ThankYouPage(title: "Cảm ơn");
    }),

  ];
}