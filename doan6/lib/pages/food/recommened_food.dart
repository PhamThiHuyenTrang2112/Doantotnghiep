
import 'package:doan6/controller/cart_controller.dart';
import 'package:doan6/controller/heart_product_controller.dart';
import 'package:doan6/controller/popular_controller.dart';
import 'package:doan6/controller/recommended_controller.dart';
import 'package:doan6/pages/cart/page_cart.dart';
import 'package:doan6/routes/route_hepper.dart';
import 'package:doan6/utils/color.dart';
import 'package:doan6/utils/constants.dart';
import 'package:doan6/utils/dimensions.dart';
import 'package:doan6/widgets/big_text.dart';
import 'package:doan6/widgets/exandable_text.dart';
import 'package:doan6/widgets/icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/product.dart';

class RecommenedFood extends StatefulWidget {
  final int idfood;
  String page;

   RecommenedFood({Key? key, required this.idfood,required this.page}) : super(key: key);

  @override
  State<RecommenedFood> createState() => _RecommenedFoodState();
}

class _RecommenedFoodState extends State<RecommenedFood> {
  bool changecolor=false;
  @override
  Widget build(BuildContext context) {
    var products=Get.find<RecommendedController>().recommendedList;
    Products productid=Products();
    for(var a in products){
      if(widget.idfood==a.id){
        productid=a;
      }
    }
    changecolor=Get.find<HeartProduceController>().checkHeart(productid);
  // var productid=Get.find<RecommendedController>().recommendedList[idfood];
    Get.find<PopularController>().initProduct(productid,Get.find<CartController>());
    Get.find<PopularController>().initProductHeart(productid,Get.find<HeartProduceController>());
    return Scaffold(
      backgroundColor: Colors.white,

      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,   // xóa đi icon quay về mặc định
            toolbarHeight: 60,// chiều cao thanh công cụ
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap:(){
                    if(widget.page=="recommend"){
                      Get.toNamed(RouteHelper.getInitial());
                    }else{
                      //Get.toNamed(RouteHelper.getCartpage());
                      Get.back();
                    }
                  },
                    child: AppIcon(icon: Icons.close)),
                //AppIcon(icon: Icons.shopping_cart_outlined),
                GetBuilder<PopularController>(builder: (controller){
                  return GestureDetector(
                    onTap: (){
                      if(controller.totalItem>=1)
                      Get.toNamed(RouteHelper.getCartpage());
                    },
                    child: Stack(
                      children: [
                        AppIcon(icon: Icons.shopping_cart_outlined),
                        Get.find<PopularController>().totalItem>=1?
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
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                  child: Center(child: BigText(size:Dimensions.font26,text: productid.name!,)),
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 5,bottom: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20),
                    topRight: Radius.circular(Dimensions.radius20),
                  )
                ),
              ),
            ),
            pinned: true,// ghim
            backgroundColor: Colors.orangeAccent,
            expandedHeight: 300,

            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(AppConstants.BASE_URL+AppConstants.UPLOAD_URL+productid.img!,
                width: double.maxFinite,
                fit: BoxFit.cover,),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin:EdgeInsets.only(left: Dimensions.widtht20,right: Dimensions.widtht20),
                  child: ExandableText(text: productid.description!),
                )
              ],

            ),
          )
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularController>(builder: (controller){
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(left: Dimensions.widtht20*2.5,right:Dimensions.widtht20*2.5,top: Dimensions.height10,bottom: Dimensions.height10 ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      controller.setQuantity(false);
                    },
                    child: AppIcon(icon: Icons.remove,iconcolor: Colors.deepOrangeAccent,iconsize: Dimensions.iconSize24),
                  ),
                  BigText(text: " ${formatPrice(productid.price.toString())}đ x${controller.inCaritems}",color: AppColors.mainBlackColor,size: Dimensions.font26,),
                  GestureDetector(
                    onTap: (){
                      controller.setQuantity(true);
                    },
                    child: AppIcon(icon: Icons.add,iconcolor: Colors.deepOrangeAccent,iconsize: Dimensions.iconSize24),
                  )
                ],
              ),
            ),
            Container(
                height: Dimensions.BottomBar,
                padding: EdgeInsets.only(top: Dimensions.height30,bottom: Dimensions.height30,left: Dimensions.widtht20,right: Dimensions.widtht20),
                decoration: BoxDecoration(
                  //color: AppColors.buttonBackgroundColor,
                    color: Colors.deepOrangeAccent,
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
                      child: IconButton(
                        icon: Icon(Icons.favorite,color:changecolor ? Colors.red:Colors.grey ,),
                        onPressed: (){
                          changecolor=!changecolor;
                           setState(() {
                             if(changecolor){
                          controller.addItemHeart(productid);
                           Get.snackbar("Thông báo", "Bạn đã yêu thích sản phẩm!",
                              backgroundColor: AppColors.mainColor,
                               colorText: Colors.white);
                           }else{
                               controller.removeHeart(productid);
                             Get.snackbar("Thông báo", "Bạn đã không yêu thích sản phẩm!",
                                 backgroundColor: AppColors.mainColor,
                                 colorText: Colors.white);
                           }
                          });
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        controller.addItem(productid);
                      },
                      child: Container(
                        padding: EdgeInsets.only(top: Dimensions.height20,bottom: Dimensions.height20,right: Dimensions.widtht20,left: Dimensions.widtht20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.radius20),
                            color: AppColors.mainColor
                        ),
                        //
                        child: BigText(text: 'Mua ngay',),

                      ),
                    )
                  ],
                )
            ),
          ],
        );
      },)
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
