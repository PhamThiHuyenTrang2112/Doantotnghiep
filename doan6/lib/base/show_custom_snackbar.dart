import 'package:doan6/widgets/big_text.dart';
import 'package:doan6/widgets/colum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
void ShowCustomSnackbar(String message,{bool isError=true,String title="Errors"}){
  Get.snackbar(title, message,
    titleText: BigText(text: title,color: Colors.white,),
    messageText: Text(message,style: TextStyle(color: Colors.white),

    ),
    colorText: Colors.white,
    snackPosition: SnackPosition.TOP,
    backgroundColor: Colors.redAccent,



  );

}