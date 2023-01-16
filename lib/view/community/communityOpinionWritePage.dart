import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:zoopzoop/controller/community/communityOpinionController.dart';
import 'package:zoopzoop/controller/signal/signalController.dart';
import 'package:zoopzoop/utils/wordchk_search.dart';
import 'package:zoopzoop/view/community/communityOpinion.dart';
import 'package:zoopzoop/view/community/communityOpinion_Item_widget.dart';

class CommunityOpinionWritePage extends GetView<CommunityOpinionController> {
  const CommunityOpinionWritePage(this.index, {Key? key}) : super(key: key);
  final int? index;

  @override
  Widget build(BuildContext context) {
    UnderlineInputBorder border = const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent));
    return Scaffold(
      appBar: AppBar(
        title: const Text('의견'),
        leading: IconButton(
            onPressed: () async {
              Get.back();
              await controller.reload(
                  SignalController.to.stockItemLimitList[index!].stockKey!);
            },
            icon: const Icon(
              Icons.arrow_back,
            )),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: TextFormField(
                  controller: controller.opinionTextController.value,
                  onChanged: (value) {
                    controller.opinionInputListener.value = value;
                    if (wordchkSearch.contains(value)) {
                      controller.wordchkSearch.value = true;
                    } else {
                      controller.wordchkSearch.value = false;
                    }
                  },
                  keyboardType: TextInputType.multiline,
                  minLines: 1, //Normal textInputField will be displayed
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText:
                        '욕설, 비방 등 상대방을 불쾌하게 하는 의견은 남기지 말아주세요. 신고를 당하면 커뮤니티 이용이 제한될 수 있어요',
                    hintMaxLines: 4,
                    hintStyle: const TextStyle(fontSize: 14),
                    contentPadding: const EdgeInsets.all(20),
                    border: border,
                    enabledBorder: border,
                    focusedBorder: border,
                  ),
                ),
              ),
            ),
            Obx(
              () => Container(
                  decoration: const BoxDecoration(
                    border:
                        Border(top: BorderSide(width: 1, color: Colors.grey)),
                  ),
                  height: 60,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white,
                        elevation: 0,
                        side: const BorderSide(width: 0, color: Colors.white)),
                    onPressed: controller.wordchkSearch.value
                        ? null
                        : controller.opinionInputListener.value == ''
                            ? null
                            : () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return SafeArea(
                                        child: Container(
                                          height: Get.size.height / 3,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                padding: const EdgeInsets.only(
                                                  left: 20,
                                                  top: 20,
                                                ),
                                                child: const Text(
                                                  '내 기분을 선택해주세요!',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                padding: const EdgeInsets.only(
                                                  left: 20,
                                                ),
                                                child: const Text(
                                                  '기분을 표현하고 함께 공감해요 :)',
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                ),
                                              ),
                                              Obx(
                                                () => Container(
                                                  child: SingleChildScrollView(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    child: Row(
                                                      children: [
                                                        // 1번 이모티콘
                                                        InkWell(
                                                          customBorder:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                          ),
                                                          onTap: () {
                                                            controller.emoticon1
                                                                .value = true;
                                                            controller.emoticon2
                                                                .value = false;
                                                            controller.emoticon3
                                                                .value = false;
                                                            controller.emoticon4
                                                                .value = false;
                                                            controller.emoticon5
                                                                .value = false;
                                                            controller.emoticon6
                                                                .value = false;
                                                            controller.emoticon7
                                                                .value = false;
                                                            controller.emoticon8
                                                                .value = false;
                                                            controller.emoticon9
                                                                .value = false;
                                                            controller
                                                                .emoticon10
                                                                .value = false;
                                                            controller
                                                                .emoticon11
                                                                .value = false;
                                                          },
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            child: Stack(
                                                              children: [
                                                                Container(
                                                                    width: 75,
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            15),
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                50),
                                                                        color: controller.emoticon1.value
                                                                            ? Color(
                                                                                0x194846FF)
                                                                            : null), // 0x19번 10진수 10%
                                                                    child: Image
                                                                        .asset(
                                                                            'assets/emoticon/1.png')),
                                                                if (controller
                                                                    .emoticon1
                                                                    .value)
                                                                  Positioned(
                                                                    bottom: 1,
                                                                    right: 1,
                                                                    child: Container(
                                                                        height: 20,
                                                                        width: 20,
                                                                        decoration: BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(50),
                                                                          color:
                                                                              const Color(0xFF4846FF),
                                                                        ),
                                                                        child: Icon(Icons.check, color: Colors.white, size: 10)),
                                                                  )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        // 2번 이모티콘
                                                        InkWell(
                                                          customBorder:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                          ),
                                                          onTap: () {
                                                            controller.emoticon1
                                                                .value = false;
                                                            controller.emoticon2
                                                                .value = true;
                                                            controller.emoticon3
                                                                .value = false;
                                                            controller.emoticon4
                                                                .value = false;
                                                            controller.emoticon5
                                                                .value = false;
                                                            controller.emoticon6
                                                                .value = false;
                                                            controller.emoticon7
                                                                .value = false;
                                                            controller.emoticon8
                                                                .value = false;
                                                            controller.emoticon9
                                                                .value = false;
                                                            controller
                                                                .emoticon10
                                                                .value = false;
                                                            controller
                                                                .emoticon11
                                                                .value = false;
                                                          },
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            child: Stack(
                                                              children: [
                                                                Container(
                                                                    width: 75,
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            15),
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                50),
                                                                        color: controller.emoticon2.value
                                                                            ? Color(
                                                                                0x194846FF)
                                                                            : null), // 0x19번 10진수 10%
                                                                    child: Image
                                                                        .asset(
                                                                            'assets/emoticon/2.png')),
                                                                if (controller
                                                                    .emoticon2
                                                                    .value)
                                                                  Positioned(
                                                                    bottom: 1,
                                                                    right: 1,
                                                                    child: Container(
                                                                        height: 20,
                                                                        width: 20,
                                                                        decoration: BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(50),
                                                                          color:
                                                                              const Color(0xFF4846FF),
                                                                        ),
                                                                        child: Icon(Icons.check, color: Colors.white, size: 10)),
                                                                  )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        // 3번 이모티콘
                                                        InkWell(
                                                          customBorder:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                          ),
                                                          onTap: () {
                                                            controller.emoticon1
                                                                .value = false;
                                                            controller.emoticon2
                                                                .value = false;
                                                            controller.emoticon3
                                                                .value = true;
                                                            controller.emoticon4
                                                                .value = false;
                                                            controller.emoticon5
                                                                .value = false;
                                                            controller.emoticon6
                                                                .value = false;
                                                            controller.emoticon7
                                                                .value = false;
                                                            controller.emoticon8
                                                                .value = false;
                                                            controller.emoticon9
                                                                .value = false;
                                                            controller
                                                                .emoticon10
                                                                .value = false;
                                                            controller
                                                                .emoticon11
                                                                .value = false;
                                                          },
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            child: Stack(
                                                              children: [
                                                                Container(
                                                                    width: 75,
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            15),
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                50),
                                                                        color: controller.emoticon3.value
                                                                            ? Color(
                                                                                0x194846FF)
                                                                            : null), // 0x19번 10진수 10%
                                                                    child: Image
                                                                        .asset(
                                                                            'assets/emoticon/3.png')),
                                                                if (controller
                                                                    .emoticon3
                                                                    .value)
                                                                  Positioned(
                                                                    bottom: 1,
                                                                    right: 1,
                                                                    child: Container(
                                                                        height: 20,
                                                                        width: 20,
                                                                        decoration: BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(50),
                                                                          color:
                                                                              const Color(0xFF4846FF),
                                                                        ),
                                                                        child: Icon(Icons.check, color: Colors.white, size: 10)),
                                                                  )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        // 4번 이모티콘
                                                        InkWell(
                                                          customBorder:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                          ),
                                                          onTap: () {
                                                            controller.emoticon1
                                                                .value = false;
                                                            controller.emoticon2
                                                                .value = false;
                                                            controller.emoticon3
                                                                .value = false;
                                                            controller.emoticon4
                                                                .value = true;
                                                            controller.emoticon5
                                                                .value = false;
                                                            controller.emoticon6
                                                                .value = false;
                                                            controller.emoticon7
                                                                .value = false;
                                                            controller.emoticon8
                                                                .value = false;
                                                            controller.emoticon9
                                                                .value = false;
                                                            controller
                                                                .emoticon10
                                                                .value = false;
                                                            controller
                                                                .emoticon11
                                                                .value = false;
                                                          },
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            child: Stack(
                                                              children: [
                                                                Container(
                                                                    width: 75,
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            15),
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                50),
                                                                        color: controller.emoticon4.value
                                                                            ? Color(
                                                                                0x194846FF)
                                                                            : null), // 0x19번 10진수 10%
                                                                    child: Image
                                                                        .asset(
                                                                            'assets/emoticon/4.png')),
                                                                if (controller
                                                                    .emoticon4
                                                                    .value)
                                                                  Positioned(
                                                                    bottom: 1,
                                                                    right: 1,
                                                                    child: Container(
                                                                        height: 20,
                                                                        width: 20,
                                                                        decoration: BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(50),
                                                                          color:
                                                                              const Color(0xFF4846FF),
                                                                        ),
                                                                        child: Icon(Icons.check, color: Colors.white, size: 10)),
                                                                  )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        // 5q번 이모티콘
                                                        InkWell(
                                                          customBorder:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                          ),
                                                          onTap: () {
                                                            controller.emoticon1
                                                                .value = false;
                                                            controller.emoticon2
                                                                .value = false;
                                                            controller.emoticon3
                                                                .value = false;
                                                            controller.emoticon4
                                                                .value = false;
                                                            controller.emoticon5
                                                                .value = true;
                                                            controller.emoticon6
                                                                .value = false;
                                                            controller.emoticon7
                                                                .value = false;
                                                            controller.emoticon8
                                                                .value = false;
                                                            controller.emoticon9
                                                                .value = false;
                                                            controller
                                                                .emoticon10
                                                                .value = false;
                                                            controller
                                                                .emoticon11
                                                                .value = false;
                                                          },
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            child: Stack(
                                                              children: [
                                                                Container(
                                                                    width: 75,
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            15),
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                50),
                                                                        color: controller.emoticon5.value
                                                                            ? Color(
                                                                                0x194846FF)
                                                                            : null), // 0x19번 10진수 10%
                                                                    child: Image
                                                                        .asset(
                                                                            'assets/emoticon/5.png')),
                                                                if (controller
                                                                    .emoticon5
                                                                    .value)
                                                                  Positioned(
                                                                    bottom: 1,
                                                                    right: 1,
                                                                    child: Container(
                                                                        height: 20,
                                                                        width: 20,
                                                                        decoration: BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(50),
                                                                          color:
                                                                              const Color(0xFF4846FF),
                                                                        ),
                                                                        child: Icon(Icons.check, color: Colors.white, size: 10)),
                                                                  )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        // 6번 이모티콘
                                                        InkWell(
                                                          customBorder:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                          ),
                                                          onTap: () {
                                                            controller.emoticon1
                                                                .value = false;
                                                            controller.emoticon2
                                                                .value = false;
                                                            controller.emoticon3
                                                                .value = false;
                                                            controller.emoticon4
                                                                .value = false;
                                                            controller.emoticon5
                                                                .value = false;
                                                            controller.emoticon6
                                                                .value = true;
                                                            controller.emoticon7
                                                                .value = false;
                                                            controller.emoticon8
                                                                .value = false;
                                                            controller.emoticon9
                                                                .value = false;
                                                            controller
                                                                .emoticon10
                                                                .value = false;
                                                            controller
                                                                .emoticon11
                                                                .value = false;
                                                          },
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            child: Stack(
                                                              children: [
                                                                Container(
                                                                    width: 75,
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            15),
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                50),
                                                                        color: controller.emoticon6.value
                                                                            ? Color(
                                                                                0x194846FF)
                                                                            : null), // 0x19번 10진수 10%
                                                                    child: Image
                                                                        .asset(
                                                                            'assets/emoticon/6.png')),
                                                                if (controller
                                                                    .emoticon6
                                                                    .value)
                                                                  Positioned(
                                                                    bottom: 1,
                                                                    right: 1,
                                                                    child: Container(
                                                                        height: 20,
                                                                        width: 20,
                                                                        decoration: BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(50),
                                                                          color:
                                                                              const Color(0xFF4846FF),
                                                                        ),
                                                                        child: Icon(Icons.check, color: Colors.white, size: 10)),
                                                                  )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        // 7번 이모티콘
                                                        InkWell(
                                                          customBorder:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                          ),
                                                          onTap: () {
                                                            controller.emoticon1
                                                                .value = false;
                                                            controller.emoticon2
                                                                .value = false;
                                                            controller.emoticon3
                                                                .value = false;
                                                            controller.emoticon4
                                                                .value = false;
                                                            controller.emoticon5
                                                                .value = false;
                                                            controller.emoticon6
                                                                .value = false;
                                                            controller.emoticon7
                                                                .value = true;
                                                            controller.emoticon8
                                                                .value = false;
                                                            controller.emoticon9
                                                                .value = false;
                                                            controller
                                                                .emoticon10
                                                                .value = false;
                                                            controller
                                                                .emoticon11
                                                                .value = false;
                                                          },
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            child: Stack(
                                                              children: [
                                                                Container(
                                                                    width: 75,
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            15),
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                50),
                                                                        color: controller.emoticon7.value
                                                                            ? Color(
                                                                                0x194846FF)
                                                                            : null), // 0x19번 10진수 10%
                                                                    child: Image
                                                                        .asset(
                                                                            'assets/emoticon/7.png')),
                                                                if (controller
                                                                    .emoticon7
                                                                    .value)
                                                                  Positioned(
                                                                    bottom: 1,
                                                                    right: 1,
                                                                    child: Container(
                                                                        height: 20,
                                                                        width: 20,
                                                                        decoration: BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(50),
                                                                          color:
                                                                              const Color(0xFF4846FF),
                                                                        ),
                                                                        child: Icon(Icons.check, color: Colors.white, size: 10)),
                                                                  )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        // 8번 이모티콘
                                                        InkWell(
                                                          customBorder:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                          ),
                                                          onTap: () {
                                                            controller.emoticon1
                                                                .value = false;
                                                            controller.emoticon2
                                                                .value = false;
                                                            controller.emoticon3
                                                                .value = false;
                                                            controller.emoticon4
                                                                .value = false;
                                                            controller.emoticon5
                                                                .value = false;
                                                            controller.emoticon6
                                                                .value = false;
                                                            controller.emoticon7
                                                                .value = false;
                                                            controller.emoticon8
                                                                .value = true;
                                                            controller.emoticon9
                                                                .value = false;
                                                            controller
                                                                .emoticon10
                                                                .value = false;
                                                            controller
                                                                .emoticon11
                                                                .value = false;
                                                          },
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            child: Stack(
                                                              children: [
                                                                Container(
                                                                    width: 75,
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            15),
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                50),
                                                                        color: controller.emoticon8.value
                                                                            ? Color(
                                                                                0x194846FF)
                                                                            : null), // 0x19번 10진수 10%
                                                                    child: Image
                                                                        .asset(
                                                                            'assets/emoticon/8.png')),
                                                                if (controller
                                                                    .emoticon8
                                                                    .value)
                                                                  Positioned(
                                                                    bottom: 1,
                                                                    right: 1,
                                                                    child: Container(
                                                                        height: 20,
                                                                        width: 20,
                                                                        decoration: BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(50),
                                                                          color:
                                                                              const Color(0xFF4846FF),
                                                                        ),
                                                                        child: Icon(Icons.check, color: Colors.white, size: 10)),
                                                                  )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        // 9번 이모티콘
                                                        InkWell(
                                                          customBorder:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                          ),
                                                          onTap: () {
                                                            controller.emoticon1
                                                                .value = false;
                                                            controller.emoticon2
                                                                .value = false;
                                                            controller.emoticon3
                                                                .value = false;
                                                            controller.emoticon4
                                                                .value = false;
                                                            controller.emoticon5
                                                                .value = false;
                                                            controller.emoticon6
                                                                .value = false;
                                                            controller.emoticon7
                                                                .value = false;
                                                            controller.emoticon8
                                                                .value = false;
                                                            controller.emoticon9
                                                                .value = true;
                                                            controller
                                                                .emoticon10
                                                                .value = false;
                                                            controller
                                                                .emoticon11
                                                                .value = false;
                                                          },
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            child: Stack(
                                                              children: [
                                                                Container(
                                                                    width: 75,
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            15),
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                50),
                                                                        color: controller.emoticon9.value
                                                                            ? Color(
                                                                                0x194846FF)
                                                                            : null), // 0x19번 10진수 10%
                                                                    child: Image
                                                                        .asset(
                                                                            'assets/emoticon/9.png')),
                                                                if (controller
                                                                    .emoticon9
                                                                    .value)
                                                                  Positioned(
                                                                    bottom: 1,
                                                                    right: 1,
                                                                    child: Container(
                                                                        height: 20,
                                                                        width: 20,
                                                                        decoration: BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(50),
                                                                          color:
                                                                              const Color(0xFF4846FF),
                                                                        ),
                                                                        child: Icon(Icons.check, color: Colors.white, size: 10)),
                                                                  )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        // 10번 이모티콘
                                                        InkWell(
                                                          customBorder:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                          ),
                                                          onTap: () {
                                                            controller.emoticon1
                                                                .value = false;
                                                            controller.emoticon2
                                                                .value = false;
                                                            controller.emoticon3
                                                                .value = false;
                                                            controller.emoticon4
                                                                .value = false;
                                                            controller.emoticon5
                                                                .value = false;
                                                            controller.emoticon6
                                                                .value = false;
                                                            controller.emoticon7
                                                                .value = false;
                                                            controller.emoticon8
                                                                .value = false;
                                                            controller.emoticon9
                                                                .value = false;
                                                            controller
                                                                .emoticon10
                                                                .value = true;
                                                            controller
                                                                .emoticon11
                                                                .value = false;
                                                          },
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            child: Stack(
                                                              children: [
                                                                Container(
                                                                    width: 75,
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            15),
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                50),
                                                                        color: controller.emoticon10.value
                                                                            ? Color(
                                                                                0x194846FF)
                                                                            : null), // 0x19번 10진수 10%
                                                                    child: Image
                                                                        .asset(
                                                                            'assets/emoticon/10.png')),
                                                                if (controller
                                                                    .emoticon10
                                                                    .value)
                                                                  Positioned(
                                                                    bottom: 1,
                                                                    right: 1,
                                                                    child: Container(
                                                                        height: 20,
                                                                        width: 20,
                                                                        decoration: BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(50),
                                                                          color:
                                                                              const Color(0xFF4846FF),
                                                                        ),
                                                                        child: Icon(Icons.check, color: Colors.white, size: 10)),
                                                                  )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        // 11번 이모티콘
                                                        InkWell(
                                                          customBorder:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                          ),
                                                          onTap: () {
                                                            controller.emoticon1
                                                                .value = false;
                                                            controller.emoticon2
                                                                .value = false;
                                                            controller.emoticon3
                                                                .value = false;
                                                            controller.emoticon4
                                                                .value = false;
                                                            controller.emoticon5
                                                                .value = false;
                                                            controller.emoticon6
                                                                .value = false;
                                                            controller.emoticon7
                                                                .value = false;
                                                            controller.emoticon8
                                                                .value = false;
                                                            controller.emoticon9
                                                                .value = false;
                                                            controller
                                                                .emoticon10
                                                                .value = false;
                                                            controller
                                                                .emoticon11
                                                                .value = true;
                                                          },
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            child: Stack(
                                                              children: [
                                                                Container(
                                                                    width: 75,
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            15),
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                50),
                                                                        color: controller.emoticon11.value
                                                                            ? Color(
                                                                                0x194846FF)
                                                                            : null), // 0x19번 10진수 10%
                                                                    child: Image
                                                                        .asset(
                                                                            'assets/emoticon/11.png')),
                                                                if (controller
                                                                    .emoticon11
                                                                    .value)
                                                                  Positioned(
                                                                    bottom: 1,
                                                                    right: 1,
                                                                    child: Container(
                                                                        height: 20,
                                                                        width: 20,
                                                                        decoration: BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(50),
                                                                          color:
                                                                              const Color(0xFF4846FF),
                                                                        ),
                                                                        child: Icon(Icons.check, color: Colors.white, size: 10)),
                                                                  )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                decoration: const BoxDecoration(
                                                  border: Border(
                                                      top: BorderSide(
                                                          width: 1,
                                                          color: Colors.grey)),
                                                ),
                                                height: 60,
                                                width: double.infinity,
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          foregroundColor:
                                                              Colors.black,
                                                          backgroundColor:
                                                              Colors.white,
                                                          elevation: 0,
                                                          side:
                                                              const BorderSide(
                                                                  width: 0,
                                                                  color: Colors
                                                                      .white)),
                                                  onPressed: () {
                                                    controller.setOpinion(
                                                        SignalController
                                                            .to
                                                            .stockItemLimitList[
                                                                index!]
                                                            .stockKey!,
                                                        index!);
                                                    controller.reload(
                                                        SignalController
                                                            .to
                                                            .stockItemLimitList[
                                                                index!]
                                                            .stockKey!);
                                                    Get.back(); // 팝업닫기
                                                    Get.back(); // 페이지뒤로 넘어가기
                                                  },
                                                  child: const Text(
                                                    '확인',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              },
                    child: const Text(
                      '게시하기',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
