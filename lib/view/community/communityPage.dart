import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:zoopzoop/controller/community/communityController.dart';
import 'package:zoopzoop/view/community/community_item_widget.dart';

class CommunityPage extends GetView<CommunityController> {
  const CommunityPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AlertDialog helpDialog() {
      return AlertDialog(
        titlePadding: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        title: ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            child: Image.asset('assets/images/communityHelp.png')),
        content: const SizedBox(
          width: double.infinity,
          child: Text(
            '시그널 종목별 실시간 댓글들을 모아서 보고 내기분에 함께 공감해주세요!',
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
        ],
      );
    }

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
                  child: Row(
                    children: [
                      const Text(
                        '줍줍 커뮤니티',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'SpoqaHanSansNeo',
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        padding: const EdgeInsets.only(left: 10, top: 4),
                        constraints: const BoxConstraints(),
                        onPressed: () {
                          Get.dialog(helpDialog());
                        },
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
                ),
              ),
              SliverToBoxAdapter(
                  child: Container(
                      width: double.infinity,
                      height: Get.size.height / 4,
                      color: const Color(0xFF4846FF),
                      child: Text(
                        '시그널 텍스트 공감 댓글',
                        style: TextStyle(color: Colors.white),
                      ))),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (_, index) {
                    if (index < controller.communityItemAllList.length) {
                      return CommunityItemWidget(index);
                    }
                    if (controller.hasMore.value ||
                        controller.isLoading.value) {
                      return const Center(child: RefreshProgressIndicator());
                    }
                    return Container();
                  },
                  childCount: controller.communityItemAllList.length + 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
