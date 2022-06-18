class AppConstants{
  static const String NAME_APP="FastFood";
  static const int VERSION_APP=1;
 //static const String BASE_URL="http://mvs.bslmeiyu.com";
  //static const String BASE_URL="http://192.168.1.57:8001";
  static const String BASE_URL="http://172.16.24.2:8001";
  //static const String BASE_URL="http://127.0.0.1:8001";
  static const String POPULAR_URL="/api/v1/products/popular";
  static const String All_PRODUCE_URL="/api/v1/products/all";
  static const String RECOMMENTS_URL="/api/v1/products/recommended";
  static const String UPLOAD_URL="/uploads/";


  //user and login end points
  static const String REGISTRATION_URL="/api/v1/auth/register";
  static const String LOGIN_URL="/api/v1/auth/login";
  static const String USER_INFO_URL="/api/v1/customer/info";

  //ADDRESS
  static const String USE_ADDRESS="user_address";
  static const String ADD_USE_ADDRESS="/api/v1/customer/address/add";
  static const String ADDRESS_LIST_URI="/api/v1/customer/address/list";
  static const String GEOCODE_URI="/api/v1/config/geocode-api";


  static const String TOKEN="";
  static const String PHONE="";
  static const String PASSWORD="";
  static const String CART_LIST="cart-list";
  static const String PLACE_ORDER_URL = '/api/v1/customer/order/place';
  static const String HEART_LIST="heart-list";
  static const String CART_HISTORY="cart-history";
}