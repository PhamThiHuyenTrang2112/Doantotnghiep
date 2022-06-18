
import 'package:doan6/base/custom_loader.dart';
import 'package:doan6/controller/cart_controller.dart';
import 'package:doan6/controller/location_controller.dart';
import 'package:doan6/controller/login_controller.dart';
import 'package:doan6/controller/user_controller.dart';
import 'package:doan6/routes/route_hepper.dart';
import 'package:doan6/utils/color.dart';
import 'package:doan6/utils/dimensions.dart';
import 'package:doan6/widgets/account_widget.dart';
import 'package:doan6/widgets/big_text.dart';
import 'package:doan6/widgets/icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/heart_product_controller.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _userlogin=Get.find<LoginController>().userLogin();
    if(_userlogin){
      Get.find<UserController>().getUserInfo();
      //Get.find<LocationController>.
      print("Người dùng đã đăng nhâp");
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.mainColor,
        title:Center(child: BigText(text: "Hồ sơ người dùng",size: 24,color: Colors.white,)),
      ),
      body: GetBuilder<UserController>(builder:(userController){
        return _userlogin? (userController.isLoading?Container(
          width:  double.maxFinite,
          margin: EdgeInsets.only(top: Dimensions.height20),
          child: Column(
            children: [
              //icon
              AppIcon(icon: Icons.person,backgroundcolor: AppColors.mainColor
                ,iconcolor: Colors.white,
                iconsize: Dimensions.height45+Dimensions.height30,
                size: Dimensions.height15*10,),
              SizedBox(height: Dimensions.height30,),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      //name
                      AccountWidget(appIcon: AppIcon(icon: Icons.person,backgroundcolor: AppColors.mainColor
                        ,iconcolor: Colors.white,
                        iconsize: Dimensions.height10*5/2,
                        size: Dimensions.height10*5,), bigText:BigText(text: userController.usermodel!.name,)),
                      SizedBox(height: Dimensions.height30,),
                      //phone
                      AccountWidget(appIcon: AppIcon(icon: Icons.phone,backgroundcolor: AppColors.yellowColor
                        ,iconcolor: Colors.white,
                        iconsize: Dimensions.height10*5/2,
                        size: Dimensions.height10*5,), bigText:BigText(text: userController.usermodel!.phone,)),
                      SizedBox(height: Dimensions.height30,),
                      //email
                      AccountWidget(appIcon: AppIcon(icon: Icons.email,backgroundcolor: AppColors.yellowColor
                        ,iconcolor: Colors.white,
                        iconsize: Dimensions.height10*5/2,
                        size: Dimensions.height10*5,), bigText:BigText(text: userController.usermodel!.email,)),
                      SizedBox(height: Dimensions.height30,),
                      //addrest
                      GetBuilder<LocationController>(builder: (locationController){
                        if(_userlogin&&locationController.addresslist.isEmpty){
                          return GestureDetector(
                            onTap: (){
                              Get.offNamed(RouteHelper.getAddress());
                            },
                            child: AccountWidget(appIcon: AppIcon(icon: Icons.location_on,backgroundcolor: AppColors.yellowColor
                              ,iconcolor: Colors.white,
                              iconsize: Dimensions.height10*5/2,
                              size: Dimensions.height10*5,), bigText:BigText(text: "Ninh Mỹ, Hoa Lư, Ninh Bình",)),
                          );
                        }else{
                          return GestureDetector(
                            onTap: (){
                              Get.offNamed(RouteHelper.getAddress());
                            },
                            child: AccountWidget(appIcon: AppIcon(icon: Icons.location_on,backgroundcolor: AppColors.yellowColor
                              ,iconcolor: Colors.white,
                              iconsize: Dimensions.height10*5/2,
                              size: Dimensions.height10*5,), bigText:BigText(text: "Địa chỉ",)),
                          );
                        }
                      }),
                      SizedBox(height: Dimensions.height30,),
                      AccountWidget(appIcon: AppIcon(icon: Icons.message_outlined,backgroundcolor: Colors.redAccent
                        ,iconcolor: Colors.white,
                        iconsize: Dimensions.height10*5/2,
                        size: Dimensions.height10*5,), bigText:BigText(text: "Thông báo",)),
                      SizedBox(height: Dimensions.height30,),
                      GestureDetector(
                        onTap: (){
                          if(Get.find<LoginController>().userLogin()){
                            Get.find<LoginController>().cleanShareData();
                            Get.find<CartController>().clean();
                            Get.find<CartController>().cleanCartHistory();
                            Get.find<LocationController>().cleanAddressList();
                            Get.find<HeartProduceController>().cleanHeartList();
                            Get.find<HeartProduceController>().clean();
                            Get.offNamed(RouteHelper.getSignin());
                          }else{
                            print("bạn đăng xuất");
                            Get.offNamed(RouteHelper.getSignin());
                          }

                        },
                        child: AccountWidget(appIcon: AppIcon(icon: Icons.logout,backgroundcolor: Colors.redAccent
                          ,iconcolor: Colors.white,
                          iconsize: Dimensions.height10*5/2,
                          size: Dimensions.height10*5,), bigText:BigText(text: "Đăng xuất",)),
                      ),
                      SizedBox(height: Dimensions.height30,),
                    ],
                  ),
                ),
              )


            ],
          ),
        ):
        CustomLoader()):
        Container(child: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.maxFinite,
              height: Dimensions.height30*18,
              margin: EdgeInsets.only(left: Dimensions.widtht20,right: Dimensions.widtht20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                image: const DecorationImage(
                    fit:BoxFit.cover,
                  image: AssetImage("assets/image/shipper.png")
                )
              ),
            ),
            GestureDetector(
              onTap: (){
                Get.toNamed(RouteHelper.getSignin());
              },
              child: Container(
                width: double.maxFinite,
                height: Dimensions.height20*5,
                margin: EdgeInsets.only(left: Dimensions.widtht20,right: Dimensions.widtht20),
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                    borderRadius: BorderRadius.circular(Dimensions.radius20),

                ),
                child: Center(child: BigText(text: "Hãy đăng nhập",color: Colors.white,size: Dimensions.font26,)),
              ),
            ),
          ],
        )),);
      }),
    );
  }
}
