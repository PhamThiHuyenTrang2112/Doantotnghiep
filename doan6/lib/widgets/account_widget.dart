

import 'package:doan6/utils/dimensions.dart';
import 'package:doan6/widgets/big_text.dart';
import 'package:doan6/widgets/icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountWidget extends StatelessWidget {
  AppIcon appIcon;
  BigText bigText;
   AccountWidget({Key? key ,required this.appIcon,required this.bigText}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(

      padding: EdgeInsets.only(left: Dimensions.widtht20,top: Dimensions.width10,bottom: Dimensions.width10
      ),
      child: Row(
        children: [
          appIcon,
          SizedBox(width: Dimensions.widtht20,),
          bigText
        ],
      ),
      decoration: BoxDecoration(
        color:  Colors.white,
        boxShadow: [
          BoxShadow(// hộp bóng
        blurRadius: 1,
            offset: Offset(0,2),
            color: Colors.grey.withOpacity(0.2),



          )
        ]
      ),
    );
  }
}
