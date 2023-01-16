import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoopzoop/model/user/userModel.dart';
import 'package:zoopzoop/utils/data_keys.dart';

final String userKey = FirebaseAuth.instance.currentUser!.uid;

class MyPageController extends GetxController {
  static MyPageController get to => Get.find();
  
  Rx<UserModel> userModel = UserModel().obs;

  Rx<TextEditingController> nicknameInput = TextEditingController().obs;
  RxBool wordchkSearch = false.obs;
  RxString nicknameInputListener = ''.obs; // 글자와 버튼 연결해주는 컨트롤러

  @override
  void onInit() async {
    await getUser(userKey);
    super.onInit();
  }

  void reLoad() {
    wordchkSearch.value = false;
    nicknameInputListener.value = '';
  }

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

  // 유저 정보 가져오기
  Future<void> getUser(String userKey) async {
    var userData = await loginUserByUid(userKey);
    if (userData != null) {
      userModel(userData);
    }
  }

  Future setNickName(String nickname) async {
    userModel.update((_user) {
      _user!.nickName = nickname;
    });
    DocumentReference<Map<String, dynamic>> docRef =
        FirebaseFirestore.instance.collection(COL_USERS).doc(userKey);
    await docRef.set({FIELD_NICKNAME: nickname}, SetOptions(merge: true));
  }
}
