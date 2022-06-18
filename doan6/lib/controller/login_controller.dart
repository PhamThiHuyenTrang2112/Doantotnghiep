import 'package:doan6/data/repository/login_repo.dart';
import 'package:doan6/models/respon_model.dart';
import 'package:doan6/models/sign_up_model.dart';
import 'package:get/get.dart';

class LoginController extends GetxController implements GetxService{
  final LoginRepo loginRepo;
  LoginController({
   required this.loginRepo
});
  bool _isloading=false;
  bool get isLoading=>_isloading;

 Future<ResponModel> registration(SignUpBody signUpBody) async {
    _isloading=true;
    update();
    Response response=await loginRepo.registration(signUpBody);
    late ResponModel responModel;
    if(response.statusCode==200){
        loginRepo.saveUserToken(response.body["token"]);
        responModel=ResponModel(true, response.body["token"]);
    }else{
      responModel=ResponModel(false, response.statusText!);
    }
    _isloading=false;
    update();
    return responModel;

  }
  Future<ResponModel> login(String phone,String password) async {

    _isloading=true;
    update();
    Response response=await loginRepo.login(phone, password);
    late ResponModel responModel;
    if(response.statusCode==200){

      loginRepo.saveUserToken(response.body["token"]);
      print("token của tôi"+response.body["token"]);
      responModel=ResponModel(true, response.body["token"]);
    }else{
      responModel=ResponModel(false, response.statusText!);
    }
    _isloading=false;
    update();
    return responModel;

  }
  void saveNumberPassword(String number,String password){
   loginRepo.saveNumberPassword(number, password);

  }
  bool userLogin()   {
    return loginRepo.userLogin();
  }
  bool cleanShareData(){
   return loginRepo.clearSharedData();
  }


}