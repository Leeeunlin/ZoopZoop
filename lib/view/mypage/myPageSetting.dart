import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zoopzoop/controller/mypage/myPageController.dart';
import 'package:zoopzoop/main.dart';
import 'package:zoopzoop/view/login/loginPage.dart';
import 'package:zoopzoop/view/mypage/my_nickname.dart';
import 'package:zoopzoop/view/mypage/privacy_policy.dart';
import 'package:zoopzoop/view/mypage/terms_of_service.dart';

class MyPageSetting extends GetView<MyPageController> {
  const MyPageSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Container settingTitle(String title) {
      return Container(
          color: Colors.white,
          width: double.infinity,
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Text(title));
    }

    InkWell settingSubtitle(
      String subTitle,
      Widget page,
    ) {
      return InkWell(
          onTap: () {
            Get.to(() => page);
          },
          child: Container(
              color: Colors.white,
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        subTitle,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const Spacer(),
                      const Icon(Icons.arrow_forward_ios,
                          color: Colors.grey, size: 16)
                    ],
                  )
                ],
              )));
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('환경설정')),
      body: SafeArea(
        child: Column(
          children: [
            settingTitle('프로필'),
            settingSubtitle('내 정보 수정', const MyNickName()),
            const SizedBox(
              height: 10,
            ),
            settingTitle('고객지원'),
            InkWell(
                onTap: () {
                  _sendEmail();
                },
                child: Container(
                    color: Colors.white,
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          children: const [
                            Text(
                              '고객센터',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Spacer(),
                            Icon(Icons.arrow_forward_ios,
                                color: Colors.grey, size: 16)
                          ],
                        )
                      ],
                    ))),
            const SizedBox(
              height: 10,
            ),
            settingTitle('약관 및 정책'),
            settingSubtitle('이용약관', const TermsOfService()),
            settingSubtitle('개인정보 처리방침', const PrivacyPolicy()),
            ElevatedButton(
                onPressed: () {
                  GoogleSignIn().signOut();
                  Get.offAll(const LoginPage());
                },
                child: Text('로그아웃')),
            Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                child: Text('v 1.0.0',
                    textAlign: TextAlign.end)) // Todo: 버전체크 업데이트 적용해야함
          ],
        ),
      ),
    );
  }

  void _sendEmail() async {
    final Email email = Email(
      body:
          '- 계정(이메일주소):\n\n- 연락처:\n\n\n\n문의내용을 작성해 주세요.\n\n공휴일 제외한 72시간 이내 보내주신 이메일 주소로 회신드리겠습니다.',
      subject: '[ZOOPZOOP 문의]',
      recipients: ['메일주소넣기'],
      cc: [],
      bcc: [],
      attachmentPaths: [],
      isHTML: false,
    );
    try {
      await FlutterEmailSender.send(email);
    } catch (error) {
      String title = '기본 메일 앱을 사용할 수 없습니다.';
      String message = '아래 이메일로 연락주시면 답변드리겠습니다.\n메일주소넣기';
      detectorDialog(title, message);
    }
  }

  void detectorDialog(String title, String message) async {
    await Get.defaultDialog(
      title: title,
      middleText: message,
      actions: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                foregroundColor: Colors.red,
                backgroundColor: Colors.black.withOpacity(0),
                shadowColor: Colors.black.withOpacity(0)),
            onPressed: () {
              Get.back(); // 팝업창 닫기
            },
            child: const Text('닫기')),
      ],
    );
  }
}
