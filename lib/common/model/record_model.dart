
import 'package:flutter/cupertino.dart';
import 'package:liquid_client/common/model/tag_model.dart';

class RecordModel{
  int id;
  int tagID;
  int targetID;
  int createTime;
  int modifyTime;
  int recordTime;
  int money;
  int currency;
  String description;

  RecordModel({
    @required this.id,
    this.tagID = -1,
    this.targetID = -1,
    this.createTime = 0,
    this.modifyTime = 0,
    this.recordTime = 0,
    @required this.money,
    this.currency = 0,
    this.description = '',
  });

}
