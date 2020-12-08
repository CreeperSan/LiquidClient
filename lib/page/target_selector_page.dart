
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_client/application/liquid_router.dart';
import 'package:liquid_client/application/provider/liquid_provider.dart';
import 'package:liquid_client/application/provider/target_selector_page_provider.dart';
import 'package:liquid_client/cache/target_cache.dart';
import 'package:liquid_client/common/enum/network_request_state.dart';
import 'package:liquid_client/common/model/target_model.dart';
import 'package:liquid_client/network/network_manager.dart';
import 'package:provider/provider.dart';

class TargetSelectorPage extends StatefulWidget{
  TargetSelectorPageType pageType; // 请勿读取此变量，仅用于临时存储

  TargetSelectorPage({
    this.pageType = TargetSelectorPageType.Select,
  });

  @override
  State<StatefulWidget> createState() {
    return _TargetSelectorPageState();
  }

}

class _TargetSelectorPageState extends State<TargetSelectorPage>{

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(
      seconds: 0,
    ), (){
      LiquidProvider liquidProvider = context.read<LiquidProvider>();
      TargetSelectorPageProvider pageProvider = context.read<TargetSelectorPageProvider>();
      liquidProvider.loadTarget();
      pageProvider.setPageType(widget.pageType);
    });

  }

  @override
  Widget build(BuildContext context) {
    TargetSelectorPageProvider pageProvider = context.watch<TargetSelectorPageProvider>();
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: getNavigationBarTitleWidget(pageProvider.pageType),
        trailing: getNavigationBarActionButtonWidget(pageProvider.pageType),
      ),
      child: Selector<LiquidProvider, NetworkRequestState>(
        builder: buildContentWidget,
        selector: (buildContext, provider){
          return provider.targetRequestState;
        },
      ),
    );
  }

  /// 构建 标题栏标题
  Widget getNavigationBarTitleWidget(TargetSelectorPageType pageType){
    switch(pageType){
      case TargetSelectorPageType.Select:
        return Text('选择对象');
      case TargetSelectorPageType.Edit:
        return Text('编辑对象');
      case TargetSelectorPageType.List:
        return Text('所有对象');
    }
    return Container();
  }

  /// 构建 标题栏右侧按钮
  Widget getNavigationBarActionButtonWidget(TargetSelectorPageType pageType){
    switch(pageType){
      case TargetSelectorPageType.Select:
        return FlatButton(
          child: Text('编辑'),
          onPressed: _onNavigationBarEditClick,
        );
      case TargetSelectorPageType.Edit:
        return FlatButton(
          child: Text('完成'),
          onPressed: _onNavigationBarFinishClick,
        );
      case TargetSelectorPageType.List:
        return FlatButton(
          child: Text('编辑'),
          onPressed: _onNavigationBarFinishClick,
        );
    }
    return Container();
  }

  /// 构建 内容页面
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

  /// 构建 等待中页面 后续删除此方法
  @deprecated
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

  /// 构建 加载中页面
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

  /// 构建 加载失败页面
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

  /// 构建 加载成功页面
  Widget buildContentSuccessWidget(){
    return Padding(
      padding: EdgeInsets.only(
        top: 0,
      ),
      child: Selector<LiquidProvider, List<TargetModel>>(
        selector: (buildContext, provider) => provider.targetModelList,
        builder: (buildContext, targetModelList, child){
          switch(context.read<TargetSelectorPageProvider>().pageType){
            case TargetSelectorPageType.Select:
              return _buildSuccessSelectorListView(targetModelList);
            case TargetSelectorPageType.Edit:
              return _buildSuccessEditListView(targetModelList);
            case TargetSelectorPageType.List:
              return _buildSuccessListListView(targetModelList);
          }
          return _buildSuccessSelectorListView(targetModelList);
        },
      ),
    );
  }

  /// 构建 选择状态下的对象列表
  Widget _buildSuccessSelectorListView(List<TargetModel> targetModelList){
    return ListView.separated(
      separatorBuilder: (context, index) => _buildListViewDivider(),
      itemBuilder: (context, index){
        TargetModel model = targetModelList[index];
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _onTargetClick(model),
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
    );
  }

  /// 构建 编辑状态下的对象列表
  Widget _buildSuccessEditListView(List<TargetModel> targetModelList){
    return ListView.separated(
      separatorBuilder: (context, index) => _buildListViewDivider(),
      itemBuilder: (context, index){
        if(index <= 0){ // 添加对象
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: _onTargetCreateClick,
            child: Container(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 10,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text('添加对象'),
                    ),
                    Icon(CupertinoIcons.add),
                  ],
                ),
              ),
            ),
          );
        } else { // 编辑对象
          TargetModel model = targetModelList[index - 1];
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => _onTargetEditClick(model),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 10,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Text(model.name),
                  ),
                  CupertinoButton(
                    minSize: 24,
                    padding: EdgeInsets.zero,
                    child: Icon(CupertinoIcons.delete,
                      size: 24,
                    ),
                    onPressed: () => _onTargetDeleteClick(model),
                  )
                ],
              ),
            ),
          );
        }
      },
      itemCount: targetModelList.length + 1,
    );
  }

  /// 构建 查看状态下的对象列表
  Widget _buildSuccessListListView(List<TargetModel> targetModelList){
    return Container();
  }

  Widget _buildListViewDivider(){
    return Divider(
      height: 0.5,
      thickness: 0.5,
    );
  }

  void _onTargetClick(TargetModel model){
    Navigator.pop(context, {
      'isSuccess' : true,
      'result' : model,
    });
  }

  void _onTargetDeleteClick(TargetModel model){
    print('删除对象');
  }

  void _onTargetEditClick(TargetModel model){
    Navigator.pushNamed(context, LiquidRouter.TargetSelectorAddEdit,
      arguments: model
    );
  }

  void _onTargetCreateClick(){
    Navigator.pushNamed(context, LiquidRouter.TargetSelectorAddEdit,
      arguments: null
    );
  }

  void _onNavigationBarEditClick(){
    context.read<TargetSelectorPageProvider>().setPageType(TargetSelectorPageType.Edit);
  }

  void _onNavigationBarFinishClick(){
    context.read<TargetSelectorPageProvider>().setPageType(TargetSelectorPageType.Select);
  }

}
