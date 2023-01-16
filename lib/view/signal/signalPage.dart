import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:zoopzoop/controller/signal/signalController.dart';
import 'package:zoopzoop/view/signal/signal_item_widget.dart';

class SignalPage extends GetView<SignalController> {
  const SignalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF1F2),
      appBar: AppBar(
          backgroundColor: const Color(0xFFEFF1F2),
          toolbarHeight: 0), // system설정 컬러 아이폰에서 설정 불가로 강제 appbar 삽입
      // 탭 바 숨기는 위젯 nestedscrollview > sliverAppbar로 상단탭 정리 아래 CustomScrollView와 연결해야함

      body: SafeArea(
        child: RefreshIndicator(
            onRefresh: () async {
              await controller.reload();
            },
            child: CustomScrollView(
              controller: controller.scrollController.value,
              slivers: [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: const Color(0xFFEFF1F2),
                  floating: true,
                  snap: true,
                  title: Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Container(
                          child: Row(
                            children: [
                              const Text(
                                '줍줍 시그널',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'SpoqaHanSansNeo',
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                padding:
                                    const EdgeInsets.only(left: 10, top: 4),
                                constraints: const BoxConstraints(),
                                onPressed: () {},
                                icon: SvgPicture.asset(
                                  'assets/icons/help_icon.svg',
                                ),
                              ),
                              const Spacer(),
                              IconButton(
                                onPressed: () {},
                                icon: SvgPicture.asset(
                                  'assets/icons/alert_disable.svg', // todo: alert 컨트롤러에 맞춰 수정 필요
                                  width: 30,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(60.0),
                    child: Obx(
                      () => SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                if (controller.favoriteFilter.value == false) {
                                  controller.favoriteFilter.value = true;
                                } else {
                                  controller.favoriteFilter.value = false;
                                }
                              },
                              child: Container(
                                  margin: const EdgeInsets.only(
                                      top: 10, bottom: 10, left: 5),
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10, right: 20, left: 20),
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(50)),
                                    color: controller.favoriteFilter.value
                                        ? Colors.black
                                        : Colors.white,
                                    border: Border.all(
                                      color: const Color.fromRGBO(
                                          217, 217, 217, 1),
                                      width: 1,
                                    ),
                                  ),
                                  child: Text('줍줍 많은 순',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: controller.favoriteFilter.value
                                            ? Colors.white
                                            : Colors.black,
                                      ))),
                            ),
                            InkWell(
                              onTap: () {
                                if (controller.commentFilter.value == false) {
                                  controller.commentFilter.value = true;
                                } else {
                                  controller.commentFilter.value = false;
                                }
                              },
                              child: Container(
                                  margin: const EdgeInsets.only(
                                      top: 10, bottom: 10, left: 5),
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10, right: 20, left: 20),
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(50)),
                                    color: controller.commentFilter.value
                                        ? Colors.black
                                        : Colors.white,
                                    border: Border.all(
                                      color: const Color.fromRGBO(
                                          217, 217, 217, 1),
                                      width: 1,
                                    ),
                                  ),
                                  child: Text('댓글 많은 순',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: controller.commentFilter.value
                                            ? Colors.white
                                            : Colors.black,
                                      ))),
                            ),
                            InkWell(
                              onTap: () {
                                if (controller.below10Filter.value == false) {
                                  controller.below10Filter.value = true;
                                } else {
                                  controller.below10Filter.value = false;
                                }
                              },
                              child: Container(
                                margin: const EdgeInsets.only(
                                    top: 10, bottom: 10, left: 5),
                                padding: const EdgeInsets.only(
                                    top: 10, bottom: 10, right: 20, left: 20),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(50)),
                                  color: controller.below10Filter.value
                                      ? Colors.black
                                      : Colors.white,
                                  border: Border.all(
                                    color:
                                        const Color.fromRGBO(217, 217, 217, 1),
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  '10% 이하',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: controller.below10Filter.value
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                if (controller.over10Filter.value == false) {
                                  controller.over10Filter.value = true;
                                } else {
                                  controller.over10Filter.value = false;
                                }
                              },
                              child: Container(
                                margin: const EdgeInsets.only(
                                    top: 10, bottom: 10, left: 5),
                                padding: const EdgeInsets.only(
                                    top: 10, bottom: 10, right: 20, left: 20),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(50)),
                                  color: controller.over10Filter.value
                                      ? Colors.black
                                      : Colors.white,
                                  border: Border.all(
                                    color:
                                        const Color.fromRGBO(217, 217, 217, 1),
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  '10% 이상',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: controller.over10Filter.value
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => SliverList(
                      delegate: SliverChildBuilderDelegate(
                    (_, index) {
                      if (index < controller.stockItemLimitList.length) {
                        return SignalItemWidget(index);
                      }
                      if (controller.hasMore.value ||
                          controller.isLoading.value) {
                        return const Center(child: RefreshProgressIndicator());
                      }
                      return Container();
                    },
                    childCount: controller.stockItemLimitList.length + 1,
                  )),
                )
              ],
            )),
      ),
    );
  }
}
