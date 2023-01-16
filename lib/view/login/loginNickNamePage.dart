import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoopzoop/controller/mypage/myPageController.dart';
import 'package:zoopzoop/utils/wordchk_search.dart';
import 'package:zoopzoop/view/login/loginWelcomPage.dart';

class LoginNickNamePage extends GetView<MyPageController> {
  const LoginNickNamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          title: const Text(
            '회원가입',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: SafeArea(
          child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                      padding: const EdgeInsets.only(top: 30),
                      child: Column(
                        children: <Widget>[
                          const SizedBox(
                              width: double.infinity,
                              child: Text('줍줍 커뮤니티에서 활동할\n닉네임을 입력해주세요',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold))),
                          Obx(
                            () => Container(
                              padding: const EdgeInsets.only(top: 50),
                              child: TextFormField(
                                maxLength: 10,
                                controller: controller.nicknameInput.value,
                                onChanged: (value) {
                                  controller.nicknameInputListener.value =
                                      value;
                                  if (wordchkSearch.contains(value)) {
                                    controller.wordchkSearch.value = true;
                                  } else {
                                    controller.wordchkSearch.value = false;
                                  }
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
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
                          ),
                          Obx(
                            () => SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                    onPressed: controller.wordchkSearch.value
                                        ? null
                                        : controller.nicknameInputListener
                                                    .value ==
                                                ''
                                            ? null
                                            : () {
                                                controller.setNickName(
                                                    controller
                                                        .nicknameInputListener
                                                        .value);
                                                Get.to(() =>
                                                    const LoginWelcomPage());
                                              },
                                    child: const Text('다음'))),
                          )
                        ],
                      )),
                ],
              )),
        ));
  }
}
