import 'package:doan6/controller/cart_controller.dart';
import 'package:doan6/controller/heart_product_controller.dart';
import 'package:doan6/data/repository/popular_product.dart';
import 'package:doan6/models/cart_model.dart';
import 'package:doan6/models/product.dart';
import 'package:doan6/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopularController extends GetxController{
  final PopularProduce popularProduce;
  int? idfood;

  PopularController({required this.popularProduce, this.idfood});
  List<Products> _popularList=[];
  List<Products> get popularList=>_popularList;
  late CartController _cart;
  late Products _products;
  Products get product=>_products;

  late HeartProduceController _heart;

  bool _isLoaded=false;
  bool get isLoaded=>_isLoaded;

  int _quantity=0;
  int get quantity=>_quantity;

  int _inCartitems=0;
  int get inCaritems=>_inCartitems+_quantity;

  @override
  void onInit() async {
    getPopularProduceList();
    super.onInit();
  }

Future<void> getPopularProduceList() async{
  Response response= await popularProduce.getPopularProduceList();
  print(_popularList);
  if(response.statusCode==200){
    print("get data");
    _popularList=[];
    _popularList.addAll(Product.fromJson(response.body).products);
    print(_popularList);
    _isLoaded=true;
    update();

  }else{
  }
}


  void setQuantity(bool isIncrement){
    if(isIncrement){
      print("tăng"+quantity.toString());
      _quantity=checkquantity(_quantity+1);
    }else{
      _quantity=checkquantity(_quantity-1);
    }
    update();
  }
  int checkquantity(int quantity){
    if((_inCartitems+quantity)<0){
      Get.snackbar("Thông báo", "Bạn không thể giảm!",
      backgroundColor: AppColors.mainColor,
      colorText: Colors.white,);
      if(_inCartitems<0){
        _quantity= -_inCartitems;
        return _quantity;
      }
      return 0;
    } else if((_inCartitems+quantity)>20){
      Get.snackbar("Thông báo", "Bạn không thể thêm nhiều hơn nữa!",
          backgroundColor: AppColors.mainColor,
          colorText: Colors.white);
      return 20;
    }else{
      return quantity;
    }
  }
  void initProduct(Products product,CartController cartController){
    _quantity=0;
    _inCartitems=0;
    _cart=cartController;
    var exist=false;
    exist=_cart.existIncart(product);
    if(exist){
      _inCartitems=_cart.getQuantity(product);
    }
  }

  void initProductHeart(Products product,HeartProduceController heartProduceController){

    _heart=heartProduceController;
    _heart.item.forEach((key, value) {
      print("the key is"+value.id.toString());
    });


  }
  void addItem(Products product) {
    //if (_quantity > 0) {
      _cart.addItem(product, _quantity);
      _quantity=0;
      _inCartitems=_cart.getQuantity(product);
      _cart.item.forEach((key, value) {
          print("the key is"+value.id.toString()+"quatity"+value.quantity.toString());
      });
      update();

  }
  void removeHeart(Products product){
    _heart.removeHeart(product);
    update();
  }
  void addItemHeart(Products product) {
    //if (_quantity > 0) {
    _heart.addItem(product);
    _heart.item.forEach((key, value) {
      print("the key is"+value.id.toString()+"quatity"+value.price!.toString());
    });
    update();
  }
  int get totalItem{
    return _cart.totalItem;
  }
  List<CartModel> get getItems{
    return _cart.getItems;
  }
  List<Products> get getItemsHeart{
    return _heart.getItemsHeart;
  }
}


