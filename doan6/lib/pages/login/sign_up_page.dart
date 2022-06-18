
import 'package:doan6/base/custom_loader.dart';
import 'package:doan6/base/show_custom_snackbar.dart';
import 'package:doan6/controller/login_controller.dart';
import 'package:doan6/models/sign_up_model.dart';
import 'package:doan6/routes/route_hepper.dart';
import 'package:doan6/utils/color.dart';
import 'package:doan6/utils/dimensions.dart';
import 'package:doan6/widgets/big_text.dart';
import 'package:doan6/widgets/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var emailcontroller=TextEditingController();
    var passwordcontroller=TextEditingController();
    var namecontroller=TextEditingController();
    var phonecontroller=TextEditingController();
    var signupImage=[
      "t.png",
      "f.png",
      "g.jpg"
    ];
    void _registration(LoginController loginController){
      //var loginController=Get.find<LoginController>();
      String name=namecontroller.text.trim();
      String phone=phonecontroller.text.trim();
      String email=emailcontroller.text.trim();
      String password=passwordcontroller.text.trim();
      if(name.isEmpty){
          ShowCustomSnackbar("Hãy nhập tên bạn",title: "Name");
      }else if(phone.isEmpty){
        ShowCustomSnackbar("Hãy nhập số điện thoại",title: "phone");
      }else if(email.isEmpty){
        ShowCustomSnackbar("Hãy nhập địa chỉ email ",title: "email");
      }else if(!GetUtils.isEmail(email)){
        ShowCustomSnackbar("Hãy nhập địa chỉ email hợp lệ",title: "email hợp lệ");
      }else if(password.isEmpty){
        ShowCustomSnackbar("Hãy nhập mật khẩu",title: "password");
      }else if(password.length<6){
        ShowCustomSnackbar("Mật khẩu không được nhỏ hơn 6 kí tự",title: "password");
      }else{
        //ShowCustomSnackbar("Tất cả hợp lệ",title: "thành công");
        SignUpBody signUpBody=SignUpBody(name: name,
            phone: phone,
            email: email,
            password: password);
        //print(signUpBody.toString());
        loginController.registration(signUpBody).then((status){
          if(status.issuccess){
            print("Thành công");
            Get.offNamed(RouteHelper.getInitial());
          }else{
            ShowCustomSnackbar(status.message);
          }
        });
      }
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<LoginController>(builder: (_loginController){
        return !_loginController.isLoading?SingleChildScrollView(
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
              AppTextFeild(textController: emailcontroller, hintText: "Email", icon: Icons.email),
              SizedBox(height: Dimensions.height20,),
              AppTextFeild(textController: passwordcontroller, hintText: "Mật khẩu", icon: Icons.password_sharp,isObscure: true,),
              SizedBox(height: Dimensions.height20,),
              AppTextFeild(textController: namecontroller, hintText: "Tên", icon: Icons.person,),
              SizedBox(height: Dimensions.height20,),
              AppTextFeild(textController: phonecontroller, hintText: "Số điện thoại", icon: Icons.phone),
              SizedBox(height: Dimensions.height20+Dimensions.height20,),
              GestureDetector(
                onTap: ()=>{
                  _registration(_loginController)
                },
                child: Container(
                  width: Dimensions.screenWidth/2,
                  height: Dimensions.screenHeight/13,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius30),
                      color: AppColors.mainColor
                  ),
                  child: Center(child: BigText(text: "Đăng kí",size: Dimensions.font20+Dimensions.font20/2,color: Colors.white,)),
                ),
              ),
              SizedBox(height: Dimensions.height10,),
              RichText(text:TextSpan(
                  recognizer: TapGestureRecognizer()..onTap=()=>Get.back(),
                  text: "Bạn đã có tài khoản?",
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: Dimensions.font20,
                  )
              )
              ),
              SizedBox(height: Dimensions.screenHeight*0.05,),
              RichText(text:TextSpan(

                  text: "Đăng nhập sử dụng một trong những phương pháp dưới đây",
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: Dimensions.font16,
                  )
              )
              ),
              Wrap(
                children: List.generate(3, (index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: Dimensions.radius30,
                    backgroundImage: AssetImage(
                        "assets/image/"+signupImage[index]
                    ),
                  ),
                )),

              )


            ],
          ),
        ):const CustomLoader();
      })
    );

  }
}
