import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:zoopzoop/controller/notification/notificationController.dart';
import 'package:zoopzoop/model/user/userModel.dart';
import 'package:zoopzoop/utils/data_keys.dart';
import 'package:zoopzoop/utils/logger.dart';

final String userKey =
    FirebaseAuth.instance.currentUser!.uid; // 로그인된 유저 키값을 가져 옴

class UserRepository {
  // USERS COLLECTION 안에 해당 uid 값이 있는지 확인 하는 함수 있으면 UserModel을 가져옴
  static Future<UserModel?> loginUserByUid(String uid) async {
    QuerySnapshot<Map<String, dynamic>> data = await FirebaseFirestore.instance
        .collection(COL_USERS)
        .where(FIELD_USERKEY, isEqualTo: uid)
        .get();

    if (data.size == 0) {
      return null;
    } else {
      return UserModel.fromJson(data.docs.first.data());
    }
  }

  // 신규유저인지 아닌지 확인하는 함수
  // 신규유저이면 데이터베이스에 저장 (저장위치 : users COLLECTION => [KEY] Document => FIELD값)
  // 기존유저이면 데이터베이스에 저장하지 않음
  static Future<bool> signup(UserModel userModel) async {
    try {
      UserModel? userData = await loginUserByUid(userModel
          .userKey!); // uid값을 가지고 USERS COLLECTION => [KEY] => userKey값이 있는지 확인 (있으면 기존 유저 / 없으면 신규 유저)
      // userData가 null이 아니면 기존유저
      if (userData != null) {
        return true; // 기존 유저
      } else {
        // userData가 null이면 신규유저이므로 데이터베이스에 저장 함.
        await FirebaseFirestore.instance
            .collection(COL_USERS)
            .doc(userModel.userKey)
            .set(userModel.toJson());
        return true; // 신규 유저
      }
    } catch (e) {
      logger.i(e);
      return false; // 에러 발생 Crashlytics
    }
  }
  
  // FCM토큰값을 유저 데이터베이스에 저장하여 사용
  static Future<void> updateFCMToken(String uid) async {
    String? token = await NotificationController.to.getToken(); // FCM토큰 가져오기
    await FirebaseFirestore.instance
        .collection(COL_USERS)
        .doc(uid)
        .update({FIELD_FCMTOKEN: token});
  }
}
