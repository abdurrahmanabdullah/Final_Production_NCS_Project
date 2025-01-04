import 'package:get/get.dart';

import '../controllers/nurse_call_controller.dart';

class NurseCallBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NurseCallController>(
      () => NurseCallController(),
    );
  }
}
