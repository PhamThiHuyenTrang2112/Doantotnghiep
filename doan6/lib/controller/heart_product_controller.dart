import 'package:doan6/data/repository/heart_food_repo.dart';
import 'package:doan6/models/product.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class HeartProduceController extends GetxController {
  final HeartFoodRefo heartFoodRefo;
  bool changecolor = false;

  HeartProduceController({required this.heartFoodRefo});

  Map<int, Products> _item = {};

  Map<int, Products> get item => _item;
  List<Products> storeItem = [];

  void addItem(Products product) {
    _item.putIfAbsent(product.id!, () {
      print("add item to the heart" +
          product.id!.toString() +
          product.price!.toString());
      return Products(
          id: product.id,
          name: product.name,
          description: product.description,
          price: product.price,
          stars: product.stars,
          img: product.img,
          location: product.location,
          createdAt: product.createdAt,
          updatedAt: product.updatedAt,
          typeId: product.typeId);
    });
    heartFoodRefo.addHeartList(getItemsHeart);
    update();
  }

  void removeHeart(Products product) {
    heartFoodRefo.removeHeartList(product.toJson());
    _item.removeWhere((key, value) => value.id == product.id);
    update();
  }

  List<Products> getHeartdata() {
    setCart = heartFoodRefo.getHeartlist();
    return storeItem;
  }

  set setItem(Map<int, Products> setItem) {
    _item = {};
    _item = setItem;
  }

  set setCart(List<Products> items) {
    storeItem = items;
    print("độ dài ds item" + storeItem.length.toString());
    for (int i = 0; i < storeItem.length; i++) {
      _item.putIfAbsent(storeItem[i].id!, () => storeItem[i]);
    }
  }

  List<Products> get getItemsHeart {
    return _item.entries.map((e) {
      return e.value;
    }).toList();
  }

  void cleanHeartList() {
    heartFoodRefo.removeCart();
    update();
  }

  void clean() {
    _item = {};
    update();
  }

  bool checkHeart(Products products) {
    for(var i in _item.values){
      if(i.id==products.id){
        return true;
      }
    }
    return false;
  }
}
