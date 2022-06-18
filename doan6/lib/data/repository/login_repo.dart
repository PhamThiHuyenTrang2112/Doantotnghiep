import 'package:doan6/data/api/api_client.dart';
import 'package:doan6/models/sign_up_model.dart';
import 'package:doan6/utils/constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginRepo{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  LoginRepo({required this.apiClient,
  required this.sharedPreferences});

 Future<Response> registration(SignUpBody signUpBody) async {
   return await apiClient.postData(AppConstants.REGISTRATION_URL, signUpBody.toJson());
  }
  Future<String> getUserToken()  async {
    return await sharedPreferences.getString(AppConstants.TOKEN)??"None";
  }

  bool userLogin()   {
    return  sharedPreferences.containsKey(AppConstants.TOKEN);
  }

  Future<Response> login(String phone,String password) async {
    return await apiClient.postData(AppConstants.LOGIN_URL, {"phone":phone,"password":password});
  }
 Future<bool> saveUserToken(String token) async {
      apiClient.token=token;
      apiClient.updateHeader(token);
      return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }

  Future<void> saveNumberPassword(String number,String password)async{
   try{
     await sharedPreferences.setString(AppConstants.PHONE, number);
     await sharedPreferences.setString(AppConstants.PASSWORD, password);
   }catch(e){
     throw e;
   }
  }
  bool clearSharedData(){
   sharedPreferences.remove(AppConstants.TOKEN);
   sharedPreferences.remove(AppConstants.PASSWORD);
   sharedPreferences.remove(AppConstants.PHONE);
   apiClient.token='';
   apiClient.updateHeader('');

   return true;
  }
}