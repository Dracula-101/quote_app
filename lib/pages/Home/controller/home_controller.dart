import 'package:get/get.dart';
import 'package:quote_app/pages/API/models/random_quote.dart';

class HomeController extends GetxController {
  RxBool isLoading = true.obs;

  changeLoading() {
    isLoading.value = !isLoading.value;
    update();
  }
}
