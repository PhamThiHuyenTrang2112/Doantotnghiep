import 'dart:convert';

import 'package:doan6/models/cart_model.dart';
import 'package:doan6/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cart{
  final SharedPreferences sharedPreferences;

  Cart({required this.sharedPreferences});

  List<String> cart=[];
  List<String> cartHistory=[];


  void addTocartList(List<CartModel> cartlist){
    // sharedPreferences.remove(AppConstants.CART_LIST);
    // sharedPreferences.remove(AppConstants.CART_HISTORY);
    // return;
    var time=DateTime.now().toString();

    cart=[];
    // convert đối tượng thành chuỗi bởi vì sharedPreferences chỉ chấp nhận chuỗi
    cartlist.forEach((element) {
      element.time=time;
       return cart.add(jsonEncode(element));
    });
    sharedPreferences.setStringList(AppConstants.CART_LIST, cart);
    print (sharedPreferences.getStringList(AppConstants.CART_LIST));
  }
  List<CartModel> getCartlist(){
    List<String> carts=[];
    if(sharedPreferences.containsKey(AppConstants.CART_LIST)){
      carts=sharedPreferences.getStringList(AppConstants.CART_LIST)!;
    }
      List<CartModel> cartlist=[];
    // carts.forEach((element) {
    //     cartlist.add(CartModel.fromJson(jsonDecode(element)));
    // });
    carts.forEach((element) =>cartlist.add(CartModel.fromJson(jsonDecode(element))));
    return cartlist;
  }
  List<CartModel>getlistHistory(){
    if(sharedPreferences.containsKey(AppConstants.CART_HISTORY)){
      //cartHistory=[];
      cartHistory=sharedPreferences.getStringList(AppConstants.CART_HISTORY)!;
    }
    List<CartModel> cartHistoryList=[];
    cartHistory.forEach((element)=>cartHistoryList.add(CartModel.fromJson(jsonDecode(element))));
    return cartHistoryList;
  }
  void addTocartHistoryList(){
    if(sharedPreferences.containsKey(AppConstants.CART_HISTORY)){
      cartHistory=sharedPreferences.getStringList(AppConstants.CART_HISTORY)!;
    }
    for(int i=0; i<cart.length;i++){
        cartHistory.add(cart[i]);
    }
    removeCart();
    sharedPreferences.setStringList(AppConstants.CART_HISTORY, cartHistory);
  }
  void removeCart(){
    cart=[];
    sharedPreferences.remove(AppConstants.CART_LIST);
  }
  void cleanCartHistory(){
    removeCart();
    cartHistory=[];
    sharedPreferences.remove(AppConstants.CART_HISTORY);
  }
}