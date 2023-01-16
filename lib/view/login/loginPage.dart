import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoopzoop/view/app.dart';
import 'package:zoopzoop/controller/auth/authController.dart';
import 'package:zoopzoop/model/user/userModel.dart';
import 'package:zoopzoop/view/community/communityPage.dart';
import 'package:zoopzoop/view/login/loginNickNamePage.dart';
import 'package:zoopzoop/view/mypage/privacy_policy.dart';
import 'package:zoopzoop/view/mypage/terms_of_service.dart';

class LoginPage extends GetView<AuthController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
            automaticallyImplyLeading: false, backgroundColor: Colors.black),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(30),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 메인화면 첫줄 글자
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    '가치를\n발견하는\n즐거움.',
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFF3F3F3),
                    ),
                  ),
                ),
                // 메인로고 우측정렬사용을 위해 row 이용
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                          width: Get.size.width / 2,
                          child: Image.asset('assets/images/mainpagelogo.png')),
                    ],
                  ),
                ),
                // 로그인버튼과 개인정보 처리방침 문구 해당 버튼의 사이즈조절을위한 좌우측 패딩 정렬 적용
                Container(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Column(
                      children: [
                        SizedBox(
                          // 구글 로그인
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            onPressed: () async {
                              await controller.loginGoogle();
                              if (controller.userModel.value.userKey != null) {
                                if (controller.userModel.value.nickName == '') {
                                  await Get.to(() => const LoginNickNamePage());
                                } else {
                                  await Get.to(() => const App());
                                }
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.all(13),
                                  height: 44,
                                  width: 44,
                                  child: Container(
                                    // 안족 아이콘의 이미지 사이즈 조절을 위한 컨테이너 생성
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/icons/google_login_icon.png'))),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.only(right: 30),
                                    child: const Text(
                                      'Google 계정으로 로그인',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Center(
                            child: RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                  fontFamily: 'SpoqaHanSansNeo',
                                  color: Colors.grey,
                                ),
                                children: [
                                  const TextSpan(
                                    text: '로그인 시 ',
                                  ),
                                  TextSpan(
                                    text: '개인정보처리방침',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () async {
                                        // Todo: 개인정보 처리방침
                                        await Get.to(
                                            () => const PrivacyPolicy());
                                      },
                                  ),
                                  const TextSpan(
                                    text: '과 ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: Colors.grey),
                                  ),
                                  TextSpan(
                                    text: '서비스이용약관',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () async {
                                        await Get.to(
                                            () => const TermsOfService());
                                      },
                                  ),
                                  const TextSpan(
                                    text: '에 동의한 것으로 간주 합니다.',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ));
  }
}
