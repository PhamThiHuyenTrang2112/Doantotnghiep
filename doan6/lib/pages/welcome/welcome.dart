
import 'dart:async';

import 'package:doan6/controller/popular_controller.dart';
import 'package:doan6/controller/recommended_controller.dart';
import 'package:doan6/routes/route_hepper.dart';
import 'package:doan6/utils/dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> with TickerProviderStateMixin{
  late Animation<double> animation;
  late AnimationController animationController;

  Future<void> _LoadResource() async{
    await Get.find<PopularController>().getPopularProduceList();
    await Get.find<RecommendedController>().getRecommendedProduceList();
  }
  @override
  void initState() {
    // TODO: implement initState
    _LoadResource();
    super.initState();
    animationController= AnimationController(vsync: this,duration:const Duration(seconds: 2))..forward();
    animation= CurvedAnimation(parent: animationController, curve: Curves.linear);
    Timer(const Duration(seconds: 3),()=>Get.offNamed(RouteHelper.getInitial()));
  }
  @override
  dispose() {
    animationController.dispose(); // you need this
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: animation,
              child: Center(child: Image.asset("assets/image/logo.png",width: Dimensions.welcomeImg,))
          ),
          Center(child: Image.asset("assets/image/logo2.png",width: Dimensions.welcomeImg,))

        ],
      ),
    );
  }
}
