import 'dart:convert';

import 'package:doan6/data/repository/all_produce_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../models/product.dart';
import 'package:http/http.dart' as http;

// class FetchFood{
//   var data=[];
//   List<Products> foodList=[];
//   String urlFetch="http://172.16.24.2:8001/api/v1/products/all";
//   Future<List<Products>> getFoodList({String? query}) async{
//     var url=Uri.parse(urlFetch);
//     var response= await http.get(url);
//     try {
//       if(response.statusCode==200){
//         print("get data success");
//         data=json.decode(response.body);
//         foodList=data.map((e) => Product.fromJson(e)).cast<Products>().toList();
//         print("list"+foodList.toString());
//         if(query!=null){
//           foodList=foodList.where((element) => element.name!.toLowerCase().contains(query.toLowerCase())).toList();
//           print("list"+foodList.toString());
//         }
//       }else{
//         print("api error");
//       }
//     } on Exception catch (e) {
//       print('error:$e');
//     }
//     print("abc"+foodList.toString());
//     return foodList;
//
//   }
// }
   // List<Products> parseFood(String responseBody){
   //   var list=json.decode(responseBody) as List<dynamic>;
   //   var produce=list.map((model) => Products.fromJson(model)).toList();
   //   return produce;
   //
   // }
   // Future<List<Products>> FetchProduce() async{
   //   String urlFetch="http://172.16.24.2:8001/api/v1/products/all";
   //   var url=Uri.parse(urlFetch);
   //   final response=await http.get(url);
   //   if(response.statusCode==200){
   //     print("thành công");
   //     return compute(parseFood,response.body);
   //   }else{
   //     throw Exception("lỗi api");
   //   }
   // }
class AllProduceController extends GetxController{
  final AllProduceRepo allProduceRepo;

  AllProduceController({required this.allProduceRepo});

  List<Products> _foodList=[];
  List<Products> get foodList=>_foodList;

  Products _nameList=Products();
  Products get products=>_nameList;


  bool _isLoaded=false;
  bool get isLoaded=>_isLoaded;

  void onInit() async {
    getFoodProduceList();
    super.onInit();
  }


  Future<List<Products>> getFoodProduceList() async{
    Response response= await allProduceRepo.getAllProduceList();
    if(response.statusCode==200){
     // print("get data list produce");
      _foodList=[];
      _foodList.addAll(Product.fromJson(response.body).products);
      // print(_foodList);
      _isLoaded=true;
      update();

    }else{
      print(" could not get data all produce");
    }
    return _foodList;
  }

}

