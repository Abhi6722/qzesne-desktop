import 'package:get/get.dart';
import 'auth_controller.dart';
import 'camera_controller.dart';

class AllBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController(), permanent: true);
    Get.put(MyCameraController(), permanent: true);
  }
}
