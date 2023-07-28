import 'package:get/get.dart';
import 'package:shop_app/controller/shop_controller.dart';
import 'package:shop_app/model/user_model.dart';
import 'package:shop_app/shared/constants/constants.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/local/catch_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/view/shop_layout.dart';
import 'package:shop_app/view/widgets/shared_components.dart';

class LoginController extends GetxController {
  bool isVisible = false;

  bool changePassVisibility() {
    isVisible = !isVisible;
    update();
    return isVisible;
  }

  bool isLoading = false;
  UserModel? userModel;

  void userLogin({
    required String email,
    required String password,
  }) {
    isLoading = true;
    update();
    DioHelper.postData(url: LOGIN, data: {
      'email': email,
      'password': password,
    }).then((value) {
      isLoading = false;
      userModel = UserModel.fromJson(value.data);
      getToast(
        text: userModel!.message!.toString(),
        state: ToastStates.SUCCESS,
      );
      CatchHelper.setData(key: 'token', value: userModel!.data!.token).then(
        (value) {
          token = value.toString();
          update();
          Get.off(() => const ShopLayout());
        },
      );
      update();
    }).catchError((error) {
      isLoading = false;
      getToast(
        text: userModel!.message.toString(),
        state: ToastStates.ERROR,
      );
      update();
    });
  }
}
