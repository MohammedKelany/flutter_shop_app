import 'package:get/get.dart';
import 'package:shop_app/controller/login_controller.dart';
import 'package:shop_app/controller/register_controller.dart';
import 'package:shop_app/controller/shop_controller.dart';

class ShopBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => ShopController());
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => RegisterController());
  }
}
