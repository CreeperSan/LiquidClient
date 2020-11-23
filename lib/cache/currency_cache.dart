import 'package:liquid_client/common/model/currency_model.dart';
import 'package:liquid_client/network/model/currency/network_response_currency_list_model.dart';
import 'package:liquid_client/network/network_manager.dart';

class CurrencyCache {
  static int _updateTime = 0; // 上一次的更新时间
  static List<CurrencyModel> _currencyList = []; //

  static Future<List<CurrencyModel>> load() async {
    // 判读是否需要从网络中拉取
    if(_updateTime <= 0){ // 从网络中拉取
       NetworkResponseCurrencyListModel currencyModel = await NetworkManager.currencyGetList();
       if(currencyModel.isSuccess()){
         _updateTime = DateTime.now().millisecond;
         _currencyList.clear();
         _currencyList.addAll(currencyModel.currencyModelList);
         return _currencyList;
       } else {
         return _currencyList;
       }
    } else { // 返回缓存中的内容
      return _currencyList;
    }
  }

}