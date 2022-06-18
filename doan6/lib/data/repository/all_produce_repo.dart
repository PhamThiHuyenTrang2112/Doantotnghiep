
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';

import '../../utils/constants.dart';
import '../api/api_client.dart';

class AllProduceRepo extends GetxService{
  final ApiClient apiClient;

  AllProduceRepo({required this.apiClient});

  Future<Response> getAllProduceList() async{
    return await apiClient.getData(AppConstants.All_PRODUCE_URL);
  }
}