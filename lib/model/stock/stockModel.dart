import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zoopzoop/utils/data_keys.dart';

class StockModel {
  DateTime? createDate;
  List<String>? favoriteUsers;
  num? lastArarm;
  num? nowPrice;
  String? nowTime;
  num? ratio;
  num? searchPrice;
  String? searchTime;
  String? stockName;
  String? stockKey;
  num? opinion;

  StockModel(
      {this.createDate,
      this.favoriteUsers,
      this.lastArarm,
      this.nowPrice,
      this.nowTime,
      this.ratio,
      this.searchPrice,
      this.searchTime,
      this.stockName,
      this.stockKey,
      this.opinion});

  factory StockModel.fromJson(Map<String, dynamic> json) {
    return StockModel(
        createDate: json[FIELD_CREATEDATE] == null
            ? DateTime.now()
            : (json[FIELD_CREATEDATE] as Timestamp).toDate(),
        favoriteUsers: json[FIELD_FAVORITEUSERS] != null
            ? json[FIELD_FAVORITEUSERS].cast<String>()
            : ['none'],
        lastArarm:
            json[FIELD_LASTALARM] == null ? 0 : json[FIELD_LASTALARM] as num,
        nowPrice:
            json[FIELD_NOWPRICE] == null ? 0 : json[FIELD_NOWPRICE] as num,
        nowTime:
            json[FIELD_NOWTIME] == null ? '' : json[FIELD_NOWTIME] as String,
        ratio: json[FIELD_RATIO] == null ? 0 : json[FIELD_RATIO] as num,
        searchPrice: json[FIELD_SEARCHPRICE] == null
            ? 0
            : json[FIELD_SEARCHPRICE] as num,
        searchTime: json[FIELD_SEARCHTIME] == null
            ? ''
            : json[FIELD_SEARCHTIME] as String,
        stockName: json[FIELD_STOCKNAME] == null
            ? ''
            : json[FIELD_STOCKNAME] as String,
        stockKey:
            json[FIELD_STOCKKEY] == null ? '' : json[FIELD_STOCKKEY] as String,
        opinion: json[FIELD_OPINION] == null ? 0 : json[FIELD_OPINION] as num);
  }

  factory StockModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return StockModel.fromJson(snapshot.data()!);
  }

  Map<String, dynamic> toJson() {
    return {
      FIELD_CREATEDATE: createDate,
      FIELD_FAVORITEUSERS: favoriteUsers,
      FIELD_LASTALARM: lastArarm,
      FIELD_NOWPRICE: nowPrice,
      FIELD_NOWTIME: nowTime,
      FIELD_RATIO: ratio,
      FIELD_SEARCHPRICE: searchPrice,
      FIELD_SEARCHTIME: searchTime,
      FIELD_STOCKNAME: stockName,
      FIELD_STOCKKEY: stockKey,
      FIELD_OPINION: opinion
    };
  }
}
