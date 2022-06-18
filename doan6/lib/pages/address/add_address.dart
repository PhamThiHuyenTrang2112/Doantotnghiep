
import 'package:doan6/controller/location_controller.dart';
import 'package:doan6/controller/login_controller.dart';
import 'package:doan6/controller/user_controller.dart';
import 'package:doan6/models/address_model.dart';
import 'package:doan6/routes/route_hepper.dart';
import 'package:doan6/utils/color.dart';
import 'package:doan6/widgets/big_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';

import '../../controller/cart_controller.dart';
import '../../utils/dimensions.dart';
import '../../widgets/text_field.dart';
import 'package:permission_handler/permission_handler.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({Key? key}) : super(key: key);

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
   TextEditingController _addresscontroller=TextEditingController();
  final TextEditingController _contacPersoncontroller=TextEditingController();
  final TextEditingController _contacNumbercontroller=TextEditingController();
  late bool _isLogged;
    CameraPosition _cameraPosition= const CameraPosition(target: LatLng(
      21.02706230774065, 105.8342162976458,
  ),zoom: 17);
  late LatLng _initialPosition= const LatLng(
    21.02706230774065, 105.8342162976458,
  );

   Future<void> requestPermission() async { await Permission.location.request(); }

  @override
  void initState() {
    // TODO: implement initState
    requestPermission();
    super.initState();
    _isLogged=Get.find<LoginController>().userLogin();
    if(_isLogged && Get.find<UserController>().usermodel==null){// xác thực mô hình người dùng null không nếu null thì chưa đăng nhập
      Get.find<UserController>().getUserInfo();// lấy dữ liệu người dùng

    }
    if(Get.find<LocationController>().addresslist.isNotEmpty){// nếu danh sách địa chỉ không trống thì đã có kinh độ và vĩ độ
      if(Get.find<LocationController>().getUserAddressFromLocalStorage()==""){// kiểm tra bộ nhớ cục bộ có trống hay không
        Get.find<LocationController>().saveUserAddress(Get.find<LocationController>().addresslist.last);
      }
      Get.find<LocationController>().getUserAddress();
      _cameraPosition=CameraPosition(target: LatLng(
        double.parse(Get.find<LocationController>().getAddress["latitude"]),
          double.parse(Get.find<LocationController>().getAddress["longitude"])
      ));
      _initialPosition=LatLng(
          double.parse(Get.find<LocationController>().getAddress["latitude"]),
          double.parse(Get.find<LocationController>().getAddress["longitude"])
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trang địa chỉ"),
        backgroundColor: AppColors.mainColor,
      ),
      body: GetBuilder<UserController>(builder: (userController){

        if(userController.usermodel!=null&& _contacPersoncontroller.text.isEmpty){
            _contacPersoncontroller.text='${userController.usermodel!.name}';
            _contacNumbercontroller.text='${userController.usermodel!.phone}';
            if(Get.find<LocationController>().addresslist.isNotEmpty){
             _addresscontroller.text= Get.find<LocationController>().getUserAddress().address;
            }
        }
        return GetBuilder<LocationController>(builder: (locationcontroller){
          _addresscontroller.text='${locationcontroller.placemark.name??''}'
              '${locationcontroller.placemark.locality??''}'
              '${locationcontroller.placemark.postalCode??''}'
              '${locationcontroller.placemark.country??''}';
          print("Địa chỉ tôi nhìn thấy"+ _addresscontroller.text);
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 140,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(left: 5,right: 5,top: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                          width: 2,color: AppColors.mainColor
                      )
                  ),
                  child: Stack(
                    children: [
                      GoogleMap(initialCameraPosition:
                      CameraPosition(target: _initialPosition,zoom: 17),
                        buildingsEnabled: true,
                        zoomControlsEnabled: false,
                        compassEnabled: true,
                        indoorViewEnabled: true,
                        mapToolbarEnabled: true,
                        myLocationEnabled: true,
                        onCameraIdle: (){
                          locationcontroller.updatePosition(_cameraPosition,true);
                        },
                        onCameraMove: ((potision)=>_cameraPosition=potision),// khi camera di chuyển vị trí thay đổi
                        onMapCreated: (GoogleMapController controller){
                          locationcontroller.setMapController(controller);

                        },
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(left: Dimensions.widtht20,top: Dimensions.height20),
                  child: SizedBox(height: 50,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: locationcontroller.addressTypelist.length,
                        itemBuilder: (context,index){
                    return InkWell(
                      onTap: (){
                        locationcontroller.setAddressType(index);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.widtht20,vertical: Dimensions.height10),
                        margin: EdgeInsets.only(right: Dimensions.width10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius20/4),
                          color: Theme.of(context).cardColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[200]!,
                              spreadRadius: 1,
                              blurRadius: 5// bán kính lan truyền nhỏ hơn 5

                            )
                          ]
                        ),
                        child:Icon(
                          index==0?Icons.home_filled:index==1?Icons.work:Icons.location_on,
                          color: locationcontroller.addressTypeIndex==index
                              ?AppColors.mainColor:Theme.of(context).disabledColor,
                        ),
                      ),
                    );
                  }),),
                ),
                SizedBox(height: Dimensions.height20,),
                Padding(
                  padding:  EdgeInsets.only(left: Dimensions.widtht20),
                  child: BigText(text: "Địa chỉ giao hàng"),
                ),
                SizedBox(height: Dimensions.height20,),
                AppTextFeild(textController:_addresscontroller ,hintText:"Địa chỉ của bạn",icon: Icons.map,),
                SizedBox(height: Dimensions.height20,),
                Padding(
                  padding:  EdgeInsets.only(left: Dimensions.widtht20),
                  child: BigText(text: "Tên của bạn"),
                ),
                SizedBox(height: Dimensions.height20,),
                AppTextFeild(textController:_contacPersoncontroller ,hintText:"Tên bạn",icon: Icons.person,),
                SizedBox(height: Dimensions.height20,),
                Padding(
                  padding:  EdgeInsets.only(left: Dimensions.widtht20),
                  child: BigText(text: "Số điện thoại"),
                ),
                SizedBox(height: Dimensions.height20,),
                AppTextFeild(textController:_contacNumbercontroller ,hintText:"Số điện thoại của bạn",icon: Icons.phone,),
              ],
            ),
          );
        },);
      }),
      bottomNavigationBar: GetBuilder<LocationController>(builder: (locationcontroller){
        return Container(
            height: Dimensions.height20*8,
            padding: EdgeInsets.only(top: Dimensions.height30,bottom: Dimensions.height30,left: Dimensions.widtht20,right: Dimensions.widtht20),
            decoration: BoxDecoration(
              //color: AppColors.buttonBackgroundColor,

                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20*2),
                    topRight: Radius.circular(Dimensions.radius20*2)
                )
            ),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){
                    AddressModel _addressmodel=AddressModel(
                        addressType: locationcontroller.addressTypelist[locationcontroller.addressTypeIndex],
                      contacPerson: _contacPersoncontroller.text,
                      contacNumber: _contacNumbercontroller.text,
                      address: _addresscontroller.text,
                      laititude: locationcontroller.position.latitude.toString(),
                      longitude: locationcontroller.position.longitude.toString(),
                    );
                    locationcontroller.addAddress(_addressmodel).then((response){
                      if(response.issuccess){
                        //Get.toNamed(RouteHelper.getInitial());// nếu lưu thành công thì sẽ quay lại chủ
                        //Get.toNamed(RouteHelper.getCartpage());
                        Get.back();
                        Get.snackbar("Địa chỉ", "Lưu địa chỉ thành công");
                      }else{
                        Get.snackbar("Địa chỉ", "Lưu địa chỉ thất bại");
                      }
                    });

                  },
                  child: Container(
                    child: Container(
                      padding: EdgeInsets.only(top: Dimensions.height20,bottom: Dimensions.height20,right: Dimensions.widtht20,left: Dimensions.widtht20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                          color: AppColors.mainColor
                      ),
                      //
                      child: BigText(text: " Lưu địa chỉ",color: Colors.white,size: 26,),

                    ),
                  ),
                ),
              ],

            )
        );
      },),
    );
  }
}
