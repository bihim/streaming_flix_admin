import 'package:get/get.dart';
import 'package:streaming_flix_admin/controller/main_controller.dart';

class MainBinding extends Bindings{
  @override
  void dependencies() {
   Get.put<MainController>(MainController());
  }
}