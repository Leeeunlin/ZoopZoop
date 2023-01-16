import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:zoopzoop/controller/bottomNavigationController.dart';
import 'package:zoopzoop/view/community/communityPage.dart';
import 'package:zoopzoop/view/mypage/myPage.dart';
import 'package:zoopzoop/view/signal/signalPage.dart';
import 'package:zoopzoop/view/test.dart';

class App extends GetView<BottomNavigationController> {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.willPopAction,
      child: Obx(
        () => Scaffold(
          body: IndexedStack(
            index: controller.pageIndex.value,
            children: const [
              CommunityPage(),
              SignalPage(),
              MyPage(),
            ],
          ),
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
                border:
                    Border(top: BorderSide(color: Colors.black38, width: 1))),
            child: BottomNavigationBar(
                backgroundColor: Colors.white,
                type: BottomNavigationBarType.fixed,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                currentIndex: controller.pageIndex.value,
                elevation: 0,
                onTap: controller.changeBottomNav,
                items: [
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      'assets/icons/community_disable.svg',
                      width: 40,
                    ),
                    activeIcon: SvgPicture.asset(
                      'assets/icons/community_enable.svg',
                      width: 40,
                    ),
                    label: '커뮤니티',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      'assets/icons/signal_disable.svg',
                      width: 40,
                    ),
                    activeIcon: SvgPicture.asset(
                      'assets/icons/signal_enable.svg',
                      width: 40,
                    ),
                    label: '시그널',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      'assets/icons/mypage_disable.svg',
                      width: 40,
                    ),
                    activeIcon: SvgPicture.asset(
                      'assets/icons/mypage_enable.svg',
                      width: 40,
                    ),
                    label: '마이 페이지',
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
