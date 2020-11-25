
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_client/application/liquid_router.dart';
import 'package:liquid_client/application/provider/record_page_provider.dart';
import 'package:provider/provider.dart';

class RecordPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _RecordPageState();
  }
  
}

class _RecordPageState extends State<RecordPage>{

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: GestureDetector(
          child: Icon(CupertinoIcons.person_solid),
          onTap: _onUserPressed,
        ),
        middle: Text('Liquid'),
      ),
      child: Container(
          margin: EdgeInsets.only(
              top: 46
          ),
          child: Column(
            children: [
              Expanded(
                child: Container(),
              ),
              Selector(
                builder: (context, int pageIndex, child){
                  return CupertinoTabBar(
                    currentIndex: context.watch<RecordPageProvider>().currentTabIndex,
                    items: [
                      BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.flag),
                        label: '记录',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.add),
                        label: '添加记录',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.chart_bar),
                        label: '统计',
                      ),
                    ],
                    onTap: _onTabPressed,
                  );
                },
                selector: (context, RecordPageProvider provider){
                  return provider.currentTabIndex;
                },
              )
            ],
          )
      ),
    );
  }

  void _onUserPressed(){

  }

  void _onTabPressed(int index){
    print('tabPressed : $index');
    RecordPageProvider recordPageProvider = context.read<RecordPageProvider>();
    if(index == 0 || index == 2){
      recordPageProvider.setCurrentTabIndex(index);
    } else if(index == 1){
      Navigator.of(context).pushNamed(LiquidRouter.RecordAdd);
    }

  }

}

class _RecordPageRecordListView extends StatefulWidget{
  
  @override
  State<StatefulWidget> createState() {
    return _RecordPageRecordListViewState();
  }
  
}

class _RecordPageRecordListViewState extends State<_RecordPageRecordListView>{
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('记录列表'),
    );
  }
  
}

class _RecordPageStatisticView extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _RecordPageRecordListViewState();
  }

}

class _RecordPageStatisticViewState extends State<_RecordPageStatisticView>{

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('数据分析'),
    );
  }

}

