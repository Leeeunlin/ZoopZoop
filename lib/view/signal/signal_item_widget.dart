import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:zoopzoop/controller/community/communityOpinionController.dart';
import 'package:zoopzoop/controller/signal/signalController.dart';
import 'package:zoopzoop/view/community/communityOpinion.dart';

class SignalItemWidget extends GetView<SignalController> {
  const SignalItemWidget(this.index, {Key? key}) : super(key: key);
  final int? index;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InkWell(
        onTap: () async {
          await CommunityOpinionController.to
              .reload(controller.stockItemLimitList[index!].stockKey!);
          await Get.to(() => CommunityOpinion(index));
        },
        child: Card(
          shape: RoundedRectangleBorder(
            //모서리를 둥글게 하기 위해 사용
            borderRadius: BorderRadius.circular(20.0),
          ),
          margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
          child: Container(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      DateTime.now().year !=
                              controller
                                  .stockItemLimitList[index!].createDate!.year
                          ? '${DateTime.now().year - controller.stockItemLimitList[index!].createDate!.year}년 전'
                          : DateTime.now().month !=
                                  controller.stockItemLimitList[index!]
                                      .createDate!.month
                              ? '${DateTime.now().month - controller.stockItemLimitList[index!].createDate!.month}달 전'
                              : DateTime.now().day !=
                                      controller.stockItemLimitList[index!]
                                          .createDate!.day
                                  ? '${DateTime.now().day - controller.stockItemLimitList[index!].createDate!.day}일 전'
                                  : DateTime.now().hour !=
                                          controller.stockItemLimitList[index!]
                                              .createDate!.hour
                                      ? '${DateTime.now().hour - controller.stockItemLimitList[index!].createDate!.hour}시간 전'
                                      : DateTime.now().minute !=
                                              controller
                                                  .stockItemLimitList[index!]
                                                  .createDate!
                                                  .minute
                                          ? '${DateTime.now().minute - controller.stockItemLimitList[index!].createDate!.minute}분 전'
                                          : DateTime.now().second !=
                                                  controller
                                                      .stockItemLimitList[
                                                          index!]
                                                      .createDate!
                                                      .second
                                              ? '${DateTime.now().second - controller.stockItemLimitList[index!].createDate!.second}초 전'
                                              : '방금 전', // Todo: 더미 controller 이동 필요
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        controller.updateFavorite(
                            controller.stockItemLimitList[index!].stockKey!,
                            index!);
                      },
                      icon: SvgPicture.asset(
                          controller.stockItemLimitList[index!].favoriteUsers!
                                  .contains(userKey)
                              ? 'assets/icons/favorite_enable.svg'
                              : 'assets/icons/favorite_disable.svg',
                          width: 24),
                    )
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 60,
                      // height: 30,
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, top: 4, bottom: 4),
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          color: controller.stockItemLimitList[index!].ratio!
                                      .round() <
                                  10
                              ? const Color(0xFFFAFE70)
                              : const Color(0xFFBEFF00)),
                      child: Center(
                        child: Text(
                          '+ ${(controller.stockItemLimitList[index!].ratio)!.round()}%',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      '${controller.stockItemLimitList[index!].stockName}',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Text(
                      '댓글 ${controller.stockItemLimitList[index!].opinion!.toString()}', // Todo: 더미 controller 이동 필요
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
