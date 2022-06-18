import 'package:doan6/controller/popular_controller.dart';
import 'package:doan6/controller/recommended_controller.dart';
import 'package:doan6/models/product.dart';

import 'package:doan6/routes/route_hepper.dart';
import 'package:doan6/utils/color.dart';
import 'package:doan6/utils/constants.dart';
import 'package:doan6/utils/dimensions.dart';
import 'package:doan6/widgets/big_text.dart';
import 'package:doan6/widgets/icon_and_text.dart';
import 'package:doan6/widgets/small_text.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../../controller/login_controller.dart';
import '../../controller/user_controller.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  _FoodPageBodyState createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = Dimensions.pageViewContainer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          //slider selection
          GetBuilder<PopularController>(builder: (popularProducts) {
            return popularProducts.isLoaded
                ? Container(
                    height: Dimensions.pageView,
                    child: PageView.builder(
                        controller: pageController,
                        itemCount: popularProducts.popularList.length,
                        itemBuilder: (context, position) {
                          return _buildPageItem(
                              position, popularProducts.popularList[position]);
                        }),
                  )
                : CircularProgressIndicator(
                    color: AppColors.mainColor,
                  );
          }),
          //dots
          GetBuilder<PopularController>(builder: (popularProducts) {
            return new DotsIndicator(
              dotsCount: popularProducts.popularList.isEmpty
                  ? 1
                  : popularProducts.popularList.length,
              position: _currPageValue,
              decorator: DotsDecorator(
                activeColor: AppColors.mainColor,
                size: const Size.square(9.0),
                activeSize: const Size(18.0, 9.0),
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
              ),
            );
          }),
          //popular text
          SizedBox(
            height: Dimensions.height30,
          ),
          Container(
            margin: EdgeInsets.only(left: Dimensions.widtht30),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                BigText(text: 'Gợi ý'),
                SizedBox(
                  width: Dimensions.width10,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 3),
                  child: BigText(
                    text: '.',
                    color: Colors.black26,
                  ),
                ),
                SizedBox(
                  width: Dimensions.width10,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 2),
                  child: SmallText(
                    text: 'Hôm nay ăn gì',
                  ),
                )
              ],
            ),
          ),
          // recomment food
          //list of food
          GetBuilder<RecommendedController>(builder: (recommenproduct) {
            return recommenproduct.isLoaded? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: recommenproduct.recommendedList.length,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.75,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 13,
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: (){
                      Get.toNamed(RouteHelper.getRecommentfood(recommenproduct.recommendedList[index].id,"home"));
                    },
                    child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(30.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            AppConstants.BASE_URL +
                                                AppConstants.UPLOAD_URL +
                                                recommenproduct
                                                    .recommendedList[index]
                                                    .img!))),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: BigText(
                                  text: recommenproduct
                                      .recommendedList[index].name!),
                            ),
                            Text(
                                "${formatPrice(recommenproduct.recommendedList[index].price!.toString())}đ",
                                style: const TextStyle(
                                    color: Colors.deepOrange,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15)),
                            Row(
                              children: [
                                Icon(Icons.location_on,size: 11,color: AppColors.mainColor,),
                                Text(recommenproduct.recommendedList[index].location!,style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 11,
                                    overflow: TextOverflow.ellipsis
                                ),),
                              ],
                            ),
                          ],
                        ),
                  )),
            ):CircularProgressIndicator(color: AppColors.mainColor,);
          })
        ],
      ),
    );
  }

  Widget _buildPageItem(int index, Products popularList) {
    Matrix4 matrix4 = new Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1);
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    }

    return Transform(
      transform: matrix4,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(RouteHelper.getPopularfood(popularList.id!, "popular page"));
            },
            child: Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.only(
                  left: Dimensions.width10, right: Dimensions.width10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  color: index.isEven ? Color(0xFF69c5df) : Color(0xFF9294cc),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(AppConstants.BASE_URL +
                          AppConstants.UPLOAD_URL +
                          popularList.img!))),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(
                  left: Dimensions.widtht30,
                  right: Dimensions.widtht30,
                  bottom: Dimensions.height30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white,
                  boxShadow: const [
                    // hiệu ứng đổ bóng
                    BoxShadow(
                        color: Color(0xFFe8e8e8),
                        blurRadius: 5.0, // bán kính mờ
                        offset: Offset(0, 5)),
                    BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                    BoxShadow(color: Colors.white, offset: Offset(5, 0))
                  ]),
              child: Container(
                padding: EdgeInsets.only(
                    top: Dimensions.height15,
                    left: Dimensions.width15,
                    right: Dimensions.width15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(text: popularList.name!),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    Expanded(
                      child: Row(
                        children: [

                          RatingBarIndicator(
                            rating:  4.5,
                            itemSize: 18,

                            itemBuilder: (_,__){
                              return  const Icon(
                                Icons.star,
                                color: Colors.amberAccent,
                              );
                            },
                          ),
                          SizedBox(
                            width: Dimensions.height10,
                          ),
                          SmallText(text: popularList.stars!.toString()),
                          SizedBox(
                            width: Dimensions.height10,
                          ),
                          SmallText(text: '1287'),
                          SizedBox(
                            width: Dimensions.height10,
                          ),
                          SmallText(text: 'Comments')
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconAndText(
                            icon: Icons.circle_sharp,
                            text: 'Nomal',
                            iconColor: AppColors.iconColor1),
                        IconAndText(
                            icon: Icons.location_on,
                            text: popularList.location!,
                            iconColor: AppColors.mainColor),
                        IconAndText(
                            icon: Icons.access_time_rounded,
                            text: '32min',
                            iconColor: AppColors.iconColor2)
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  String formatPrice(String price) {
    int dem = 0;
    String a = "";
    for (int i = price.length - 1; i >= 0; i--) {
      a += price[i];
      dem++;
      if (dem == 3 && i != 0) {
        a += ".";
        dem = 0;
      }
    }
    price = "";
    for (int i = a.length - 1; i >= 0; i--) {
      price += a[i];
    }
    return price;
  }
}
