
import 'package:flutter/cupertino.dart';
import 'package:liquid_client/common/enum/network_request_state.dart';
import 'package:liquid_client/common/model/currency_model.dart';
import 'package:liquid_client/common/model/tag_model.dart';
import 'package:liquid_client/common/model/target_model.dart';
import 'package:liquid_client/network/model/currency/network_response_currency_list_model.dart';
import 'package:liquid_client/network/model/target/network_response_target_list_model.dart';
import 'package:liquid_client/network/network_manager.dart';

class LiquidProvider extends ChangeNotifier {
  int userID = 0; // 当前登录账号的UserID
  final List<TargetModel> targetModelList = []; // 对象列表
  final List<CurrencyModel> currencyModelList = []; // 支持的货币列表
  final List<TagModel> tagModelList = []; // 标签列表
  NetworkRequestState targetRequestState = NetworkRequestState.Idle; // 对象列表缓存请求的网络状态
  NetworkRequestState currencyRequestState = NetworkRequestState.Idle; // 货币列表缓存请求的网络状态
  NetworkRequestState tagRequestState = NetworkRequestState.Idle; // 标签列表缓存请求的网络状态

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

  /// 获取支持的所有货币
  /// [forceRemote] 是否强制从网络拉取
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

  /// 获取所有的对象
  /// [forceRemote] 是否强制从网络中拉取
  Future<List<TargetModel>> loadTarget({bool forceRemote = false}) async {
    // 是否强制从网络中拉取
    if(forceRemote){
      targetRequestState = NetworkRequestState.Idle;
    }
    // 检查缓存
    if(targetRequestState == NetworkRequestState.Success){
      return targetModelList;
    }
    // 网络加载
    targetRequestState = NetworkRequestState.Loading;
    notifyListeners();
    await Future.delayed(Duration(seconds: 1));
    NetworkResponseTargetListResponse targetListResponse = await NetworkManager.targetGetList();
    if(targetListResponse.isSuccess()){
      targetRequestState = NetworkRequestState.Success;
      targetModelList.clear();
      targetModelList.addAll(targetListResponse.targetModelList);
    } else {
      targetRequestState = NetworkRequestState.Fail;
    }
    notifyListeners();
    return targetModelList;
  }

}
