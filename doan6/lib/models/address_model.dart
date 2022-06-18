import 'package:get/get.dart';

class AddressModel{
  late int? _id;//_ kiểu private
  late String _addressType;
  late String? _contacPerson;
  late String? _contacNumber;
  late String _address;
  late String _laititude;
  late String _longitude;

  AddressModel({id,
  required addressType,
     contacPerson,
     contacNumber,
     address,
     laititude,
     longitude}){
    _id=id;
    _addressType=addressType;
    _contacPerson=contacPerson;
    _contacNumber=contacNumber;
    _address=address;
    _laititude=laititude;
    _longitude=longitude;
  }
  String get address=>_address;
  String get addressType=>_addressType;
  String? get contacPerson=>_contacPerson;
  String? get contacNumber=>_contacNumber;
  String get laititude=>_laititude;
  String get longitude=>_longitude;



  AddressModel.fromJson(Map<String,dynamic> json){
    _id=json['id'];
    _addressType=json["address_type"]??"";
    _contacNumber=json["contact_person_number"]??"";
    _contacPerson=json["contact_person_name"]??"";
    _address=json["address"];
    _laititude=json["latitude"];
    _longitude=json["longitude"];
  }
  Map<String,dynamic> toJson(){
    final Map<String , dynamic> data=Map<String,dynamic>();
    data['id']=this._id;
    data['address_type']=this._addressType;
    data['contact_person_number']=this._contacNumber;
    data['contact_person_name']=this._contacPerson;
    data['address']=this._address;
    data['longitude']=this._longitude;
    data['latitude']=this._laititude;
    return data;

  }

}