import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoopzoop/controller/mypage/myPageController.dart';
import 'package:zoopzoop/view/app.dart';

class LoginWelcomPage extends GetView<MyPageController> {
  const LoginWelcomPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 50),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(30),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: controller.userModel.value.nickName
                                        .toString(),
                                    style: const TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF4846FF)),
                                  ),
                                  const TextSpan(
                                    text: ' 님',
                                    style: TextStyle(
                                      fontSize: 28,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Text('줍줍에 참여해주셔서',
                                style: TextStyle(
                                    fontSize: 28, fontWeight: FontWeight.bold)),
                            Row(
                              children: const [
                                Text('정말 기뻐요',
                                    style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold)),
                                // todo: 이모지 리스트 넣어야함
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                    child: Column(
                  children: [
                    const Text('실시간 시그널과 커뮤니티 반응을 보고\n똑똑한 투자 라이프스타일을 만들어보세요!',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14)),
                    Container(
                        padding: const EdgeInsets.only(top: 40),
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () async {
                              await Get.to(() => const App());
                            },
                            child: const Text('줍줍 하러 가기'))),
                  ],
                ))
              ],
            ),
          ),
        ));
  }
}
