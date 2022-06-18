
import 'package:doan6/data/api/api_client.dart';
import 'package:doan6/utils/constants.dart';
import 'package:get/get.dart';

class PopularProduce extends GetxService{
  final ApiClient apiClient;


  PopularProduce({required this.apiClient});

  Future<Response> getPopularProduceList() async{
    return await apiClient.getData(AppConstants.POPULAR_URL);
  }

}