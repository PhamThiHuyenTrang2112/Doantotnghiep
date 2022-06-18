
import 'package:doan6/controller/cart_controller.dart';
import 'package:doan6/routes/route_hepper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../widgets/home_button.dart';


class ThankYouPage extends StatefulWidget {
  const ThankYouPage({Key? key, required this.title}) : super(key: key);

  final String title;


  @override
  State<ThankYouPage> createState() => _ThankYouPageState();
}

Color themeColor = const Color(0xFF43D19E);

class _ThankYouPageState extends State<ThankYouPage> {
  int totalmoney=0;
  double screenWidth = 600;
  double screenHeight = 400;
  Color textColor = const Color(0xFF32567A);

  @override
  void initState() {
    super.initState();
    totalmoney=Get.arguments as int;

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.find<CartController>().clean();
  }

  @override
  Widget build(BuildContext context) {

    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return GetBuilder<CartController>(builder: (cartcontroller){
      return  Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 170,
                padding: EdgeInsets.all(35),
                decoration: BoxDecoration(
                  color: themeColor,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  "assets/image/card.png",
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: screenHeight * 0.1),
              Text(
                "Cảm ơn!",
                style: TextStyle(
                  color: themeColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 36,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Column(
                children: [
                  const Text(
                    "Bạn đặt hàng thành công",
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w400,
                      fontSize: 17,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("Tổng tiền đơn hàng của bạn : ${formatPrice(totalmoney.toString())} đ",
                      style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                  ),
                  const Text("Vui lòng thanh toán khi nhận hàng!")
                ],
              ),
              SizedBox(height: screenHeight * 0.05),
              Text(
                "Bạn nhấn vào đây để về trang chủ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: screenHeight * 0.06),
              Flexible(
                child: HomeButton(
                  title: 'Trang chủ',
                  onTap: () {
                    Get.offNamed(RouteHelper.getInitial());
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
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