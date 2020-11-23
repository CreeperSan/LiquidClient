import 'package:liquid_client/common/model/target_model.dart';
import 'package:liquid_client/network/model/base_network_response_model.dart';

class NetworkResponseTargetListResponse extends BaseNetworkResponseModel {
  List<TargetModel> targetModelList = [];

  NetworkResponseTargetListResponse.fromJson(jsonResponse) : super.fromJson(jsonResponse);

  NetworkResponseTargetListResponse.networkError() : super.networkError();

  @override
  decodeData(data) {
    for(dynamic item in data){
      targetModelList.add(TargetModel(
        id: item['id'],
        name: item['name'],
      ));
    }
  }


}