import 'package:doan6/data/repository/cart.dart';
import 'package:doan6/models/cart_model.dart';
import 'package:doan6/models/product.dart';
import 'package:doan6/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartController extends GetxController{
  final Cart cart;

  CartController({required this.cart});
  Map<int, CartModel> _item={};
  Map<int, CartModel> get item=>_item;
  //chỉ dùng cho lưu trữ và tùy chọn chia sẻ
  List<CartModel> storeItem=[];

  void addItem(Products product,int quantity){
    var totalquatity=0;
   if(_item.containsKey(product.id)){
     _item.update(product.id!, (value){
       totalquatity=value.quantity!+quantity;
       return CartModel(
         id:value.id,
         name:value.name,
         price:value.price,
         img:value.img,
         quantity:value.quantity!+quantity,
         isExit:true,
         time:DateTime.now().toString(),
         product: product,
       );
     });
     if(totalquatity<0){
       _item.remove(product.id);
     }

   }else{
     if(quantity>0){
       _item.putIfAbsent(product.id!, ()
       {
         return CartModel(
           id:product.id,
           name:product.name,
           price:product.price,
           img:product.img,
           quantity:quantity,
           isExit:true,
           time:DateTime.now().toString(),
           product: product,
         );}
       );
     }else{
       Get.snackbar("Thông báo", "Bạn nên thêm ít nhất một sản phẩm vào giỏ hàng!",
           backgroundColor: AppColors.mainColor,
           colorText: Colors.white);
     }
   }
    cart.addTocartList(getItems);
   update();


  }
  bool existIncart(Products product){
    if(_item.containsKey(product.id)){
      return true;
    }
    return false;
  }
  int getQuantity(Products product){
    var quatity=0;
    if(_item.containsKey(product.id)){
      _item.forEach((key, value) {
          if(key==product.id){
              quatity=value.quantity!;
          }
      });
    }
    return quatity;
  }
  int get totalItem{
    var totalquantity=0;
    _item.forEach((key, value) {
        totalquantity+=value.quantity!;
    });
    return totalquantity;
  }
  List<CartModel> get getItems{
    return _item.entries.map((e) {
     return e.value;
    }).toList();
  }
  int get totalMoney {
    var total=0;
    _item.forEach((key, value) {
      total+=value.quantity!*value.price!;
    });
    return total;
  }
  List<CartModel> getCartdata(){
    setCart=cart.getCartlist();
     return storeItem;
 }
 set setCart(List<CartModel> items){
      storeItem=items;
      for(int i=0;i<storeItem.length;i++){
        _item.putIfAbsent(storeItem[i].product!.id!, () => storeItem[i]);
      }
 }
 void addHistory(){
    cart.addTocartHistoryList();
    //clean();
 }
 void clean(){
    _item={};
    //update();
 }

 List<CartModel> getcartHistoryList(){
    return cart.getlistHistory();
 }
 set setItem(Map<int, CartModel> setItem){
    _item={};
    _item=setItem;
 }
 void addtocartList(){
    cart.addTocartList(getItems);
    update();
 }
 void cleanCartHistory(){
    cart.cleanCartHistory();
    update();
 }
}