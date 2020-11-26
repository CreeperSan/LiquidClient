
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_client/application/provider/liquid_provider.dart';
import 'package:liquid_client/cache/target_cache.dart';
import 'package:liquid_client/common/enum/network_request_state.dart';
import 'package:liquid_client/common/model/target_model.dart';
import 'package:liquid_client/network/network_manager.dart';
import 'package:provider/provider.dart';

class TargetSelectorPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _TargetSelectorPageState();
  }

}

class _TargetSelectorPageState extends State<TargetSelectorPage>{

  @override
  void initState() {
    super.initState();

    context.read<LiquidProvider>().loadTarget();

  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('请选择一个对象'),
        trailing: Text('编辑'),
      ),
      child: Selector<LiquidProvider, NetworkRequestState>(
        builder: buildContentWidget,
        selector: (buildContext, provider){
          return provider.targetRequestState;
        },
      ),
    );
  }

  Widget buildContentWidget(BuildContext context, NetworkRequestState state, Widget widget){
    switch(state){
      case NetworkRequestState.Idle:
        return buildContentIdleWidget();
      case NetworkRequestState.Loading:
        return buildContentLoadingWidget();
      case NetworkRequestState.Success:
        return buildContentSuccessWidget();
      case NetworkRequestState.Fail:
        return buildContentFailWidget();
      default :
        return buildContentIdleWidget();
    }
  }

  Widget buildContentIdleWidget(){
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                bottom: 16,
              ),
              child: Text('页面闲置中'),
            ),
            Text('可以尝试下拉刷新'),
          ],
        ),
      ),
    );
  }

  Widget buildContentLoadingWidget(){
    return SafeArea(
      child: Container(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  bottom: 16,
                ),
                child: CupertinoActivityIndicator(),
              ),
              Text('加载中'),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildContentFailWidget(){
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                bottom: 16,
              ),
              child: Icon(CupertinoIcons.info,
                size: 48,
              ),
            ),
            Text('加载失败'),
          ],
        ),
      ),
    );
  }

  Widget buildContentSuccessWidget(){
    List<TargetModel> targetModelList = context.read<LiquidProvider>().targetModelList;
    return Padding(
      padding: EdgeInsets.only(
        top: 0,
      ),
      child: ListView.separated(
        separatorBuilder: (context, index){
          return Divider(
            height: 0.5,
            thickness: 0.5,
          );
        },
        itemBuilder: (context, index){
          TargetModel model = targetModelList[index];
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => _onTargetClick(model, index),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 10,
              ),
              child: Row(
                children: [
                  Text(model.name),
                ],
              ),
            ),
          );
        },
        itemCount: targetModelList.length,
      ),
    );
  }

  void _onTargetClick(TargetModel model, int index){
    Navigator.pop(context, {
      'isSuccess' : true,
      'result' : model,
    });
  }

}
