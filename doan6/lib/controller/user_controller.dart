import 'package:doan6/data/repository/user_repo.dart';
import 'package:doan6/models/respon_model.dart';
import 'package:doan6/models/sign_up_model.dart';
import 'package:doan6/models/user_model.dart';
import 'package:get/get.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;

  UserController({
    required this.userRepo
  });

  bool _isloading = false;

  bool get isLoading => _isloading;

  UserModel? _userModel;

  UserModel? get usermodel => _userModel;

  Future<ResponModel> getUserInfo() async {
    Response response = await userRepo.getUseInfo();
    late ResponModel responModel;
    print(response.body.toString());
    if (response.statusCode == 200) {
      _userModel = UserModel.fromJson(response.body);
      _isloading=true;
      responModel = ResponModel(true, "successfully");
    } else {
      print("did not get");
      responModel = ResponModel(false, response.statusText!);
    }
    update();
    return responModel;
  }


}