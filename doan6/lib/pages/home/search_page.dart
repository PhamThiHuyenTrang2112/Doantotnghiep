import 'dart:convert';

import 'package:doan6/controller/all_produce_controller.dart';
import 'package:doan6/data/repository/all_produce_repo.dart';
import 'package:doan6/models/product.dart';
import 'package:doan6/routes/route_hepper.dart';
import 'package:doan6/utils/constants.dart';
import 'package:doan6/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../utils/color.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';
import '../../widgets/icon_and_text.dart';
import '../../widgets/small_text.dart';


class SearchFood extends StatefulWidget {
  const SearchFood({Key? key}) : super(key: key);

  @override
  State<SearchFood> createState() => _SearchFoodState();
}

class _SearchFoodState extends State<SearchFood> {

  List<Products> ulist = [];
  List<Products> foodLists = [];
  String value = "";


  @override
  void initState() {
    super.initState();
    Get.find<AllProduceController>().getFoodProduceList().then((subjectFromServer) {
      setState(() {
        ulist = subjectFromServer;
        foodLists = ulist;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: (){
            Get.toNamed(RouteHelper.getInitial());
          },
            child: Icon(Icons.arrow_back_ios)),

        title: const Center(
          child: Text(
            'Tìm kiếm món ăn',
            style: TextStyle(fontSize: 25),
          ),
        ),
        backgroundColor: AppColors.mainColor,
      ),
      body: Column(
        children: <Widget>[
          //Search Bar to List of typed Subject
          Container(
            padding: EdgeInsets.all(15),
            child: TextField(
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(
                    color: AppColors.mainColor,
                  ),
                ),
                suffixIcon: InkWell(
                  child: Icon(Icons.search,color: AppColors.mainColor,),
                ),
                contentPadding: EdgeInsets.all(15.0),
                hintText: 'Nhập từ khóa tìm kiếm ',
              ),
              onChanged: (String) {
                  setState(() {
                      foodLists = ulist
                          .where(
                            (food) => (food.name!.toLowerCase().contains(String.toLowerCase())),
                      ).toList();
                  });
              },
            ),
          ),

          Container(
            height: 70,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(5),
              children: [
                GestureDetector(
                  onTap:(){
                    setState(() {
                      foodLists = ulist
                          .where(
                            (food) => (food.name!.toLowerCase().contains("Bánh".toLowerCase())),
                      ).toList();
                    });
                  },
                  child: Container(
                    width: 110,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Image.asset("assets/image/iconbanh.jpeg",width:60,height: 50),
                        SizedBox(width: 5,),
                        Text("Bánh",style: TextStyle(fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 5,),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      foodLists = ulist
                          .where(
                            (food) => (food.name!.toLowerCase().contains("Chè".toLowerCase())),
                      ).toList();
                    });
                  },
                  child: Container(
                    width: 110,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Image.asset("assets/image/che.jpg",width:60,height: 50),
                        const SizedBox(width: 5,),
                        const Text("Chè",style: TextStyle(fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 5,),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      foodLists = ulist
                          .where(
                            (food) => (food.name!.toLowerCase().contains("Bít tết".toLowerCase())),
                      ).toList();
                    });
                  },
                  child: Container(
                    width: 110,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Image.asset("assets/image/iconbittet.jpg",width:60,height: 50),
                        const SizedBox(width: 5,),
                        const Text("Bít tết",style: TextStyle(fontWeight: FontWeight.bold),)
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 5,),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      foodLists = ulist
                          .where(
                            (food) => (food.name!.toLowerCase().contains("Mỳ".toLowerCase())),
                      ).toList();
                    });
                  },
                  child: Container(
                    width: 110,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Image.asset("assets/image/iconmy.jpg",width:60,height: 50),
                        SizedBox(width: 5,),
                        Text("Mỳ",style: TextStyle(fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 5,),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      foodLists = ulist
                          .where(
                            (food) => (food.name!.toLowerCase().contains("Cơm".toLowerCase())),
                      ).toList();
                    });
                  },
                  child: Container(
                    width: 110,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Image.asset("assets/image/iconcom.png",width:60,height: 50),
                        SizedBox(width: 5,),
                        Text("Cơm",style: TextStyle(fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 5,),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      foodLists = ulist
                          .where(
                            (food) => (food.name!.toLowerCase().contains("".toLowerCase())),
                      ).toList();
                    });

                  },
                  child: Container(
                    width: 110,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Image.asset("assets/image/logo2.png",width:60,height: 50),
                        SizedBox(width: 5,),
                        Text("Tất cả",style: TextStyle(fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Get.find<AllProduceController>().isLoaded ? foodLists.isNotEmpty ? Expanded(
            child: ListView.builder(
                itemCount:foodLists.length,
                itemBuilder: (context,index){
                  return  _listitem(index);
                }),
          )
              : Center(child: BigText(text:"Không có kết quả phù hợp ")):CircularProgressIndicator(color: AppColors.mainColor,),
        ],
      ),
    );
  }
  _listitem(index){
    return GestureDetector(
      onTap:() {
        if(foodLists[index].typeId==2 ){
          Get.toNamed(RouteHelper.getPopularfood(foodLists[index].id!, "home"),arguments: foodLists[index]);
        } else if(foodLists[index].typeId==3){
          print(foodLists[index].typeId);
          Get.toNamed(RouteHelper.getRecommentfood(foodLists[index].id!,"home"),arguments: foodLists[index]);
        }
      },
      child: Container(
        margin: EdgeInsets.only(left: Dimensions.widtht30,right:Dimensions.widtht20,bottom: Dimensions.height10 ),
        child: Row(
          children: [
            // image section
            Container(
              height:Dimensions.lisviewIMG,
              width: Dimensions.lisviewIMG,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white38,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          AppConstants.BASE_URL+AppConstants.UPLOAD_URL+ foodLists[index].img!
                      )
                  )
              ),
            ),
            // text container
            Expanded(
              child: Container(
                height: Dimensions.lisviewtextsize,

                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(Dimensions.radius20),
                        bottomRight: Radius.circular(Dimensions.radius20)
                    ),
                    color: Colors.white
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: Dimensions.width10,right: Dimensions.width10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BigText(text: foodLists[index].name!),
                      SizedBox(height: Dimensions.height10,),
                      SmallText(text: 'Món mgon mỗi ngày'),
                      SizedBox(height: Dimensions.height10,),
                      Text("${formatPrice(foodLists[index].price!.toString())}đ",style: const TextStyle(color: Colors.deepOrange,fontSize: 20),)
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  String formatPrice(String price){
    int dem=0;
    String a="";
    for(int i=price.length-1;i>=0;i--){
      a+=price[i];
      dem++;
      if(dem==3&& i!=0){
        a+=".";
        dem=0;
      }
    }
    price="";
    for(int i=a.length-1;i>=0;i--){
      price+=a[i];
    }
    return price;
  }
}
