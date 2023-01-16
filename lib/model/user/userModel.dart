import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zoopzoop/utils/data_keys.dart';

class UserModel {
  DateTime? createDate;
  String? userKey;
  String? fcmToken;
  String? email;
  String? nickName;
  String? phoneNumber;

  UserModel(
      {
      this.createDate,
      this.userKey,
      this.fcmToken,
      this.email,
      this.nickName,
      this.phoneNumber});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      createDate: json[FIELD_CREATEDATE] == null
          ? DateTime.now()
          : (json[FIELD_CREATEDATE] as Timestamp).toDate(),
      userKey: json[FIELD_USERKEY] == null ? '' : json[FIELD_USERKEY] as String,
      fcmToken: json[FIELD_FCMTOKEN] == null ? '' : json[FIELD_FCMTOKEN] as String,
      email: json[FIELD_EMAIL] == null ? '' : json[FIELD_EMAIL] as String,
      nickName:
          json[FIELD_NICKNAME] == null ? '' : json[FIELD_NICKNAME] as String,
      phoneNumber: json[FIELD_PHONENUMBER] == null
          ? ''
          : json[FIELD_PHONENUMBER] as String,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      FIELD_CREATEDATE: createDate,
      FIELD_USERKEY: userKey,
      FIELD_EMAIL: email,
      FIELD_NICKNAME: nickName,
      FIELD_PHONENUMBER: phoneNumber
    };
  }
}
