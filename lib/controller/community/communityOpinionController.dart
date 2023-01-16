import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoopzoop/controller/auth/authController.dart';
import 'package:zoopzoop/controller/signal/signalController.dart';
import 'package:zoopzoop/model/community/communityLikeModel.dart';
import 'package:zoopzoop/model/community/communityModel.dart';
import 'package:zoopzoop/model/stock/stockModel.dart';
import 'package:zoopzoop/utils/data_keys.dart';

class CommunityOpinionController extends GetxController {
  static CommunityOpinionController get to => Get.find();
  static List<dynamic> lastVisible = [];
  late String stockKey;

  Rx<TextEditingController> opinionTextController = TextEditingController().obs;
  RxBool wordchkSearch = false.obs;
  RxString opinionInputListener = ''.obs; // 글자와 버튼 연결해주는 컨트롤러

  // 무한스크롤 관련 UI 스크롤 컨트롤러
  Rx<ScrollController> scrollController = ScrollController().obs;
  // 무한스크롤 데이터가 있는지 확인
  RxBool hasMore = false.obs;
  // 무한스크롤 데이터 로딩중
  RxBool isLoading = false.obs;

  RxList<CommunityModel> communityItemSelectAllList = <CommunityModel>[].obs;
  RxList itemsDetectorKey = [].obs;
  RxList<CommunityModel> communityItemSelectLimitList = <CommunityModel>[].obs;

  RxBool emoticon1 = true.obs;
  RxBool emoticon2 = false.obs;
  RxBool emoticon3 = false.obs;
  RxBool emoticon4 = false.obs;
  RxBool emoticon5 = false.obs;
  RxBool emoticon6 = false.obs;
  RxBool emoticon7 = false.obs;
  RxBool emoticon8 = false.obs;
  RxBool emoticon9 = false.obs;
  RxBool emoticon10 = false.obs;
  RxBool emoticon11 = false.obs;
  RxString emoticonSelect = '1'.obs;

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

    int offset = communityItemSelectLimitList.length;

    communityItemSelectLimitList
        .addAll(await getCommunityItemSelectLimitList(offset));

