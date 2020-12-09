
import 'package:flutter/cupertino.dart';
import 'package:liquid_client/application/liquid_router.dart';
import 'package:liquid_client/application/provider/record_add_page_provider.dart';
import 'package:liquid_client/common/enum/record_type.dart';
import 'package:liquid_client/common/model/currency_model.dart';
import 'package:liquid_client/common/model/tag_model.dart';
import 'package:liquid_client/common/model/target_model.dart';
import 'package:liquid_client/compoment/time_picker_dialog.dart';
import 'package:liquid_client/page/target_add_edit_page.dart';
import 'package:liquid_client/utils/format_util.dart';
import 'package:provider/provider.dart';

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
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    // 收入还是支出
                    RecordAddPageSelectItem(
                      name: '类型',
                      centerWidget: Selector<RecordAddPageProvider, RecordType>(
                        selector: (buildContext, provider){
                          return provider.recordType;
                        },
                        builder: (buildContext, recordType, child){
                          return Row(
                            children: [
                              GestureDetector(
                                child: Container(
                                  child: Text('收入',
                                    style: TextStyle(
                                      color: recordType == RecordType.Income ? CupertinoColors.systemGreen : CupertinoColors.systemGrey4,
                                    ),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    vertical: 2,
                                    horizontal: 8,
                                  ),
                                ),
                                onTap: _onIncomeClick,
                              ),
                              GestureDetector(
                                child: Container(
                                  child: Text('支出',
                                    style: TextStyle(
                                      color: recordType == RecordType.Outcome ? CupertinoColors.systemGreen : CupertinoColors.systemGrey4,
                                    ),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    vertical: 2,
                                    horizontal: 8,
                                  ),
                                ),
                                onTap: _onOutcomeClick,
                              ),
                            ],
                          );
                        }
                      ),
                    ),
                    RecordAddPageDivider(),

                    // 金额
                    RecordAddPageSelectItem(
                      name: '金额',
                      centerWidget: Container(
                        width: 128,
                        child: CupertinoTextField(
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ),
                    RecordAddPageDivider(),

                    // 交易时间
                    RecordAddPageSelectItem(
                      name: '交易时间',
                      showArrow: true,
                      centerWidget: Selector<RecordAddPageProvider, int>(
                        selector: (buildContext, provider){
                          return provider.time;
                        },
                        builder: (buildContext, timestamp, child){
                          print('timestamp');
                          print(timestamp);
                          return Text(FormatUtil.timestampToRecordTime(timestamp));
                        },
                      ),
                      onClick: _onTimeClick,
                    ),
                    RecordAddPageDivider(),

                    // 对象
                    RecordAddPageSelectItem(
                      name: '对象',
                      onClick: _onTargetClick,
                      showArrow: true,
                      centerWidget: Selector<RecordAddPageProvider, TargetModel>(
                        selector: (buildContext, provider){
                          return provider.targetModel;
                        },
                        builder: (buildContext, targetModel, child){
                          return Text(targetModel == null ? '请选择对象' : targetModel.name,
                            style: TextStyle(
                              color: targetModel == null ? CupertinoColors.systemGrey4 : CupertinoColors.black
                            ),
                          );
                        },
                      ),
                    ),
                    RecordAddPageDivider(),

                    // 货币
                    RecordAddPageSelectItem(
                      name: '货币',
                      onClick: _onCurrencyClick,
                      showArrow: true,
                      centerWidget: Selector<RecordAddPageProvider, CurrencyModel>(
                        selector: (buildContext, provider){
                          return provider.currencyModel;
                        },
                        builder: (buildContext, currencyModel, child){
                          return Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  right: 8,
                                ),
                                child: Image(
                                  image: AssetImage(FormatUtil.currencyShortNameToEmojiFlag(currencyModel == null ? '' : currencyModel.shortName)),
                                  width: 24,
                                  height: 18,
                                ),
                              ),
                              Text(currencyModel == null ? '请选择货币' : currencyModel.name,
                                style: TextStyle(
                                    color: currencyModel == null ? CupertinoColors.systemGrey4 : CupertinoColors.black
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    RecordAddPageDivider(),

                    // 标签
                    RecordAddPageSelectItem(
                      showArrow: true,
                      name: '标签',
                      onClick: _onTagClick,
                      centerWidget: Selector<RecordAddPageProvider, List<TagModel>>(
                        selector: (buildContext, provider){
                          return provider.tagList;
                        },
                        builder: (buildContext, tagList, child){
                          return Offstage(
                            offstage: tagList != null && tagList.isNotEmpty,
                            child: Text('请选择标签',
                              style: TextStyle(
                                color: CupertinoColors.systemGrey4,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    RecordAddPageDivider(),

                    // 备注
                    RecordAddPageSelectItem(
                      name: '备注',
                      onClick: _onRemarkClick,
                      extendWidget: CupertinoTextField(
                        maxLines: 3,
                      ),
                    ),
                    RecordAddPageDivider(),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: CupertinoButton(
                    child: Text('保存'),
                    onPressed: _onTapSave,
                  ),
                ),
                Expanded(
                  child: CupertinoButton(
                    child: Text('保存并继续添加'),
                    onPressed: _onTapSaveAndContinue,
                  ),
                ),
              ],
            ),
          ],
        )
      ),
    );
  }

  void _onIncomeClick(){
    context.read<RecordAddPageProvider>().setRecordType(RecordType.Income);
  }

  void _onOutcomeClick(){
    context.read<RecordAddPageProvider>().setRecordType(RecordType.Outcome);
  }

  void _onTimeClick(){
    RecordAddPageProvider pageProvider = context.read<RecordAddPageProvider>();
    DateTime datetime = DateTime.fromMillisecondsSinceEpoch(pageProvider.time);
    showCupertinoModalPopup(
      context: context,
      builder: (buildContext){
        return TimePickerDialog.specify(
            year: datetime.year,
            month: datetime.month,
            day: datetime.day,
            hour: datetime.hour,
            minute: datetime.minute,
            second: datetime.second,
        );
      }
    );
  }

  void _onTargetClick(){
    Navigator.pushNamed(context, LiquidRouter.TargetSelector).then((response){
      if(response == null){
        return;
      }
      Map res = response;
      if(!res['isSuccess']){
        return;
      }
      context.read<RecordAddPageProvider>().setTargetModel(res['result']);
    });
  }

  void _onCurrencyClick(){
    Navigator.pushNamed(context, LiquidRouter.CurrencySelector).then((response){
      if(response == null){
        return;
      }
      Map res = response;
      if(!res['isSuccess']){
        return;
      }
      context.read<RecordAddPageProvider>().setCurrencyModel(res['result']);
    });
  }

  void _onTagClick(){
    Navigator.pushNamed(context, LiquidRouter.TagSelector);
  }

  void _onRemarkClick(){

  }

  void _onTapSave(){
    print('保存');
  }

  void _onTapSaveAndContinue(){
    print('保存并继续');
  }

}

class RecordAddPageSelectItem extends StatelessWidget{
  bool showArrow;
  String name;
  void Function() onClick;
  Widget centerWidget;
  Widget extendWidget;

  RecordAddPageSelectItem({
    this.showArrow = false,
    @required this.name,
    this.onClick,
    this.centerWidget,
    this.extendWidget,
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
        child: Column(
          children: [
            Row(
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
            Offstage(
              offstage: extendWidget == null,
              child: extendWidget == null ? Container() : Padding(
                padding: EdgeInsets.only(
                  top: 16
                ),
                child: extendWidget,
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



