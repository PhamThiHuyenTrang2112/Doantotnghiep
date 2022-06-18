import 'package:get/get_connect/http/src/response/response.dart';

import '../../models/place_order_model.dart';
import '../../utils/constants.dart';
import '../api/api_client.dart';

class OrderRepo {
  final ApiClient apiClient;
  OrderRepo({ required this.apiClient});

  Future<Response> placeOrder(PlaceOrderBody placeOrderBody) async {
    return await apiClient.postData(AppConstants.PLACE_ORDER_URL, placeOrderBody.toJson());
  }
}