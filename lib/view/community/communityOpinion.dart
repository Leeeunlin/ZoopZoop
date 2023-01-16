import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:zoopzoop/controller/community/communityOpinionController.dart';
import 'package:zoopzoop/controller/signal/signalController.dart';
import 'package:zoopzoop/view/community/communityOpinionWritePage.dart';
import 'package:zoopzoop/view/community/communityOpinion_Item_widget.dart';

class CommunityOpinion extends GetView<CommunityOpinionController> {
  const CommunityOpinion(this.index, {Key? key}) : super(key: key);
  final int? index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () async {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
            )),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(),
            Text(
              SignalController.to.stockItemLimitList[index!].stockName
                  .toString(),
            ),
            Obx(
              () => IconButton(
                onPressed: () {
                  SignalController.to.updateFavorite(
                      SignalController.to.stockItemLimitList[index!].stockKey!,
                      index!);
                },
                icon: SvgPicture.asset(
                    SignalController
                            .to.stockItemLimitList[index!].favoriteUsers!
                            .contains(userKey)
                        ? 'assets/icons/favorite_enable.svg'
                        : 'assets/icons/favorite_disable.svg',
                    width: 24),
              ),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await controller.reload(
                      SignalController.to.stockItemLimitList[index!].stockKey!);
                },
                child: Container(
                  color: const Color(0xFFEFF1F2),
                  child: CustomScrollView(
                      controller: controller.scrollController.value,
                      slivers: <Widget>[
                        SliverAppBar(
                          automaticallyImplyLeading: false,
                          floating: true,
                          snap: true,
                          title: Container(
                            padding: const EdgeInsets.all(20),
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 60,
                                  height: 30,
                                  padding: const EdgeInsets.only(
                                      left: 8, right: 8, top: 4, bottom: 4),
                                  margin: const EdgeInsets.only(right: 8),
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      color: SignalController
                                                  .to
                                                  .stockItemLimitList[index!]
                                                  .ratio!
                                                  .round() <
                                              10
                                          ? const Color(0xFFFAFE70)
                                          : const Color(0xFFBEFF00)),
                                  child: Center(
                                    child: Text(
                                      '${(SignalController.to.stockItemLimitList[index!].ratio)!.round()}%',
                                      style: const TextStyle(
                                        fontFamily: 'SpoqaHanSansNeo',
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                const Text('이상 상승',
                                    style: TextStyle(
                                        fontSize: 26,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'SpoqaHanSansNeo')),
                                SizedBox(
                                    width: 30,
                                    child: Image.asset(
                                        'assets/icons/trenging_up_outline.gif'))
                              ],
                            ),
                          ),
                        ),
                        Obx(
                          () => SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (_, index) {
                                if (index <
                                    controller
                                        .communityItemSelectLimitList.length) {
                                  return CommunityOpinionItemWidget(index);
                                }
                                if (controller.hasMore.value ||
                                    controller.isLoading.value) {
                                  return const Center(
                                      child: RefreshProgressIndicator());
                                }
                                return Container();
                              },
                              childCount: controller
                                      .communityItemSelectLimitList.length +
                                  1,
                            ),
                          ),
                        ),
                      ]),
                ),
              ),
            ),
            InkWell(
                onTap: () async {
                  await Get.to(() => CommunityOpinionWritePage(index));
                },
                child: Container(
                    padding: const EdgeInsets.all(20),
                    height: 60,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/icons/write_icon.svg',
                            width: 20),
                        const SizedBox(width: 8),
                        const Text('의견쓰기',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ))),
          ],
        ),
      ),
    );
  }
}
