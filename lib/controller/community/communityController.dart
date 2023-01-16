import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoopzoop/model/community/communityModel.dart';
import 'package:zoopzoop/utils/data_keys.dart';

class CommunityController extends GetxController {
  static CommunityController get to => Get.find();
  static List<dynamic> lastVisible = [];

  // 무한스크롤 관련 UI 스크롤 컨트롤러
  Rx<ScrollController> scrollController = ScrollController().obs;
  // 무한스크롤 데이터가 있는지 확인
  RxBool hasMore = false.obs;
  // 무한스크롤 데이터 로딩중
  RxBool isLoading = false.obs;

    RxList<CommunityModel> communityItemAllList = <CommunityModel>[].obs;
      RxList itemsDetectorKey = [].obs;
  RxList<CommunityModel> communityItemLimitList = <CommunityModel>[].obs;

  @override
  void onInit() async {
    if (!isLoading.value) {
      // await reload();
      isLoading(true);
      update();
    }

    // 무한스크롤 부분 ▼ 스크롤이 최 하단으로 이동할 것을 계속 보고있다가 스크롤이 끝나면 새로운 데이터 로딩
    scrollController.value.addListener(() {
      if (scrollController.value.position.pixels ==
              scrollController.value.position.maxScrollExtent &&
          hasMore.value) {
        getData();
      }
    });
    super.onInit();
  }

    getData() async {
    isLoading.value = true;

    int offset = communityItemLimitList.length;

    // communityItemLimitList.addAll(await getCommunityItemLimitList(offset));

    isLoading.value = false;
    hasMore.value = communityItemLimitList.length <
        communityItemAllList.length; // 전체 개수와 새로 불러와 적제되어있는 리스트의 개수가 같으면 완료
  }

  reload() async {
    communityItemAllList.clear();
    communityItemLimitList.clear();
    itemsDetectorKey.clear();
    communityItemAllList.addAll(await getCommunityItemAllList('stockKey')); // todo : ui에서 stockKey 가져와야함
    getData();
  }

Future<List<CommunityModel>> getCommunityItemAllList(String stockKey) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection(COL_COMMUNITY).where(FIELD_STOCKKEY, isEqualTo: stockKey)
        .orderBy(FIELD_CREATEDATE, descending: true)
        .get(); // orderby 를 통해 sort작업을 한다. 기존 Linq 방식과 동일

    Map<String, dynamic> tmp = {};

    for (QueryDocumentSnapshot<Map<String, dynamic>> doc
        in querySnapshot.docs) {
      tmp[doc.id] = {CommunityModel.fromJson(doc.data())};
    } // 스냅샷을 가져와 tmp리스트에 넣을때 1차가공
    List<CommunityModel> items = [];

    for (int i = 0; i < tmp.length; i++) {
      itemsDetectorKey.add(tmp.keys.elementAt(i));
      items.add(tmp.values
          .elementAt(i)
          .cast<CommunityModel>()
          .elementAt(0)); // 필요한 모델만 따로 items리스트에 추가
    }

    return items;
  }


}