    isLoading.value = false;
    hasMore.value = communityItemSelectLimitList.length <
        communityItemSelectAllList
            .length; // 전체 개수와 새로 불러와 적제되어있는 리스트의 개수가 같으면 완료
  }

  reload(String selectStockKey) async {
    stockKey = selectStockKey;
    emoticon1.value = true;
    emoticon2.value = false;
    emoticon3.value = false;
    emoticon4.value = false;
    emoticon5.value = false;
    emoticon6.value = false;
    emoticon7.value = false;
    emoticon8.value = false;
    emoticon9.value = false;
    emoticon10.value = false;
    emoticon11.value = false;
    emoticonSelect.value = '1';
    communityItemSelectAllList.clear();
    communityItemSelectLimitList.clear();
    itemsDetectorKey.clear();

    opinionTextController.value.clear();
    opinionInputListener.value = '';
    communityItemSelectAllList.addAll(
        await getCommunityItemSelectAllList()); // todo : ui에서 stockKey 가져와야함
    getData();
  }

  Future<List<CommunityModel>> getCommunityItemSelectAllList() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection(COL_COMMUNITY)
        .where(FIELD_STOCKKEY, isEqualTo: stockKey)
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

  Future<List<CommunityModel>> getCommunityItemSelectLimitList(
      int offset) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot;
    if (offset == 0) {
      querySnapshot = await FirebaseFirestore.instance
          .collection(COL_COMMUNITY)
          .where(FIELD_STOCKKEY, isEqualTo: stockKey)
          .orderBy(FIELD_CREATEDATE, descending: true)
          .limit(10)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        lastVisible.clear();
        lastVisible.add(querySnapshot.docs[querySnapshot.docs.length - 1]);
      }
    } else {
      querySnapshot = await FirebaseFirestore.instance
          .collection(COL_COMMUNITY)
          .where(FIELD_STOCKKEY, isEqualTo: stockKey)
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
      tmp[doc.id] = {CommunityModel.fromJson(doc.data())};
    } // 스냅샷을 가져와 tmp리스트에 넣을때 1차가공
    List<CommunityModel> items = [];

    for (int i = 0; i < tmp.length; i++) {
      // itemsDetectorKey.add(tmp.keys.elementAt(i));
      items.add(tmp.values
          .elementAt(i)
          .cast<CommunityModel>()
          .elementAt(0)); // 필요한 모델만 따로 items리스트에 추가
    }
    return items;
  }

  Future<void> deleteOpinion(String communityKey) async {
    await FirebaseFirestore.instance
        .collection(COL_COMMUNITY)
        .doc(communityKey)
        .delete();
  }

  Future<void> setOpinion(String stockKey, int index) async {
    if (emoticon1.value) {
      emoticonSelect.value = '1';
    } else if (emoticon2.value) {
      emoticonSelect.value = '2';
    } else if (emoticon3.value) {
      emoticonSelect.value = '3';
    } else if (emoticon4.value) {
      emoticonSelect.value = '4';
    } else if (emoticon5.value) {
      emoticonSelect.value = '5';
    } else if (emoticon6.value) {
      emoticonSelect.value = '6';
    } else if (emoticon7.value) {
      emoticonSelect.value = '7';
    } else if (emoticon8.value) {
      emoticonSelect.value = '8';
    } else if (emoticon9.value) {
      emoticonSelect.value = '9';
    } else if (emoticon10.value) {
      emoticonSelect.value = '10';
    } else if (emoticon11.value) {
      emoticonSelect.value = '11';
    }
    // 난수 생성
    String communityKey = AuthController.generateDetectorKey(userKey);

    CommunityModel createCommunity = await createCommunityModel(
        stockKey, 'assets/emoticon/${emoticonSelect.value}.png', communityKey);
    CommunityLikeModel createCommunityLike = await createCommunityLikeModel(0);

    // 작성된 글에 대한 DB생성
    await FirebaseFirestore.instance
        .collection(COL_COMMUNITY)
        .doc(communityKey)
        .set(createCommunity.toJson());

    // 댓글 갯수 체크
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection(COL_COMMUNITY)
        .where(FIELD_STOCKKEY, isEqualTo: stockKey)
        .get();

    // 체크한 댓글의 갯수를 넣어준다
    await FirebaseFirestore.instance.collection(COL_STOCK).doc(stockKey).set(
        {FIELD_OPINION: querySnapshot.docs.length}, SetOptions(merge: true));

    SignalController.to.stockItemLimitList[index].opinion =
        querySnapshot.docs.length;
    SignalController.to.stockItemLimitList.refresh();

    // 좋아요 DB 생성
    await FirebaseFirestore.instance
        .collection(COL_COMMUNITY)
        .doc(communityKey)
        .collection(FIELD_FAVORITEUSERCOUNT)
        .doc(userKey)
        .set(createCommunityLike.toJson());
  }

  Future<CommunityModel> createCommunityModel(
      String stockKey, String emoticon, String communityKey) async {
    return CommunityModel(
        createDate: DateTime.now(),
        userKey: userKey,
        emoticon: emoticon,
        favoriteCount: 0,
        nickName: AuthController.to.userModel.value.nickName,
        stockKey: stockKey,
        comment: opinionInputListener.value,
        communityKey: communityKey);
  }

  Future<CommunityLikeModel> createCommunityLikeModel(int favorite) async {
    return CommunityLikeModel(favoriteCount: favorite);
  }

  Future<void> setLike(String communityKey, int index) async {
    DocumentSnapshot<Map<String, dynamic>> docRef = await FirebaseFirestore
        .instance
        .collection(COL_COMMUNITY)
        .doc(communityKey)
        .collection(FIELD_FAVORITEUSERCOUNT)
        .doc(userKey)
        .get();

    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await FirebaseFirestore.instance
            .collection(COL_COMMUNITY)
            .doc(communityKey)
            .get();

    if (docRef.data() == null) {
      CommunityLikeModel createCommunityLike =
          await createCommunityLikeModel(1);
      await FirebaseFirestore.instance
          .collection(COL_COMMUNITY)
          .doc(communityKey)
          .collection(FIELD_FAVORITEUSERCOUNT)
          .doc(userKey)
          .set(createCommunityLike.toJson());

      await FirebaseFirestore.instance
          .collection(COL_COMMUNITY)
          .doc(communityKey)
          .set({
        FIELD_FAVORITECOUNT: documentSnapshot.data()![FIELD_FAVORITECOUNT] + 1
      }, SetOptions(merge: true));
      communityItemSelectLimitList[index].favoriteCount =
          documentSnapshot.data()![FIELD_FAVORITECOUNT] + 1;
      communityItemSelectLimitList.refresh();
    } else if (docRef.data() != null) {
      if (docRef.data()![FIELD_FAVORITECOUNT] < 5) {
        CommunityLikeModel communityLike = await createCommunityLikeModel(
            docRef.data()![FIELD_FAVORITECOUNT] + 1);

        await FirebaseFirestore.instance
            .collection(COL_COMMUNITY)
            .doc(communityKey)
            .collection(FIELD_FAVORITEUSERCOUNT)
            .doc(userKey)
            .set(communityLike.toJson());

        await FirebaseFirestore.instance
            .collection(COL_COMMUNITY)
            .doc(communityKey)
            .set({
          FIELD_FAVORITECOUNT: documentSnapshot.data()![FIELD_FAVORITECOUNT] + 1
        }, SetOptions(merge: true));

        communityItemSelectLimitList[index].favoriteCount =
            documentSnapshot.data()![FIELD_FAVORITECOUNT] + 1;
        communityItemSelectLimitList.refresh();
      } else {
        Get.dialog(AlertDialog(
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
                  padding:
                      const EdgeInsets.only(right: 30, left: 30, bottom: 20),
                  child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text('확인')),
                ),
              )
            ]));
      }
    }

    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection(COL_COMMUNITY)
        .doc(communityKey)
        .collection(FIELD_FAVORITEUSERCOUNT)
        .where(FIELD_STOCKKEY, isEqualTo: stockKey)
        .get();
  }
}
