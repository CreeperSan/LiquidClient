
import 'package:flutter/cupertino.dart';
import 'package:liquid_client/common/enum/record_type.dart';
import 'package:liquid_client/common/model/currency_model.dart';
import 'package:liquid_client/common/model/target_model.dart';
import 'package:liquid_client/utils/format_util.dart';

class RecordAddPageProvider extends ChangeNotifier {
  RecordType recordType = RecordType.Outcome;                                   // 类型
  CurrencyModel currencyModel;                                                  // 货币
  TargetModel targetModel;                                                      // 对象
  String remark;                                                                // 备注
  int money;                                                                    // 金额
  int time = DateTime.now().millisecondsSinceEpoch;                             // 交易发生时间的时间戳

  void setCurrencyModel(CurrencyModel model){
    currencyModel = model;
    notifyListeners();
  }

  void setTargetModel(TargetModel model){
    targetModel = model;
    notifyListeners();
  }

  void setRemark(String remark){
    this.remark = remark;
    notifyListeners();
  }

  void setRecordType(RecordType type){
    this.recordType = type;
    notifyListeners();
  }

  void setTime(int timestamp){
    time = timestamp;
    notifyListeners();
  }

}
