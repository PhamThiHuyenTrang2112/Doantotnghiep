
import 'package:doan6/base/custom_loader.dart';
import 'package:doan6/base/show_custom_snackbar.dart';
import 'package:doan6/controller/login_controller.dart';
import 'package:doan6/pages/login/sign_up_page.dart';
import 'package:doan6/routes/route_hepper.dart';
import 'package:doan6/utils/color.dart';
import 'package:doan6/utils/dimensions.dart';
import 'package:doan6/widgets/big_text.dart';
import 'package:doan6/widgets/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var passwordcontroller=TextEditingController();
    var phonecontroller=TextEditingController();

    void _login(LoginController loginController){
       String phone=phonecontroller.text.trim();
      String password=passwordcontroller.text.trim();
      if(phone.isEmpty){
        ShowCustomSnackbar("Hãy nhập số điện thoại ",title: "phone");
      }else if(password.isEmpty){
        ShowCustomSnackbar("Hãy nhập mật khẩu",title: "password");
      }else if(password.length<6){
        ShowCustomSnackbar("Mật khẩu không được nhỏ hơn 6 kí tự",title: "password");
      }else{
        //ShowCustomSnackbar("Tất cả hợp lệ",title: "thành công");

        loginController.login(phone, password).then((status){
          if(status.issuccess){
            print("Thành công");
            Get.toNamed(RouteHelper.getInitial());
            //Get.toNamed(RouteHelper.getCartpage());
          }else{
            ShowCustomSnackbar(status.message);
          }
        });
      }
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<LoginController>(builder:(loginController) {
       return !loginController.isLoading?SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: Dimensions.screenHeight*0.05,),
              //logo
              Container(
                height: Dimensions.screenHeight*0.25,
                child: Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 80,
                    backgroundImage: AssetImage("assets/image/logo2.png"),
                  ),
                ),
              ),
              //welcom
              Container(
                margin: EdgeInsets.only(left: Dimensions.widtht20),
                child: Column(
                  children: [
                    Text("Xin Chào",style: TextStyle(fontSize: Dimensions.font20*3+Dimensions.font20/2,fontWeight: FontWeight.bold),)
                  ],
                ),
              ),
              SizedBox(height: Dimensions.height20,),
              AppTextFeild(textController: phonecontroller, hintText: "Số điện thoại", icon: Icons.phone),
              SizedBox(height: Dimensions.height20,),
              AppTextFeild(textController: passwordcontroller, hintText: "Mật khẩu", icon: Icons.password_sharp,isObscure: true,),

              SizedBox(height: Dimensions.height10,),
              Row(
                children: [
                  Expanded(child: Container()),
                  RichText(text:TextSpan(

                      text: "Đăng nhập vào tài khoản của bạn",
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: Dimensions.font20,
                      )
                  ),
                  ),
                  SizedBox(width: Dimensions.height20,)
                ],
              ),
              SizedBox(height: Dimensions.screenHeight*0.05,),
              GestureDetector(
                onTap: (){
                  _login(loginController);
                },
                child: Container(
                  width: Dimensions.screenWidth/2,
                  height: Dimensions.screenHeight/13,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius30),
                      color: AppColors.mainColor
                  ),
                  child: Center(child: BigText(text: "Đăng nhập",size: Dimensions.font20+Dimensions.font20/2,color: Colors.white,)),
                ),
              ),
              SizedBox(height: Dimensions.screenHeight*0.05,),
              RichText(text:TextSpan(

                  text: "Bạn chưa có tài khoản?",
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: Dimensions.font20,
                  ),
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>SignUpPage(),transition: Transition.fade),
                      text: "Tạo tài khoản",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.mainBlackColor,
                        fontSize: Dimensions.font20,
                      ),)

                  ]
              )
              ),


            ],
          ),
        ):CustomLoader();
      })
    );
  }
}
