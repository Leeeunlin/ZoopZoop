import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zoopzoop/binding/initBinding.dart';
import 'package:zoopzoop/controller/notification/notificationController.dart';
import 'package:zoopzoop/model/user/userModel.dart';
import 'package:zoopzoop/repository/userRepository.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();
  
  Rx<UserModel> userModel = UserModel().obs;
  Rx<String> errorCode = ''.obs;

  // 구글 로그인 버튼 로직
  Future<void> loginGoogle() async {
    UserCredential userAuth = await signInWithGoogle();
    UserModel loginUser = await createUserModel(userAuth);
    await submitSignup(loginUser);
  }

  // 구글 제공 로그인 API *변경금지*
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

   // 로그인 하려는 유저가 신규유저인지 기존유저인지 확인하는 함수
  // 신규유저이면 데이터베이스 생성을 하여 저장을 함
  Future<void> submitSignup(UserModel signupUser) async {
    bool result =
        await UserRepository.signup(signupUser); // 유저가 있는지 없는지 확인하고 변수 저장
    if (result) {
      await loginUser(signupUser.userKey!);
    }
  }
    // 서버에 유저의 uid값이 있는지 확인하는 단계
  Future<UserModel?> loginUser(String uid) async {
    UserModel? userData = await UserRepository.loginUserByUid(
        uid); // USERS COLLECTION 안에 해당 uid 값이 있는지 확인 하는 함수 있으면 UserModel을 가져옴
    if (userData != null) {
      // 데이터가 NULL이 아니면 유저가 있는것임.
      userModel(userData); // user에 값을 넣음
      InitBinding.additionalBinding(); // 로그인이 완료하고 난후 컨트롤러 메모리에 올리기
      UserRepository.updateFCMToken(
          uid); // FCM토큰을 가져와 해당 유저의 Document에 fcm_token Field에 값을 넣는 함수 (로그인 시 상시로 갱신함)
    }
    return userData;
  }

  // 신규유저 DB 생성
  Future<UserModel> createUserModel(UserCredential userAuth) async {
    String? token = await NotificationController.to.getToken();
    return UserModel(
      createDate: DateTime.now(),
      userKey: userAuth.user!.uid,
      email: userAuth.user!.email,
      fcmToken: token,
      );
      }
      static String generateDetectorKey(String uid) {
    String timeInMilli = DateTime.now().millisecondsSinceEpoch.toString();
    return '${uid}_$timeInMilli';
  }
}
