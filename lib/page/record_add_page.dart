
import 'package:flutter/cupertino.dart';
import 'package:liquid_client/application/liquid_router.dart';

class RecordAddPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _RecordAddPageState();
  }

}

class _RecordAddPageState extends State<RecordAddPage>{

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('添加记录'),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: 42
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [

              // 收入还是支出
              RecordAddPageSelectItem(
                name: '类型',
                value: '收入、支出',
              ),
              RecordAddPageDivider(),

              // 金额
              RecordAddPageSelectItem(
                name: '金额',
                value: '16',
              ),
              RecordAddPageDivider(),

              // 交易时间
              RecordAddPageSelectItem(
                name: '交易时间',
                value: '2020年12月06日 上午08时16分',
              ),
              RecordAddPageDivider(),

              // 标签
              RecordAddPageSelectItem(
                name: '标签',
                value: '标签',
              ),
              RecordAddPageDivider(),

              // 对象
              RecordAddPageSelectItem(
                name: '对象',
                value: '自己',
                onClick: _onTargetClick,
                showArrow: true,
              ),
              RecordAddPageDivider(),

              // 货币
              RecordAddPageSelectItem(
                name: '货币',
                value: '人民币（元）',
                onClick: _onCurrencyClick,
                showArrow: true,
              ),
              RecordAddPageDivider(),

              // 备注
              RecordAddPageSelectItem(
                name: '备注',
                value: '暂无备注',
                onClick: _onRemarkClick
              ),
              RecordAddPageDivider(),
            ],
          ),
        ),
      ),
    );
  }

  void _onTargetClick(){
    Navigator.pushNamed(context, LiquidRouter.TargetSelector);
  }

  void _onCurrencyClick(){
    Navigator.pushNamed(context, LiquidRouter.CurrencySelector);
  }

  void _onRemarkClick(){

  }

}

class RecordAddPageSelectItem extends StatelessWidget{
  bool showArrow;
  String name;
  String value;
  void Function() onClick;
  Widget centerWidget;

  RecordAddPageSelectItem({
    this.showArrow = false,
    @required this.name,
    @required this.value,
    this.onClick,
    this.centerWidget,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(name),
            ),
            centerWidget == null ? Container() : centerWidget,
            Offstage(
              offstage: !showArrow,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 18,
                ),
                child: Icon(CupertinoIcons.right_chevron),
              ),
            ),
          ],
        ),
      ),
      onTap: onClick,
    );
  }

}

class RecordAddPageDivider extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      color: CupertinoColors.systemGrey5,
    );
  }

}



