
import 'package:liquid_client/common/model/currency_model.dart';
import 'package:liquid_client/network/model/base_network_response_model.dart';

class NetworkResponseCurrencyListModel extends BaseNetworkResponseModel{
  List<CurrencyModel> currencyModelList = [];

  NetworkResponseCurrencyListModel.fromJson(dynamic jsonResponse) : super.fromJson(jsonResponse);

  NetworkResponseCurrencyListModel.networkError() : super.networkError();

  @override
  decodeData(data) {
    currencyModelList.clear();
    for(dynamic item in data){
      currencyModelList.add(CurrencyModel(
        id: item['id'] ?? 0,
        region: item['region'] ?? '',
        name: item['name'] ?? '',
        shortName: item['shortName'] ?? '',
      ));
    }
  }

}
