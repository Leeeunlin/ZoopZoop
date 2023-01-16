import 'package:get/get.dart';
import 'package:zoopzoop/controller/auth/authController.dart';
import 'package:zoopzoop/controller/bottomNavigationController.dart';
import 'package:zoopzoop/controller/community/communityController.dart';
import 'package:zoopzoop/controller/community/communityOpinionController.dart';
import 'package:zoopzoop/controller/mainController.dart';
import 'package:zoopzoop/controller/mypage/myPageController.dart';
import 'package:zoopzoop/controller/notification/notificationController.dart';
import 'package:zoopzoop/controller/signal/signalController.dart';

class InitBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController(), permanent: true);
    Get.put(NotificationController(), permanent: true);
    Get.put(MainController(), permanent: true); // 테스트컨트롤러
  }

  static additionalBinding() {
    Get.put(BottomNavigationController(), permanent: true);
    Get.put(CommunityController(), permanent: true);
    Get.put(CommunityOpinionController(), permanent: true);
    Get.put(SignalController(), permanent: true);
    Get.put(MyPageController(), permanent: true);
  }
}
