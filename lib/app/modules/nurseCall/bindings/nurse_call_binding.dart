import 'package:get/get.dart';
import 'package:get_cli_tutorial/app/modules/nurseCall/controllers/SIgnInViewController.dart';

import '../controllers/nurse_call_controller.dart';

class NurseCallBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignInViewController>(() => SignInViewController());
    Get.lazyPut<NurseCallController>(
      () => NurseCallController(),
    );
  }
}
