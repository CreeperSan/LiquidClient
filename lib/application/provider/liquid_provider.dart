
import 'package:flutter/cupertino.dart';
import 'package:liquid_client/common/enum/network_request_state.dart';
import 'package:liquid_client/common/model/currency_model.dart';
import 'package:liquid_client/common/model/tag_model.dart';
import 'package:liquid_client/common/model/target_model.dart';
import 'package:liquid_client/network/model/currency/network_response_currency_list_model.dart';
import 'package:liquid_client/network/network_manager.dart';

class LiquidProvider extends ChangeNotifier {
  final List<TargetModel> targetModelList = [];
  final List<CurrencyModel> currencyModelList = [];
  final List<TagModel> tagModelList = [];
  NetworkRequestState targetRequestState = NetworkRequestState.Idle;
  NetworkRequestState currencyRequestState = NetworkRequestState.Idle;
  NetworkRequestState tagRequestState = NetworkRequestState.Idle;

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

  Future<List<CurrencyModel>> loadCurrency({bool forceRemote = false}) async {
    // 是否强制网络拉取
    if(forceRemote){
      currencyRequestState = NetworkRequestState.Idle;
    }
    // 检查缓存
    if(currencyRequestState == NetworkRequestState.Success){
      return currencyModelList;
    }
    // 网络加载
    currencyRequestState = NetworkRequestState.Loading;
    notifyListeners();
    await Future.delayed(Duration(seconds: 1));
    NetworkResponseCurrencyListModel currencyListModel = await NetworkManager.currencyGetList();
    if(currencyListModel.isSuccess()){
      currencyRequestState = NetworkRequestState.Success;
      currencyModelList.clear();
      currencyModelList.addAll(currencyListModel.currencyModelList);
    } else {
      currencyRequestState = NetworkRequestState.Fail;
    }
    notifyListeners();
    return currencyModelList;
  }

}
