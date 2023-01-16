import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zoopzoop/utils/data_keys.dart';

class CommunityLikeModel {
  num? favoriteCount;
  CommunityLikeModel({this.favoriteCount});
  factory CommunityLikeModel.fromJson(Map<String, dynamic> json) {
    return CommunityLikeModel(
        favoriteCount: json[FIELD_FAVORITECOUNT] == null
            ? 0
            : json[FIELD_FAVORITECOUNT] as num);
  }
  Map<String, dynamic> toJson() {
    return {FIELD_FAVORITECOUNT: favoriteCount};
  }
}