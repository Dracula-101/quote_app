import 'package:get/get.dart';
import 'package:quote_app/pages/Home/controller/home_controller.dart';

class FavouritesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}
