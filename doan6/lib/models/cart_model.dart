import 'package:doan6/models/product.dart';

class CartModel {
  int? id;
  String? name;
  int? price;
  String? img;
  int? quantity;
  bool? isExit;
  String? time;
  Products? product;

  CartModel(
      {this.id,
        this.name,
        this.price,
        this.img,
        this.quantity,
        this.isExit,
        this.time,
        this.product
      });

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    img = json['img'];
    quantity=json['quantity'];
    isExit=json['isExit'];
    time=json['time'];
    product=Products.fromJson(json['product']);

  }
  Map<String, dynamic> toJson(){
    return{
      "id":this.id,
     "name": this.name,
     "price": this.price,
     "img": this.img,
     "quantity": this.quantity,
     "isExit": this.isExit,
     "time": this.time,
      "product":this.product!.toJson(),
    };
  }
}
