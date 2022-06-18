

import 'package:doan6/controller/cart_controller.dart';
import 'package:doan6/controller/popular_controller.dart';
import 'package:doan6/models/product.dart';
import 'package:doan6/pages/cart/page_cart.dart';
import 'package:doan6/routes/route_hepper.dart';
import 'package:doan6/utils/constants.dart';
import 'package:get/get.dart';
import 'package:doan6/pages/home/main_food_page.dart';
import 'package:doan6/utils/color.dart';
import 'package:doan6/utils/dimensions.dart';
import 'package:doan6/widgets/big_text.dart';
import 'package:doan6/widgets/colum.dart';
import 'package:doan6/widgets/exandable_text.dart';
import 'package:doan6/widgets/icon.dart';
import 'package:doan6/widgets/icon_and_text.dart';
import 'package:doan6/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FoodDetail extends StatelessWidget {
  int idfood;
  String page;
   FoodDetail({Key? key,required this.idfood,required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var products=Get.find<PopularController>().popularList;
    Products productid=Products();
    for(var a in products){
      if(idfood==a.id){
        productid=a;
      }
    }

    //var productid=Get.find<PopularController>().popularList[idfood];
    Get.find<PopularController>().initProduct(productid,Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(// trong stack có position
        children: [
          // định vị các mục hoặc tiện ích trên màn hình lên nhau
          // background ảnh
          Positioned(
            left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimensions.foodImagesize,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,// bao phủ toàn bộ
                    image: NetworkImage(
                      AppConstants.BASE_URL+AppConstants.UPLOAD_URL+productid.img!
                    )
                  )
                ),

          )),
          // icon widgets
          Positioned(
            top: Dimensions.height45,
            left: Dimensions.widtht20,
              right:Dimensions.widtht20 ,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap:(){
                      if(page=='cartpage'){
                        Get.toNamed(RouteHelper.getCartpage());
                      }else{
                        //Get.toNamed(RouteHelper.getInitial());
                        Get.back();
                      }
                      },
                      child: const AppIcon(icon: Icons.arrow_back_ios)),
                  GetBuilder<PopularController>(builder: (controller){
                    return GestureDetector(
                      onTap:(){
                        if(controller.totalItem>=1)
                          Get.toNamed(RouteHelper.getCartpage());
                      },
                      child: Stack(
                        children: [
                          AppIcon(icon: Icons.shopping_cart_outlined),
                          controller.totalItem>=1?
                          Positioned(
                            right:0,top:0,

                              child: AppIcon(icon: Icons.circle,
                                size: 20,iconcolor: Colors.transparent,
                                backgroundcolor: AppColors.mainColor,),

                          ):
                          Container(),
                          Get.find<PopularController>().totalItem>=1?
                          Positioned(
                              right:3,top:3,
                              child: BigText(text: Get.find<PopularController>().totalItem.toString(),
                                size: 12,color:Colors.white ,
                              )
                          ):
                          Container(),
                        ],
                      ),
                    );
                  })
                ],

          )
          ),
          // giới thiệu sản phẩm
          Positioned(
            left: 0,
              right: 0,
              bottom: 0,
              top: Dimensions.foodImagesize-20,
              child: Container(
                 padding: EdgeInsets.only(left: Dimensions.widtht20,right: Dimensions.widtht20,top: Dimensions.height20),

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimensions.radius20),
                    topLeft: Radius.circular(Dimensions.radius20),
                  ),
                  color: Colors.white,


                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ColumWidget(text: productid.name!,idfood: productid.id!,),
                    SizedBox(height: Dimensions.height20,),
                    BigText(text:" ${formatPrice(productid.price!.toString())}đ",size: Dimensions.font26,color: Colors.deepOrange,),
                    SizedBox(height: Dimensions.height20,),
                    BigText(text: 'Giới thiệu'),
                    SizedBox(height: Dimensions.height30,),
                    Expanded(
                      child: SingleChildScrollView(
                        child: ExandableText(text: productid.description!),
                      ),
                    )
                  ],
                )
          ))

        ],
      ),
      bottomNavigationBar: GetBuilder<PopularController>(builder: (popularproduct){
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
            child:Row(
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
                      BigText(text: 'Số lượng:',),
                      GestureDetector(
                          onTap: (){
                            popularproduct.setQuantity(false);
                          },
                          child: Icon(Icons.remove,color: AppColors.signColor,size: 16,)),
                      SizedBox(width: Dimensions.width10/2,),
                      BigText(text: popularproduct.inCaritems.toString()),
                      SizedBox(width: Dimensions.width10/2,),
                      GestureDetector(
                          onTap: (){
                            popularproduct.setQuantity(true);

                          },
                          child: Icon(Icons.add,color: AppColors.signColor,size: 16,)),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    popularproduct.addItem(productid);
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: Dimensions.height20,bottom: Dimensions.height20,right: Dimensions.widtht20,left: Dimensions.widtht20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                        color: AppColors.mainColor
                    ),
                    //
                        child: BigText(text: " ${formatPrice(productid.price!.toString())}đ"+"| Mua",),

                  ),
                ),
              ],
            )
        );
      },),
    );
  }
  String formatPrice(String price){
    int dem=0;
    String a="";
    for(int i=price.length-1;i>=0;i--){
        a+=price[i];
        dem++;
        if(dem==3&& i!=0){
          a+=".";
          dem=0;
        }
    }
    price="";
    for(int i=a.length-1;i>=0;i--){
      price+=a[i];
    }
    return price;
  }
}
