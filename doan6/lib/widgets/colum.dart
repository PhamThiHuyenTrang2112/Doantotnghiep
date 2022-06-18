import 'dart:ffi';

import 'package:doan6/controller/popular_controller.dart';
import 'package:doan6/utils/color.dart';
import 'package:doan6/utils/dimensions.dart';
import 'package:doan6/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get.dart';
import '../models/product.dart';
import 'big_text.dart';
import 'icon_and_text.dart';

class ColumWidget extends StatelessWidget {
  final String text;
  int idfood;

  ColumWidget({Key? key, required this.text, required this.idfood})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var products = Get.find<PopularController>().popularList;
    Products productid = Products();
    for (var a in products) {
      if (idfood == a.id) {
        productid = a;
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(
          text: text,
          size: Dimensions.font26,
        ),
        SizedBox(
          height: Dimensions.height10,
        ),
        SizedBox(
          height: Dimensions.height10,
        ),
        Row(
          children: [

            RatingBarIndicator(
              rating:  4.5,
              itemSize: 18,

              itemBuilder: (_,__){
                  return  const Icon(
                                  Icons.star,
                                  color: Colors.amberAccent,
                                );
              },
            ),
            SizedBox(
              width: 10,
            ),
            SmallText(text: productid.stars!.toString()),
            SizedBox(
              width: 10,
            ),
            SmallText(text: '1287'),
            SizedBox(
              width: 10,
            ),
            SmallText(text: 'Bình luận')
          ],
        ),
        SizedBox(
          height: Dimensions.height20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconAndText(
                icon: Icons.circle_sharp,
                text: 'Nomal',
                iconColor: AppColors.iconColor1),
            IconAndText(
                icon: Icons.location_on,
                text: '1.7km',
                iconColor: AppColors.mainColor),
            IconAndText(
                icon: Icons.access_time_rounded,
                text: '32min',
                iconColor: AppColors.iconColor2)
          ],
        )
      ],
    );
  }
}
