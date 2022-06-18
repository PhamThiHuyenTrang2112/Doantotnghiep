import 'dart:convert';

import 'package:doan6/data/repository/location_repo.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/address_model.dart';
import '../models/respon_model.dart';

class LocationController extends GetxController implements GetxService{
  LocationRepo locationRepo;
  LocationController({required this.locationRepo});
  bool _loading=false;
  late Position _position;
  late Position _pickPotion;
  Placemark _placemark=Placemark();
  Placemark _pickmark=Placemark();

  Placemark get placemark=>_placemark;
  Placemark get pickmark=>_pickmark;


  bool get loading=>_loading;
  Position get position=>_position;
  Position get pickPotion=>_pickPotion;

  List<AddressModel> _addresslist=[];
  List<AddressModel> get addresslist =>_addresslist;

 late List<AddressModel> _listallAddress=[];
 List<AddressModel> get listallAddress=>_listallAddress;
   List<String> _addressTypeList=["home","office","others"];
   List<String> get addressTypelist=>_addressTypeList;
  int _addressTypeIndex=0;
  int get addressTypeIndex =>_addressTypeIndex;

  bool _updateAddressData=true;
  bool _changeAddress=true;

  late GoogleMapController _googleMapController;

  void setMapController(GoogleMapController mapController){
    _googleMapController=mapController;
  }

  void updatePosition(CameraPosition position, bool fromAddress) async {
    if(_updateAddressData){
      _loading=true;
      update();
      try{
        if(fromAddress){
          _position=Position(
              longitude: position.target.longitude,
              latitude: position.target.latitude,
              timestamp: DateTime.now(),
              accuracy: 1,
              altitude: 1,
              heading: 1,
              speed: 1,
              speedAccuracy: 1);
        }else{
          _pickPotion=Position(
              longitude: position.target.longitude,
              latitude: position.target.latitude,
              timestamp: DateTime.now(),
              accuracy: 1,
              altitude: 1,
              heading: 1,
              speed: 1,
              speedAccuracy: 1);
        }

        if(_changeAddress){
          String _address=await getAddressfromGeocode(
            LatLng(
                position.target.latitude,
                position.target.longitude)
          );
          fromAddress?_placemark=Placemark(name: _address)
              :_pickmark=Placemark(name: _address);

        }
      }catch(e){
        print(e);
      }
    }
  }

  Future<String> getAddressfromGeocode(LatLng latLng) async {
    String _address="Tìm thấy vị trí không xác định";
    Response response=await locationRepo.getAddressfromGeocode(latLng);
    print(response.body['status']);
    if(response.body["status"]=='OK'){
      _address=response.body["results"][0]["formatted_address"].toString();
      print("in địa chỉ"+_address);
    }else{
      print("lỗi lấy google API");
    }
    update();
    return _address;
  }

  late Map<String,dynamic> _getAddress;
  Map get getAddress=>_getAddress;
  AddressModel getUserAddress(){
    late AddressModel _addressModel;
    // convert to map using jsonDecode
    _getAddress=jsonDecode(locationRepo.getUserAddress());
    try{
        _addressModel=AddressModel.fromJson(jsonDecode(locationRepo.getUserAddress()));
    }catch(e){
      print(e);
    }
    return _addressModel;

  }
  void setAddressType(int index){
    _addressTypeIndex=index;
    update();
  }

 Future<ResponModel> addAddress(AddressModel addressModel) async{
    _loading=true;
    update();
   Response response= await locationRepo.addAddress(addressModel);
    ResponModel responModel;
   if(response.statusCode==200){
      await getAddressList();
     String message=response.body["message"];
     responModel=ResponModel(true, message);
    await saveUserAddress(addressModel);

   }else{
     print("không thể lưu địa chỉ");
     responModel=ResponModel(false, response.statusText!);
   }
   update();
   return responModel;
  }
  Future<void> getAddressList() async {
   Response response=await locationRepo.getAllAddress();
   if(response.statusCode==200){
     _addresslist=[];
     _listallAddress=[];
     response.body.forEach((address){
       _addresslist.add(AddressModel.fromJson(address));
       _listallAddress.add(AddressModel.fromJson(address));
     });
   }else{
     _addresslist=[];
     _listallAddress=[];
   }
   update();
  }
  Future<bool> saveUserAddress(AddressModel addressModel) async {
    String useraddress=jsonEncode(addressModel.toJson());// tất cả dữ kiệu luu trong đối tượng addressmodel sẽ chuyển sang json
    return await locationRepo.saveUserAddress(useraddress);
  }
  void cleanAddressList(){
    _addresslist=[];
    _listallAddress=[];
    update();

  }

  String getUserAddressFromLocalStorage(){
    return locationRepo.getUserAddress();
  }
}