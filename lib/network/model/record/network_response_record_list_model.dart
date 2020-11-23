import 'package:liquid_client/common/model/record_model.dart';
import 'package:liquid_client/network/model/base_network_response_model.dart';

class NetworkResponseRecordListResponse extends BaseNetworkResponseModel {
  List<RecordModel> listModel = [];

  NetworkResponseRecordListResponse.fromJson(jsonResponse) : super.fromJson(jsonResponse);

  NetworkResponseRecordListResponse.networkError() : super.networkError();

  @override
  decodeData(data) {
    for(dynamic item in data){
      listModel.add(RecordModel(
        id: item['id'],
        tagID: item['tag_id'],
        targetID: item['target_id'],
        createTime: item['create_time'],
        modifyTime: item['modify_time'],
        recordTime: item['record_time'],
        money: item['money'],
        currency: item['currency'],
        description: item['description']
      ));
    }
  }


}