import 'dart:convert';

import 'package:doan6/models/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constants.dart';

class HeartFoodRefo {
  final SharedPreferences sharedPreferences;
  HeartFoodRefo({required this.sharedPreferences});


  List<String> listHeart=[];
  List<String> heart=[];

  void addHeartList(List<Products> listheart){
    heart=[];
    listheart.forEach((element) =>heart.add(jsonEncode(element)));
    sharedPreferences.setStringList(AppConstants.HEART_LIST, heart);
    print(sharedPreferences.getStringList(AppConstants.HEART_LIST));
    getHeartlist();
  }
  void removeHeartList(  Map<String, dynamic> Jsonproduct){
    Products products=Products.fromJson(Jsonproduct);
    var listproducts= getHeartlist();
    listproducts.removeWhere((element) => element.id==products.id);
    List<String> listprofuctheart=[];
    listproducts.forEach((element) {listprofuctheart.add(heartproductToJson(element));});
    heart=listprofuctheart;

    sharedPreferences.setStringList(AppConstants.HEART_LIST, heart);
    //print(sharedPreferences.getStringList(AppConstants.HEART_LIST));


  }
  List<Products> getHeartlist(){
    List<String> hearts=[];
    if(sharedPreferences.containsKey(AppConstants.HEART_LIST)){
      hearts=sharedPreferences.getStringList(AppConstants.HEART_LIST)!;
      print(hearts.toString());
    }
    List<Products> cartlist=[];
    // carts.forEach((element) {
    //     cartlist.add(CartModel.fromJson(jsonDecode(element)));
    // });
    hearts.forEach((element) =>cartlist.add(Products.fromJson(jsonDecode(element))));
    return cartlist;
  }

  void removeCart(){
    heart=[];
    sharedPreferences.remove(AppConstants.HEART_LIST);
  }
  void cleanHeartList(){
    listHeart=[];
    sharedPreferences.remove(AppConstants.HEART_LIST);
  }
}