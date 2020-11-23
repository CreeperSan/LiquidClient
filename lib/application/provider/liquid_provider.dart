
import 'package:flutter/cupertino.dart';
import 'package:liquid_client/common/model/currency_model.dart';
import 'package:liquid_client/common/model/tag_model.dart';
import 'package:liquid_client/common/model/target_model.dart';

class LiquidProvider extends ChangeNotifier {
  final List<TargetModel> targetModelList = [];
  final List<CurrencyModel> currencyModelList = [];
  final List<TagModel> tagModelList = [];

  void setTargetModelList(List<TargetModel> list){
    targetModelList.clear();
    targetModelList.addAll(list);
    notifyListeners();
  }

  void setCurrencyModelList(List<CurrencyModel> list){
    currencyModelList.clear();
    currencyModelList.addAll(list);
    notifyListeners();
  }

  void setTagModelList(List<TagModel> list){
    tagModelList.clear();
    tagModelList.addAll(list);
    notifyListeners();
  }

  void logout(){
    targetModelList.clear();
    currencyModelList.clear();
    tagModelList.clear();
    notifyListeners();
  }

}
