import 'package:doan6/utils/constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient extends GetConnect implements GetxService{
  late String token;
  final String appbaseUrl;//url của ứng dụng
  late SharedPreferences sharedPreferences;

  late Map<String,String> _mainHeard;

  ApiClient({required this.appbaseUrl,required this.sharedPreferences}){
      baseUrl=appbaseUrl;
      timeout=Duration(seconds: 30);
      token=sharedPreferences.getString(AppConstants.TOKEN)??"";
      _mainHeard={
        'Content-type':'application/json; charset=UTF-8',
        'Authorization':'Bearer $token',

      };
  }
  void updateHeader(String token){
    _mainHeard={
      'Content-type':'application/json; charset=UTF-8',
      'Authorization':'Bearer $token',
    };
  }
  Future<Response> getData(String uri, {Map<String,String>? headers}) async {  // để trong ngoặc nhọn thược tính trở thành tùy chọn
    try{
     Response response= await get(uri,
     headers: headers??_mainHeard
     );// lưu dữ dữ liệu trả về ở dạng phản hồi
     return response;

    }catch(e){
      return Response(statusCode: 1,statusText: e.toString());// không thành công sẽ trả về thông báo lỗi
    }

  }
  Future<Response> postData(String uri, dynamic body) async {
    print(body.toString());
    try{
     Response response=await post(uri, body,headers: _mainHeard);
     print(response.toString());
     return response;
    }catch(e){
      print(e.toString());
      return Response(statusCode: 1,statusText: e.toString());
    }
  }




}