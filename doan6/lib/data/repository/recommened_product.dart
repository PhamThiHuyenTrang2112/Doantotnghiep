
import 'package:doan6/data/api/api_client.dart';
import 'package:doan6/utils/constants.dart';
import 'package:get/get.dart';

class RecommendedProduce extends GetxService{
  final ApiClient apiClient;


  RecommendedProduce({required this.apiClient});

  Future<Response> getRecommendedProduceList() async{
    return await apiClient.getData(AppConstants.RECOMMENTS_URL);
  }

}