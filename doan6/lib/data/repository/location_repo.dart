import 'package:doan6/data/api/api_client.dart';
import 'package:doan6/models/address_model.dart';
import 'package:doan6/utils/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class LocationRepo{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  LocationRepo({required this.apiClient,required this.sharedPreferences});

 Future<Response> getAddressfromGeocode(LatLng latLng) async {
    return await apiClient.getData('${AppConstants.GEOCODE_URI}'
        '?lat=${latLng.latitude}&lng=${latLng.longitude}');
  }
  String getUserAddress(){
   return sharedPreferences.getString(AppConstants.USE_ADDRESS)??"";
  }
  Future<Response> addAddress(AddressModel addressModel) async {
   return await apiClient.postData(AppConstants.ADD_USE_ADDRESS, addressModel.toJson());
  }
  Future<Response> getAllAddress() async {
   return await apiClient.getData(AppConstants.ADDRESS_LIST_URI);
  }

  Future<bool> saveUserAddress(String address) async {
   apiClient.updateHeader(sharedPreferences.getString(AppConstants.TOKEN)!);
   return await sharedPreferences.setString(AppConstants.USE_ADDRESS, address);
  }
}