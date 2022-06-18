
import 'package:doan6/controller/all_produce_controller.dart';
import 'package:doan6/controller/popular_controller.dart';
import 'package:doan6/controller/recommended_controller.dart';
import 'package:doan6/pages/home/search_page.dart';
import 'package:doan6/routes/route_hepper.dart';
import 'package:doan6/utils/color.dart';
import 'package:doan6/utils/dimensions.dart';
import 'package:doan6/widgets/big_text.dart';
import 'package:doan6/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/login_controller.dart';
import '../../controller/user_controller.dart';
import 'food_page_body.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  _MainFoodPageState createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  Future<void> _LoadResource() async{
    await Get.find<PopularController>().getPopularProduceList();
    await Get.find<RecommendedController>().getRecommendedProduceList();
  }
  @override
  Widget build(BuildContext context) {
    bool _userlogin=Get.find<LoginController>().userLogin();
    if(_userlogin) {
      Get.find<UserController>().getUserInfo();
      //Get.find<LocationController>.
      print("Người dùng đã đăng nhập");
    }
    return GetBuilder<UserController>(builder:(_usercontroller){
      return RefreshIndicator(child: Column(
        children: [
          //show the header
          Container(
            child: Container(
              margin: EdgeInsets.only(top: Dimensions.height45,bottom: Dimensions.height15),
              padding: EdgeInsets.only(left: Dimensions.widtht30,right: Dimensions.widtht20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      _usercontroller.usermodel?.name == null ? Image.asset("assets/image/logo3.png",width: 70,height: 80,):
                      Column(
                        children: [
                          // BigText(text: "Xin chào"),
                          // BigText(text: _usercontroller.usermodel!.name,color: Colors.black54,),
                          Image.asset("assets/image/logo4.jpg",width: 80,height: 50,),
                          BigText(text: _usercontroller.usermodel!.name,color: Colors.black54,),
                        ],
                      ),
                    ],
                  ),
                  Center(
                    child: Container(
                      width: Dimensions.height45,
                      height: Dimensions.height45,
                      child: IconButton(icon: Icon(Icons.search,color: Colors.white,size: Dimensions.iconSize24,),
                        onPressed: (){
                          Get.toNamed(RouteHelper.getsearch());
                        },
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius15),
                        color: AppColors.mainColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          // show the body
          Expanded(
              child: SingleChildScrollView(
                  child: FoodPageBody())),
        ],
      ), onRefresh: _LoadResource);
    });
  }
}
