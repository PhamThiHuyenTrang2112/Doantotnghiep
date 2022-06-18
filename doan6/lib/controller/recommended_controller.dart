import 'package:doan6/data/repository/popular_product.dart';
import 'package:doan6/data/repository/recommened_product.dart';
import 'package:doan6/models/product.dart';
import 'package:get/get.dart';

class RecommendedController extends GetxController{
  final RecommendedProduce recommendedProduce;

  RecommendedController({required this.recommendedProduce});
  List<Products> _recommendedList=[];
  List<Products> get recommendedList=>_recommendedList;


  bool _isLoaded=false;
  bool get isLoaded=>_isLoaded;

  @override
  void onInit() async {
    getRecommendedProduceList();
    super.onInit();
  }

  Future<void> getRecommendedProduceList() async{
    Response response= await recommendedProduce.getRecommendedProduceList();
    //print("data");
    if(response.statusCode==200){
      print("get data recommended");
      _recommendedList=[];
      _recommendedList.addAll(Product.fromJson(response.body).products);
      // print(_popularList);
      _isLoaded=true;
      update();

    }else{
      print(" could not get data all produce");
    }
  }
}