import 'package:get/get.dart';
import 'package:streaming_flix_admin/controller/home_controller.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies() {
   Get.put<HomeController>(HomeController());
  }
}