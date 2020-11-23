
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_client/cache/target_cache.dart';
import 'package:liquid_client/common/model/target_model.dart';
import 'package:liquid_client/network/network_manager.dart';

class TargetSelectorPage extends StatefulWidget{
  List<TargetModel> targetModelList = [];

  @override
  State<StatefulWidget> createState() {
    return _TargetSelectorPageState();
  }

}

class _TargetSelectorPageState extends State<TargetSelectorPage>{

  @override
  void initState() {
    super.initState();
    TargetCache.load().then((value){
      widget.targetModelList.clear();
      widget.targetModelList.addAll(value);
      setState(() { });
    }).catchError((e){
      widget.targetModelList.clear();
      setState(() { });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('请选择一个对象'),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: 0,
        ),
        child: ListView.separated(
          separatorBuilder: (context, index){
            return Divider();
          },
          itemBuilder: (context, index){
            TargetModel model = widget.targetModelList[index];
            return Text(model.name);
          },
          itemCount: widget.targetModelList.length,
        ),
      ),
    );
  }

}
