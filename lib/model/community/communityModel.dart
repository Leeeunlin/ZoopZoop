import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zoopzoop/utils/data_keys.dart';

class CommunityModel {
  DateTime? createDate;
  num? favoriteCount;
  String? comment;
  String? stockKey;
  String? emoticon;
  String? userKey;
  String? nickName;
  String? communityKey;
  CommunityModel({
    this.createDate,
    this.favoriteCount,
    this.comment,
    this.stockKey,
    this.emoticon,
    this.userKey,
    this.nickName,
    this.communityKey,
  });
  factory CommunityModel.fromJson(Map<String, dynamic> json) {
    return CommunityModel(
      createDate: json[FIELD_CREATEDATE] == null
          ? DateTime.now()
          : (json[FIELD_CREATEDATE] as Timestamp).toDate(),
      favoriteCount: json[FIELD_FAVORITECOUNT] == null
          ? 0
          : json[FIELD_FAVORITECOUNT] as num,
      comment: json[FIELD_COMMENT] == null ? '' : json[FIELD_COMMENT] as String,
      stockKey:
          json[FIELD_STOCKKEY] == null ? '' : json[FIELD_STOCKKEY] as String,
      emoticon:
          json[FIELD_EMOTICON] == null ? '' : json[FIELD_EMOTICON] as String,
      nickName:
          json[FIELD_NICKNAME] == null ? '' : json[FIELD_NICKNAME] as String,
      userKey: json[FIELD_USERKEY] == null ? '' : json[FIELD_USERKEY] as String,
      communityKey: json[FIELD_COMMUNITYKEY] == null
          ? ''
          : json[FIELD_COMMUNITYKEY] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      FIELD_CREATEDATE: createDate,
      FIELD_FAVORITECOUNT: favoriteCount,
      FIELD_COMMENT: comment,
      FIELD_STOCKKEY: stockKey,
      FIELD_EMOTICON: emoticon,
      FIELD_USERKEY: userKey,
      FIELD_NICKNAME: nickName,
      FIELD_COMMUNITYKEY: communityKey
    };
  }
}
