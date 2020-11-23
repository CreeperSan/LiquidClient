import 'package:liquid_client/common/model/target_model.dart';
import 'package:liquid_client/network/model/target/network_response_target_list_model.dart';
import 'package:liquid_client/network/network_manager.dart';

class TargetCache {
  static int _updateTime = 0;
  static final List<TargetModel> _modelList = [];

  static Future<List<TargetModel>> load() async {
    if(_updateTime <= 0){
      NetworkResponseTargetListResponse response = await NetworkManager.targetGetList();
      if(response.isSuccess()){
        _updateTime = DateTime.now().millisecond;
        _modelList.clear();
        _modelList.addAll(response.targetModelList);
      }
    } else {
      return _modelList;
    }
  }

}