
import 'package:flutter/cupertino.dart';
import 'package:liquid_client/common/model/target_model.dart';
import 'package:liquid_client/network/model/target/network_response_target_add_model.dart';
import 'package:liquid_client/network/model/target/network_response_target_list_model.dart';
import 'package:liquid_client/network/network_manager.dart';
import 'package:liquid_client/toast/toast_manager.dart';

class TargetAddEditPage extends StatefulWidget{
  TargetModel targetModel;

  @override
  State<StatefulWidget> createState() {
    return _TargetAddEditPageState();
  }

  bool isAdd(){
    return targetModel == null || targetModel.id <= 0;
  }

  bool isEdit(){
    return !isAdd();
  }

}

class _TargetAddEditPageState extends State<TargetAddEditPage>{
  TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(
      text: widget.targetModel == null ? '' : widget.targetModel.name
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(widget.isAdd() ? '添加对象' : '编辑对象'),
        trailing: GestureDetector(
          child: Text(widget.targetModel == null ? '新建' : '保存'),
          onTap: _onSavePressed,
        ),
      ),
      child: Container(
        margin: EdgeInsets.only(
          top: 46,
        ),
        child: Column(
          children: [
            CupertinoTextField(
              controller: controller,
            )
          ],
        ),
      ),
    );
  }

  void _onSavePressed() async {
    if(widget.isAdd()){ // 添加
      print('新建');
      NetworkResponseTargetAddResponse response = await NetworkManager.targetAdd(controller.text);
      if(response.isSuccess()){
        ToastManager.show('对象新建成功');
        Navigator.pop(context);
      } else {
        ToastManager.show(response.message);
      }
    } else if(widget.isEdit()){ // 保存
      print('保存');

    }
  }

}
