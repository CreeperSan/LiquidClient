
import 'package:flutter/cupertino.dart';
import 'package:liquid_client/application/provider/liquid_provider.dart';
import 'package:liquid_client/common/enum/network_request_state.dart';
import 'package:liquid_client/common/model/tag_model.dart';
import 'package:provider/provider.dart';

class TagSelectorPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _TagSelectorPageState();
  }

}

class _TagSelectorPageState extends State<TagSelectorPage>{

  @override
  void initState() {
    super.initState();
    context.read<LiquidProvider>().loadTag();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('请选择标签'),
      ),
      child: SafeArea(
        child: Selector<LiquidProvider, NetworkRequestState>(
          selector: (buildContext, provider){
            return provider.tagRequestState;
          },
          builder: (BuildContext context, NetworkRequestState state, Widget widget){
            switch(state){
              case NetworkRequestState.Success:
                return _buildSuccessWidget();
              case NetworkRequestState.Fail:
                return _buildFailWidget();
              default:
                return _buildLoadingWidget();
            }
          },
        ),
      ),
    );
  }

  Widget _buildSuccessWidget(){
    List<TagModel> tagModelList = context.read<LiquidProvider>().tagModelList;
    return ListView.separated(
      itemBuilder: (listViewContext, index){
        TagModel tagModel = tagModelList[index];
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 10,
            ),
            child: Text('${tagModel.name}'),
          ),
          onTap: (){ print('click'); },
        );
      },
      separatorBuilder: (listViewContext, index){
        return Container(
          height: 0.5,
          color: Color(0xFF999999),
        );
      },
      itemCount: tagModelList.length,
    );
  }

  Widget _buildFailWidget(){
    return Text('加载失败');
  }

  Widget _buildLoadingWidget(){
    return Text('加载中');
  }

}
