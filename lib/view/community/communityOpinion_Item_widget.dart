import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:zoopzoop/controller/community/communityOpinionController.dart';
import 'package:zoopzoop/repository/userRepository.dart';

class CommunityOpinionItemWidget extends GetView<CommunityOpinionController> {
  const CommunityOpinionItemWidget(this.index, {Key? key}) : super(key: key);
  final int? index;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Card(
        shape: RoundedRectangleBorder(
          //모서리를 둥글게 하기 위해 사용
          borderRadius: BorderRadius.circular(20.0),
        ),
        margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        child: Container(
            padding:
                const EdgeInsets.only(left: 20, top: 20, bottom: 20, right: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Text(
                        DateTime.now().year !=
                                controller.communityItemSelectLimitList[index!]
                                    .createDate!.year
                            ? '${DateTime.now().year - controller.communityItemSelectLimitList[index!].createDate!.year}년 전'
                            : DateTime.now().month !=
                                    controller
                                        .communityItemSelectLimitList[index!]
                                        .createDate!
                                        .month
                                ? '${DateTime.now().month - controller.communityItemSelectLimitList[index!].createDate!.month}달 전'
                                : DateTime.now().day !=
                                        controller
                                            .communityItemSelectLimitList[
                                                index!]
                                            .createDate!
                                            .day
                                    ? '${DateTime.now().day - controller.communityItemSelectLimitList[index!].createDate!.day}일 전'
                                    : DateTime.now().hour !=
                                            controller
                                                .communityItemSelectLimitList[
                                                    index!]
                                                .createDate!
                                                .hour
                                        ? '${DateTime.now().hour - controller.communityItemSelectLimitList[index!].createDate!.hour}시간 전'
                                        : DateTime.now().minute !=
                                                controller
                                                    .communityItemSelectLimitList[
                                                        index!]
                                                    .createDate!
                                                    .minute
                                            ? '${DateTime.now().minute - controller.communityItemSelectLimitList[index!].createDate!.minute}분 전'
                                            : DateTime.now().second !=
                                                    controller
                                                        .communityItemSelectLimitList[
                                                            index!]
                                                        .createDate!
                                                        .second
                                                ? '${DateTime.now().second - controller.communityItemSelectLimitList[index!].createDate!.second}초 전'
                                                : '방금 전',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                    PopupMenuButton(
                      itemBuilder: (BuildContext context) => [
                        if (controller
                                .communityItemSelectLimitList[index!].userKey ==
                            userKey)
                          PopupMenuItem(
                            child: InkWell(
                                onTap: () {
                                  controller.deleteOpinion(controller
                                      .communityItemSelectLimitList[index!]
                                      .communityKey!);
                                },
                                child: Text('게시글 삭제')),
                          )
                      ],
                    )
                    // IconButton(
                    //     padding: EdgeInsets.zero,
                    //     constraints: BoxConstraints(),
                    //     onPressed: () {
                    //       controller.deleteOpinion(controller
                    //           .communityItemSelectLimitList[index!]
                    //           .communityKey!);
                    //     },
                    //     icon: const Icon(
                    //       Icons.more_horiz,
                    //       color: Colors.grey,
                    //     )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        children: [
                          Text(
                              '${controller.communityItemSelectLimitList[index!].nickName}',
                              style: TextStyle(color: Colors.grey)),
                          if (controller.communityItemSelectLimitList[index!]
                                  .userKey ==
                              userKey)
                            Text(
                              '(내가 작성)',
                              style: TextStyle(color: Colors.grey),
                            )
                        ],
                      ),
                    ),
                    Stack(
                      children: [
                        Container(
                            width: 50,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 20,
                                  offset: Offset(
                                      0, 5), // changes position of shadow
                                ),
                              ],
                            ),
                            child:
                                Image.asset('assets/images/favoriteCount.png')),
                        Container(
                            padding: EdgeInsets.only(top: 5),
                            width: 50,
                            alignment: Alignment.center,
                            child: Text(
                              controller.communityItemSelectLimitList[index!]
                                  .favoriteCount
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ))
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 60,
                        child: AutoSizeText(
                          '${controller.communityItemSelectLimitList[index!].comment}', // Todo: 더미 controller 이동 필요
                          maxLines: 2,
                          minFontSize: 16,
                          maxFontSize: 16,
                          // overflow: TextOverflow.ellipsis,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        controller.setLike(
                            controller.communityItemSelectLimitList[index!]
                                .communityKey!,
                            index!);
                      },
                      child: SizedBox(
                          width: 50,
                          child: Image.asset(controller
                              .communityItemSelectLimitList[index!].emoticon
                              .toString())),
                    )
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
