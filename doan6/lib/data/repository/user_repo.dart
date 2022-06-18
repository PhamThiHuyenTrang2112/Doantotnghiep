import 'package:doan6/data/api/api_client.dart';
import 'package:doan6/utils/constants.dart';
import 'package:get/get.dart';

class UserRepo{
  final ApiClient apiClient;
  UserRepo({required this.apiClient});

  Future<Response> getUseInfo() async {
   return await apiClient.getData(AppConstants.USER_INFO_URL);
  }
}