
import 'dart:convert';

import 'package:doan6/base/empty_page.dart';
import 'package:doan6/controller/cart_controller.dart';
import 'package:doan6/models/cart_model.dart';
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
import 'package:intl/intl.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getCartHistory=Get.find<CartController>().getcartHistoryList().reversed.toList();
    Map<String,int> cartItemsPerOder=Map();

    for(int i=0;i<getCartHistory.length;i++){
      if(cartItemsPerOder.containsKey(getCartHistory[i].time)){
        cartItemsPerOder.update(getCartHistory[i].time!, (value) => ++value);
      }else{
        cartItemsPerOder.putIfAbsent(getCartHistory[i].time!, () => 1);
      }
    }

    List<int> cartItemOrdertoList(){
      return cartItemsPerOder.entries.map((e) => e.value).toList();
    }
    List<String> cartOrdertimetoList(){
      return cartItemsPerOder.entries.map((e) => e.key).toList();
    }

    List<int> itemPerOder=cartItemOrdertoList();
    var listCount=0;
    Widget timeWidget(int index){
      var outputdate=DateTime.now().toString();
      if(index<getCartHistory.length){
        DateTime parsetime= DateFormat("yyyy-MM-dd HH:mm:ss").parse(getCartHistory[listCount].time!);
        var inputdate=DateTime.parse(parsetime.toString());
        var outputFormat=DateFormat("MM/dd/yyyy hh:mm a");
         outputdate=outputFormat.format(inputdate);

      }
      return BigText(text:outputdate);
    }
    return Scaffold(

      body: Column(
        children: [
          Container(
            height: Dimensions.height10*10,
            color: AppColors.mainColor,
            width: double.maxFinite,
            padding: EdgeInsets.only(top: Dimensions.height45),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(
                  text: 'Lịch sử đặt hàng',
                  color: Colors.white,
                ),
                AppIcon(icon: Icons.shopping_cart_outlined,iconcolor: AppColors.mainColor,)
              ],
            ),
          ),
          GetBuilder<CartController>(builder: (_cartController){
            return _cartController.getcartHistoryList().length>0?Expanded(child: Container(
                margin: EdgeInsets.only(top: Dimensions.height20,left: Dimensions.widtht20,right: Dimensions.widtht20),
                child: MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: ListView(
                    children: [
                      for(int i=0;i<itemPerOder.length;i++)
                        Container(
                          height: Dimensions.height30*5,
                          margin: EdgeInsets.only(bottom: Dimensions.height20),
                          child: Column(
                            crossAxisAlignment:CrossAxisAlignment.start ,
                            children: [
                             timeWidget(listCount),
                              SizedBox(height: Dimensions.width10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Wrap(
                                      direction: Axis.horizontal,
                                      children:List.generate(itemPerOder[i], (index) {
                                        if(listCount<getCartHistory.length){
                                          listCount++;
                                        }
                                        return index<=2?Container(
                                          width: Dimensions.height20*4,
                                          height: Dimensions.height20*4,
                                          margin: EdgeInsets.only(right: Dimensions.width10/2),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(Dimensions.radius15/2),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      AppConstants.BASE_URL+AppConstants.UPLOAD_URL+getCartHistory[listCount-1].img!
                                                  )
                                              )
                                          ),
                                        ):Container();
                                      })
                                  ),
                                  Container(height: Dimensions.height20*4,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [

                                        SmallText(text: "Tổng"),
                                        BigText(text: itemPerOder[i].toString()+" Món"),
                                        GestureDetector(
                                          onTap:(){
                                            var orderTime=cartOrdertimetoList();
                                            Map<int, CartModel> moreOder={};
                                            for(int j=0;j<getCartHistory.length;j++){
                                              if(getCartHistory[j].time==orderTime[i]){
                                                moreOder.putIfAbsent(getCartHistory[j].id!, () =>
                                                    CartModel.fromJson(jsonDecode(jsonEncode(getCartHistory[j])))
                                                );
                                              }
                                            }
                                            Get.find<CartController>().setItem=moreOder;
                                            Get.find<CartController>().addtocartList();
                                            Get.toNamed(RouteHelper.getCartpage());
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: Dimensions.width10,vertical: Dimensions.height10/5),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(Dimensions.radius15/2),
                                                border: Border.all(width: 1,color: AppColors.mainColor)
                                            ),
                                            child: SmallText(text:"nhiều hơn một",color: AppColors.mainColor, ),
                                          ),
                                        )
                                      ],),
                                  )

                                ],
                              )
                            ],
                          ),

                        )


                    ],
                  ),
                ),
              ),
            ):
            Container(
              height: MediaQuery.of(context).size.height/1.5,
                child:const Center(child: EmptyPage(text: "Bạn không đặt món đồ nào gần đây!",imgPath: "assets/image/empty.png",)));
          })
        ],
      ),
    );
  }
}
