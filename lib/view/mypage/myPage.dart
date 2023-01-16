import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoopzoop/controller/mypage/myPageController.dart';
import 'package:zoopzoop/view/mypage/myPageSetting.dart';
import 'package:zoopzoop/view/mypage/my_nickname.dart';

class MyPage extends GetView<MyPageController> {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 100,
            automaticallyImplyLeading: false,
            title: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      Obx(
                        () => RichText(
                            text: TextSpan(
                                style: const TextStyle(
                                  fontFamily: 'SpoqaHanSansNeo',
                                ),
                                children: [
                              TextSpan(
                                text: '${controller.userModel.value.nickName}',
                                style: const TextStyle(
                                    fontSize: 24,
                                    color: Color(0xFF4846FF),
                                    fontWeight: FontWeight.bold),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    await Get.to(() => const MyNickName());
                                  },
                              ),
                              const TextSpan(
                                text: ' 님,',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold),
                              )
                            ])),
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            Get.to(() => const MyPageSetting());
                          },
                          icon: const Icon(
                            Icons.settings,
                            color: Colors.grey,
                          ))
                    ],
                  ),
                  //
                ),
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    '줍줍하러 오셨군요',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            bottom: TabBar(
                indicatorColor: Colors.black,
                indicatorWeight: 5,
                tabs: <Widget>[
                  Tab(
                      child: Column(
                    children: const [
                      Text(
                        'test1',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      Text('줍줍 종목', style: TextStyle(color: Colors.grey))
                    ],
                  )),
                  Tab(
                      child: Column(
                    children: const [
                      Text(
                        'test1',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      Text('내 댓글', style: TextStyle(color: Colors.grey))
                    ],
                  )),
                  Tab(
                      child: Column(
                    children: const [
                      Text(
                        'test1',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      Text('최근 본 종목', style: TextStyle(color: Colors.grey))
                    ],
                  ))
                ]),
          ),
          body: const TabBarView(
            children: [
              Text(
                'test',
              ),
              Text(
                'test2',
              ),
              Text(
                'test3',
              ),
            ],
          ),
        ));
  }
}
