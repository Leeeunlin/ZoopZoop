import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoopzoop/controller/community/communityController.dart';

class CommunityItemWidget extends GetView<CommunityController> {
  const CommunityItemWidget(this.index, {Key? key}) : super(key: key);
  final int? index;

  @override
  Widget build(BuildContext context) {
    AlertDialog overCheckDialog() {
      return AlertDialog(
          titlePadding: EdgeInsets.zero,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          title: Container(
            padding: const EdgeInsets.only(top: 30),
            child: SizedBox(
              width: Get.size.width * 0.9,
              child: const Text(
                '최대 공감 갯수 초과!',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          content: const SizedBox(
            width: double.infinity,
            child: Text(
              '게시물당 5번 공감하실 수 있어요.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF586270),
                height: 1.5,
              ),
            ),
          ),
          actions: <Widget>[
            Center(
              child: Container(
                width: double.infinity,
                height: 70,
                padding: const EdgeInsets.only(right: 30, left: 30, bottom: 20),
                child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text('확인')),
              ),
            )
          ]);
    }

    return InkWell(
      onTap: () {},
      child: Card(
        shape: RoundedRectangleBorder(
          //모서리를 둥글게 하기 위해 사용
          borderRadius: BorderRadius.circular(20.0),
        ),
        margin: const EdgeInsets.only(left: 20, right: 20, top: 15),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 24,
                      margin: const EdgeInsets.only(right: 8),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: Color(0xFFBEFF00),
                      ),
                      child: const Center(
                        child: Text(
                          '5%', // Todo: 더미 controller 이동 필요
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2F2DBE)),
                        ),
                      ),
                    ),
                    const Text(
                      '종목이름 : 상승퍼센트', // Todo: 더미 controller 이동 필요
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    const Text('시간 값', // Todo: 더미 controller 이동 필요
                        style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    const Text('유저이름', // Todo: 더미 controller 이동 필요
                        style: TextStyle(color: Colors.grey)),
                    const Spacer(),
                    Container(
                      width: 43,
                      height: 28,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                        color: Color(0xFFF0F0FF),
                      ),
                      child: Center(
                        child: Obx(
                          () => Text(
                            '', // todo: 좋아요 갯수
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                  child: Row(
                children: [
                  const Expanded(
                    child: SizedBox(
                      height: 60,
                      child: AutoSizeText(
                        '오늘 11프로 먹고려asdfasasdfasdfasdfadsfadfasdfasdfasdfasdfasdfasdfasdf고ㅇㅇㅇ', // Todo: 더미 controller 이동 필요
                        maxLines: 2,
                        minFontSize: 16,
                        maxFontSize: 16,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  InkWell(
                    onTap: () {
                      if (0 < 5) {
                        // todo : 좋아요 갯수
                      } else {
                        Get.dialog(overCheckDialog());
                      }
                    },
                    child: Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/emoticon/1.png'),
                              fit: BoxFit.fitWidth),
                        )),
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
