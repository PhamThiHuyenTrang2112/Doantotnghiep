
import 'package:doan6/base/empty_page.dart';
import 'package:doan6/base/show_custom_snackbar.dart';
import 'package:doan6/controller/cart_controller.dart';
import 'package:doan6/controller/location_controller.dart';
import 'package:doan6/controller/login_controller.dart';
import 'package:doan6/controller/popular_controller.dart';
import 'package:doan6/controller/recommended_controller.dart';
import 'package:doan6/pages/home/main_food_page.dart';
import 'package:doan6/routes/route_hepper.dart';
import 'package:doan6/utils/color.dart';
import 'package:doan6/utils/constants.dart';
import 'package:doan6/utils/dimensions.dart';
import 'package:doan6/widgets/big_text.dart';
import 'package:doan6/widgets/icon.dart';
import 'package:doan6/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/order_controller.dart';
import '../../controller/user_controller.dart';
import '../../models/place_order_model.dart';
import '../../widgets/diaglog_loading.dart';

class PageCart extends StatelessWidget {
  var loading=false.obs;
 PageCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _observeScreenState();
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: Dimensions.height45,
              left: Dimensions.widtht20,
              right: Dimensions.widtht20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap:(){
                      Get.back();
                  },
                    child: AppIcon(icon: Icons.arrow_back_ios,iconcolor: Colors.white,backgroundcolor: AppColors.mainColor
                      ,iconsize: Dimensions.iconSize24,),
                  ),
                  SizedBox(width: Dimensions.widtht20*5,),
                  GestureDetector(
                    onTap: (){
                      Get.toNamed(RouteHelper.getInitial());
                    },
                    child: AppIcon(icon: Icons.home_outlined,iconcolor: Colors.white,backgroundcolor: AppColors.mainColor
                      ,iconsize: Dimensions.iconSize24,),
                  ),
                  AppIcon(icon: Icons.shopping_cart_outlined,iconcolor: Colors.white,backgroundcolor: AppColors.mainColor
                    ,iconsize: Dimensions.iconSize24,),

                ],

          )),

          GetBuilder<CartController>(builder: (_cartController){
            return _cartController.getItems.length>0?Positioned(
                top: Dimensions.height20*7,
                left: Dimensions.widtht20,
                right: Dimensions.widtht20,
                bottom: 0,
                child: Container(
                  //margin: EdgeInsets.only(top: Dimensions.height15),
                  //color: Colors.red,
                  child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: GetBuilder<CartController>(builder: (cartController){
                        var _Listcart=cartController.getItems;
                        return ListView.builder(
                            itemCount: _Listcart.length ,
                            itemBuilder: (_,index){
                              return Container(
                                height: Dimensions.height20*5,
                                //height: 100,
                                width: double.maxFinite,
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap:(){
                                        var popular=Get.find<PopularController>().popularList.indexOf(_Listcart[index].product!);
                                        if(popular>=0){
                                          Get.toNamed(RouteHelper.getPopularfood(_Listcart[index].product!.id!,"cartpage"));
                                        }else{
                                          var recomentIndext=Get.find<RecommendedController>().recommendedList.indexOf(_Listcart[index].product!);
                                          if(recomentIndext<0){
                                            Get.snackbar("Trang lịch sử sản phẩm", "Chi tiết sản phẩm không có sẵn cho các sản phẩm ở trang lịch sử",
                                                backgroundColor: AppColors.mainColor,
                                                colorText: Colors.white);

                                          }else{
                                            Get.toNamed(RouteHelper.getRecommentfood(_Listcart[index].product!.id!,"cartpage"));
                                          }

                                        }
                                      },
                                      child: Container(
                                        width: Dimensions.height20*5,
                                        height:Dimensions.height20*5,
                                        margin: EdgeInsets.only(bottom: Dimensions.height10,),
                                        decoration: BoxDecoration(
                                            image:DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    AppConstants.BASE_URL+AppConstants.UPLOAD_URL+cartController.getItems[index].img!
                                                )),
                                            borderRadius: BorderRadius.circular(Dimensions.radius20),
                                            color: Colors.white
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: Dimensions.width10,),
                                    Expanded(
                                        child: Container(
                                          height:Dimensions.height20*5 ,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              BigText(text: cartController.getItems[index].name!,color: Colors.black54,),
                                              SmallText(text: cartController.getItems[index].time!),
                                              Row(

                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  BigText(text: "${formatPrice(cartController.getItems[index].price.toString())}đ",color: Colors.redAccent,),
                                                  Container(
                                                    padding: EdgeInsets.only(top: Dimensions.height10,bottom: Dimensions.height10,right: Dimensions.width10,left: Dimensions.width10),
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                                                        color: Colors.white
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        BigText(text: 'Số lượng:',),
                                                        GestureDetector(
                                                            onTap: (){
                                                              cartController.addItem(_Listcart[index].product!, -1);
                                                            },
                                                            child: Icon(Icons.remove,color: AppColors.signColor,size: 16,)),
                                                        SizedBox(width: Dimensions.width10/2,),
                                                        BigText(text: _Listcart[index].quantity.toString()),//popularproduct.inCaritems.toString()),
                                                        SizedBox(width: Dimensions.width10/2,),
                                                        GestureDetector(
                                                            onTap: (){
                                                              cartController.addItem(_Listcart[index].product!, 1);

                                                            },
                                                            child: Icon(Icons.add,color: AppColors.signColor,size: 16,)),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )

                                            ],
                                          ),
                                        ))
                                  ],
                                ),
                              );

                            });
                      })
                  ),
                )):EmptyPage(text: "Giỏ hàng trống! ");
          })
        ],
      ),
      bottomNavigationBar: GetBuilder<CartController>(builder: (cartcontroller){
        return Container(
            height: Dimensions.BottomBar,
            padding: EdgeInsets.only(top: Dimensions.height30,bottom: Dimensions.height30,left: Dimensions.widtht20,right: Dimensions.widtht20),
            decoration: BoxDecoration(
              //color: AppColors.buttonBackgroundColor,
                color: Colors.redAccent,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20*2),
                    topRight: Radius.circular(Dimensions.radius20*2)
                )
            ),
            child:cartcontroller.getItems.length>0?Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(top: Dimensions.height20,bottom: Dimensions.height20,right: Dimensions.widtht20,left: Dimensions.widtht20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: Colors.white
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: Dimensions.width10/2,),
                      BigText(text: "${formatPrice(cartcontroller.totalMoney.toString())}đ,",),
                      SizedBox(width: Dimensions.width10/2,),

                    ],
                  ),
                ),
                GestureDetector(
                  onTap: (){

                    if (Get.find<LoginController>().userLogin()){
                      if(Get.find<LocationController>().addresslist.isEmpty){
                        Get.toNamed(RouteHelper.getAddress());
                      } else{
                        loading.value=true;
                        var location = Get.find<LocationController>().getUserAddress();
                        var cart = Get.find<CartController>().getItems;
                        var user = Get.find<UserController>().usermodel;
                        PlaceOrderBody placeOrder = PlaceOrderBody(
                            cart: cart,
                            orderAmount: 100.0,
                            orderNote: "About food",
                            address: location.address,
                            longitude: location.longitude,
                            latitude: location.laititude,
                            contactPersonNumber: user!.phone,
                            contactPersonName: user!.name,
                            scheduleAt: '',
                            distance: 10.0
                        );

                        Get.find<OrderController>().placeOrder(placeOrder ,_callback);
                        cartcontroller.addHistory();
                      }
                    } else {
                      Get.toNamed(RouteHelper.getSignin());
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: Dimensions.height20,bottom: Dimensions.height20,right: Dimensions.widtht20,left: Dimensions.widtht20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                        color: AppColors.mainColor
                    ),
                    //
                    child: BigText(text: "Thanh toán",),

                  ),
                ),
              ],

            ):Container()
        );
      },),
    );
  }
  void _callback(bool isSuccess, String message, String orderID){
    if(isSuccess){
      int total=Get.find<CartController>().totalMoney;
      //Get.offNamed(RouteHelper.getPaymentPage(orderID, Get.find<UserController>().usermodel!.id));
      loading.value=false;
      Get.offNamed(RouteHelper.getPay(),arguments: total);
    } else {
      ShowCustomSnackbar(message);
    }
  }
  _observeScreenState() {
    loading.listen((state) {
      if (state) {
        showLoading();
      } else {
        hideLoading();
      }
    });

  }
  String formatPrice(String price) {
    int dem = 0;
    String a = "";
    for (int i = price.length - 1; i >= 0; i--) {
      a += price[i];
      dem++;
      if (dem == 3 && i != 0) {
        a += ".";
        dem = 0;
      }
    }
    price = "";
    for (int i = a.length - 1; i >= 0; i--) {
      price += a[i];
    }
    return price;
  }
}
