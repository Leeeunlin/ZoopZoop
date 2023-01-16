import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:zoopzoop/controller/mypage/myPageController.dart';
import 'package:zoopzoop/utils/wordchk_search.dart';
import 'package:zoopzoop/view/login/loginWelcomPage.dart';

class MyNickName extends GetView<MyPageController> {
  const MyNickName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (controller.userModel.value.nickName != '') {
      controller.nicknameInput.value.text =
          controller.userModel.value.nickName.toString();
    }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          title: const Text(
            '내 정보 수정',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: SafeArea(
            child: Container(
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    Obx(
                      () => TextFormField(
                        maxLength: 10,
                        controller: controller.nicknameInput.value,
                        onChanged: (value) {
                          controller.nicknameInputListener.value = value;
                          if (wordchkSearch.contains(value)) {
                            controller.wordchkSearch.value = true;
                          } else {
                            controller.wordchkSearch.value = false;
                          }
                        },
                        // decoration: const InputDecoration(
                        //   hintText: '변경할 닉네임을 입력하세요',
                        // ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '닉네임을 입력하세요';
                          } else if (controller.wordchkSearch.value) {
                            return '적합하지 않은 문자열이 있습니다';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                        top: 20,
                      ),
                      width: double.infinity,
                      child: const Text(
                        '계정정보',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 10),
                      width: double.infinity,
                      child: Text(
                        controller.userModel.value.email.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Obx(
                      () => SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: controller.wordchkSearch.value
                                  ? null
                                  : controller.nicknameInputListener.value == ''
                                      ? null
                                      : () {
                                          controller.setNickName(controller
                                              .nicknameInputListener.value);
                                          Get.back();
                                        },
                              child: const Text(
                                '변경하기',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ))),
                    )
                  ],
                ))));
  }
}
