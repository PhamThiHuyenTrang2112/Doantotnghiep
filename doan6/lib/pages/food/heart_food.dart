
import 'package:doan6/base/empty_page.dart';
import 'package:doan6/controller/heart_product_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../controller/cart_controller.dart';
import 'package:get/get.dart';

import '../../routes/route_hepper.dart';
import '../../utils/color.dart';
import '../../utils/constants.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';

class HeartFood extends StatelessWidget {
  const HeartFood({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //var getCartHistory=Get.find<HeartProduceController>().getHeartList().reversed.toList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        automaticallyImplyLeading: false,
        title: const Center(child: Text("Món ăn yêu thích",style: TextStyle(color: Colors.white,fontSize: 20),)),
      ),
      body: GetBuilder<HeartProduceController>(builder: (_heartcontroll){
        return _heartcontroll.getItemsHeart.length>0? Container(
          margin: EdgeInsets.only(top: Dimensions.height20,
            left: Dimensions.widtht20,
            right: Dimensions.widtht20,
            bottom: 0,),
          child: GetBuilder<HeartProduceController>(builder: (cartController){
            var _Listcart=cartController.getItemsHeart;
            //print(cartController.getHeartList());
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
                            Get.toNamed(RouteHelper.getRecommentfood(cartController.getItemsHeart[index].id!,"recommend"));
                          },
                          child: Container(
                            width: Dimensions.height20*5,
                            height:Dimensions.height20*5,
                            margin: EdgeInsets.only(bottom: Dimensions.height10,),
                            decoration: BoxDecoration(
                                image:DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        AppConstants.BASE_URL+AppConstants.UPLOAD_URL+cartController.getItemsHeart[index].img!
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
                                children: [
                                  BigText(text: cartController.getItemsHeart[index].name!,color: Colors.black54,),
                                  const SizedBox(height: 5),
                                  SmallText(text: cartController.getItemsHeart[index].location!),
                                  const SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      BigText(text: "${formatPrice(cartController.getItemsHeart[index].price.toString())}đ",color: Colors.redAccent,),

                                    ],
                                  )

                                ],
                              ),
                            ))
                      ],
                    ),
                  );

                });
          }),
        ):const Center(child: Text( "Bạn hãy đặt đồ ăn để trải nghiệm!",style: TextStyle(fontSize: 20),));
      })
    );
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
