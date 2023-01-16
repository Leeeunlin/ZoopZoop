import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoopzoop/model/stock/stockModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zoopzoop/utils/data_keys.dart';

final String userKey = FirebaseAuth.instance.currentUser!.uid;

class SignalController extends GetxController {
  static SignalController get to => Get.find();
  static List<dynamic> lastVisible = [];

  RxBool favoriteFilter = false.obs;
  RxBool commentFilter = false.obs;
  RxBool over10Filter = false.obs;
  RxBool below10Filter = false.obs;

  // 무한스크롤 관련 UI 스크롤 컨트롤러
  Rx<ScrollController> scrollController = ScrollController().obs;
  // 무한스크롤 데이터가 있는지 확인
  RxBool hasMore = false.obs;
  // 무한스크롤 데이터 로딩중
  RxBool isLoading = false.obs;

  // DB 리스트 전체
  RxList<StockModel> stockItemAllList = <StockModel>[].obs;
  // DB 리스트 10개 리밋
  RxList<StockModel> stockItemLimitList = <StockModel>[].obs;

  @override
  void onInit() async {
    if (!isLoading.value) {
      await reload();
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

    int offset = stockItemLimitList.length;

    stockItemLimitList.addAll(await getStockItemLimitList(offset));

    isLoading.value = false;
    hasMore.value = stockItemLimitList.length <
        stockItemAllList.length; // 전체 개수와 새로 불러와 적제되어있는 리스트의 개수가 같으면 완료
  }

  reload() async {
    stockItemAllList.clear();
    stockItemLimitList.clear();
    stockItemAllList.addAll(await getStockItemAllList());
    getData();
  }

  Future<List<StockModel>> getStockItemAllList() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection(COL_STOCK)
        .orderBy(FIELD_CREATEDATE, descending: true)
        .get(); // orderby 를 통해 sort작업을 한다. 기존 Linq 방식과 동일

    Map<String, dynamic> tmp = {};

    for (QueryDocumentSnapshot<Map<String, dynamic>> doc
        in querySnapshot.docs) {
      tmp[doc.id] = {StockModel.fromJson(doc.data())};
    } // 스냅샷을 가져와 tmp리스트에 넣을때 1차가공
    List<StockModel> items = [];

    for (int i = 0; i < tmp.length; i++) {

      items.add(tmp.values
          .elementAt(i)
          .cast<StockModel>()
          .elementAt(0)); // 필요한 모델만 따로 items리스트에 추가
    }

    return items;
  }

  Future<List<StockModel>> getStockItemLimitList(int offset) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot;
    if (offset == 0) {
      querySnapshot = await FirebaseFirestore.instance
          .collection(COL_STOCK)
          .orderBy(FIELD_CREATEDATE, descending: true)
          .limit(10)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        lastVisible.clear();
        lastVisible.add(querySnapshot.docs[querySnapshot.docs.length - 1]);
      }
    } else {
      querySnapshot = await FirebaseFirestore.instance
          .collection(COL_STOCK)
          .orderBy(FIELD_CREATEDATE, descending: true)
          .limit(10)
          .startAfterDocument(lastVisible[0])
          .get();
      lastVisible.clear();
      if (querySnapshot.docs.length == 10) {
        // 페이지를 불러온 개수가 10개일 경우에만 해당 코드 작동
        lastVisible.add(querySnapshot.docs[querySnapshot.docs.length - 1]);
      }
    }

    Map<String, dynamic> tmp = {};

    for (QueryDocumentSnapshot<Map<String, dynamic>> doc
        in querySnapshot.docs) {
      tmp[doc.id] = {StockModel.fromJson(doc.data())};
    } // 스냅샷을 가져와 tmp리스트에 넣을때 1차가공
    List<StockModel> items = [];

    for (int i = 0; i < tmp.length; i++) {
      // itemsDetectorKey.add(tmp.keys.elementAt(i));
      items.add(tmp.values
          .elementAt(i)
          .cast<StockModel>()
          .elementAt(0)); // 필요한 모델만 따로 items리스트에 추가
    }
    return items;
  }

// stockDB 불러오는 모델

// 좋아요 리스트 등록
  Future<void> updateFavorite(String itemsDetectorKey, int index) async {
    // 좋아요 문서 리스트 가져오기
    DocumentSnapshot<Map<String, dynamic>> dataSnapshot =
        await FirebaseFirestore.instance
            .collection(COL_STOCK)
            .doc(itemsDetectorKey)
            .get();
    // 좋아요 리스트를 임시 다이나믹 리스트에 넣기
    List<dynamic> tmp = [];

    tmp = dataSnapshot.data()![FIELD_FAVORITEUSERS];

    List<String> items = [];
    for (int i = 0; i < tmp.length; i++) {
      items.add(tmp.elementAt(i)); // 필요한 모델만 따로 items리스트에 추가
    }

    //임시 리스트에 유저 정보가 있으면 지우고 없으면 넣기
    if (items.contains(userKey)) {
      items.remove(userKey);
      stockItemLimitList[index].favoriteUsers!.remove(userKey);
      stockItemLimitList.refresh();
    } else {
      items.add(userKey);
      stockItemLimitList[index].favoriteUsers!.add(userKey);
      stockItemLimitList.refresh();
    }

    // 최종 리스트 업데이트
    await FirebaseFirestore.instance
        .collection(COL_STOCK)
        .doc(itemsDetectorKey)
        .set({FIELD_FAVORITEUSERS: items}, SetOptions(merge: true));
  }
}
