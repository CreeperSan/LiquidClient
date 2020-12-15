import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart' as Cupertino;
import 'package:liquid_client/compoment/cupertino_picker_without_divider.dart';

/// 选择时间后底部弹出的对话框

class TimePickerDialog extends StatefulWidget {
  int year;
  int month;
  int day;
  int hour;
  int minute;
  int second;
  void Function(DateTime time) onConfirm;

  TimePickerDialog({
    this.year,
    this.month,
    this.day,
    this.hour,
    this.minute,
    this.second,
    this.onConfirm,
  }){
    // 如果没有指定时间的话，则采用当前时间往后的5分钟的整数倍时间
    DateTime nowTime;
    if(year == null || month == null || day == null || hour == null || minute == null){
      nowTime = DateTime.now();
    } else {
      nowTime = DateTime(year, month, day, hour, minute, second);
    }
    
    year = nowTime.year;
    month = nowTime.month;
    day = nowTime.day;
    hour = nowTime.hour;
    minute = nowTime.minute;
    second = nowTime.second;
  }

  @override
  State<StatefulWidget> createState() {
    return _TimePickerDialogState();
  }

}

class _TimePickerDialogState extends State<TimePickerDialog>{
  static List<int> _yearList = createIntRange(1970, 2050);
  static List<int> _monthList = createIntRange(1, 12);
  static List<int> _dayList31 = createIntRange(1, 31);
  static List<int> _hourList = createIntRange(0, 23);
  static List<int> _minuteList = createIntRange(0, 59);
  static List<int> _secondList = createIntRange(0, 59);
  static const double _diameterRatio = 1.2;
  static const double _squeeze = 1.2;
  static const double pickerHeight = 215.0;
  static const double actionHeight = 50.0;
  static const double pickerItemHeight = 36.0;
  static const double dialogDividerHeight = 0.5;

  FixedExtentScrollController yearController;
  FixedExtentScrollController monthController;
  FixedExtentScrollController dayController;
  FixedExtentScrollController hourController;
  FixedExtentScrollController minuteController;
  FixedExtentScrollController secondController;

  int daysInMonth = 31;

  static List<int> createIntRange(int start, int end, { int step = 1 }){
    List<int> result = [];
    for(int i=start; i<=end; i+=step){
      result.add(i);
    }
    return result;
  }


  @override
  void initState() {
    super.initState();
    yearController = FixedExtentScrollController(
      initialItem: widget.year - _yearList[0],
    );
    monthController = FixedExtentScrollController(
      initialItem: widget.month - 1,
    );
    daysInMonth = DateTime(widget.year, widget.month + 1, 0).add(Duration(
        days: -1
    )).day + 1;
    dayController = FixedExtentScrollController(
      initialItem: widget.day - 1,
    );
    hourController = FixedExtentScrollController(
      initialItem: widget.hour,
    );
    minuteController = FixedExtentScrollController(
      initialItem: widget.minute,
    );
    secondController = FixedExtentScrollController(
      initialItem: widget.second,
    );
  }

  void _rebuildDayPickList(){
    setState(() {
      daysInMonth = DateTime(widget.year, widget.month + 1, 0).add(Duration(
          days: -1
      )).day + 1;
    });

    dayController.jumpTo(dayController.position.pixels + 0.0001); // 触发日期选择器界面更新
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: GestureDetector(
              behavior: Cupertino.HitTestBehavior.opaque,
              onTap: () => Navigator.pop(context),
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
          Material(
            child: Container(
              color: Colors.white,
              height: actionHeight + pickerHeight + dialogDividerHeight,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: actionHeight,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        FlatButton(
                            minWidth: 62,
                            height: actionHeight,
                            onPressed: _onCancelPressed,
                            child: Text('取消',
                              style: TextStyle(
                                color: Color(0xFF11BF57),
                                fontSize: 16,
                              ),
                            )
                        ),
                        Expanded(
                          child: Container(
                            height: 0,
                          ),
                        ),
                        FlatButton(
                          minWidth: 62,
                          height: actionHeight,
                          onPressed: _onConfirmPressed,
                          child: Text('确定',
                            style: TextStyle(
                              color: Color(0xFF11BF57),
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Color(0xFFD5DBE1),
                    height: dialogDividerHeight,
                    thickness: dialogDividerHeight,
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 72,
                            height: pickerHeight,
                            child: CupertinoPicker.builder(
                              itemExtent: pickerItemHeight,
                              diameterRatio: _diameterRatio,
                              squeeze: _squeeze,
                              scrollController: yearController,
                              onSelectedItemChanged: _onYearChange,
                              itemBuilder: (itemContext, index){
                                return _buildPickerItem('${_yearList[index]}');
                              },
                              childCount: _yearList.length,
                            ),
                          ),
                          Text('年',
                            style: TextStyle(
                              color: Color(0xFFADB0B5),
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            width: 50,
                            height: pickerHeight,
                            child: CupertinoPicker.builder(
                              itemExtent: pickerItemHeight,
                              diameterRatio: _diameterRatio,
                              squeeze: _squeeze,
                              scrollController: monthController,
                              onSelectedItemChanged: _onMonthChange,
                              childCount: _monthList.length,
                              itemBuilder: (itemContext, index){
                                return _buildPickerItem('${_monthList[index]}');
                              },
                            ),
                          ),
                          Text('月',
                            style: TextStyle(
                              color: Color(0xFFADB0B5),
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            width: 50,
                            height: pickerHeight,
                            child: CupertinoPicker.builder(
                              itemExtent: pickerItemHeight,
                              diameterRatio: _diameterRatio,
                              squeeze: _squeeze,
                              scrollController: dayController,
                              onSelectedItemChanged: _onDayChange,
                              childCount: daysInMonth,
                              itemBuilder: (itemContext, index){
                                return _buildPickerItem('${_dayList31[index]}');
                              },
                            ),
                          ),
                          Text('日',
                            style: TextStyle(
                              color: Color(0xFFADB0B5),
                              fontSize: 20,
                            ),
                          ),
                          Container(
                            width: 20,
                          ),
                          SizedBox(
                            width: 50,
                            height: pickerHeight,
                            child: CupertinoPicker.builder(
                              itemExtent: pickerItemHeight,
                              diameterRatio: _diameterRatio,
                              scrollController: hourController,
                              squeeze: _squeeze,
                              onSelectedItemChanged: _onHourChange,
                              childCount: _hourList.length,
                              itemBuilder: (itemContext, index){
                                return _buildPickerItem('${_hourList[index]}');
                              },
                            ),
                          ),
                          Text(':',
                            style: TextStyle(
                              color: Color(0xFFADB0B5),
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            width: 50,
                            height: pickerHeight,
                            child: CupertinoPicker.builder(
                              itemExtent: pickerItemHeight,
                              diameterRatio: _diameterRatio,
                              squeeze: _squeeze,
                              scrollController: minuteController,
                              onSelectedItemChanged: _onMinuteChange,
                              childCount: _minuteList.length,
                              itemBuilder: (itemContext, index){
                                return _buildPickerItem('${_minuteList[index]}');
                              },
                            ),
                          ),
                          Text(':',
                            style: TextStyle(
                              color: Color(0xFFADB0B5),
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            width: 50,
                            height: pickerHeight,
                            child: CupertinoPicker.builder(
                              itemExtent: pickerItemHeight,
                              diameterRatio: _diameterRatio,
                              squeeze: _squeeze,
                              scrollController: secondController,
                              onSelectedItemChanged: _onSecondChange,
                              childCount: _secondList.length,
                              itemBuilder: (itemContext, index){
                                return _buildPickerItem('${_secondList[index]}');
                              },
                            ),
                          ),
                        ],
                      ),

                      Cupertino.Column(
                        children: [
                          Divider(
                            height: 0.5,
                            color: Color(0xFFC6CDD4),
                          ),
                          Container(
                            width: 0,
                            height: pickerItemHeight,
                          ),Divider(
                            height: 0.5,
                            color: Color(0xFFC6CDD4),
                          )
                        ],
                      )

                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  void _onYearChange(int index){
    widget.year = _yearList[index];
    _rebuildDayPickList();
    // print('年 ${widget.year}');
  }
  
  void _onMonthChange(int index){
    widget.month = _monthList[index];
    _rebuildDayPickList();
    // print('月 ${widget.month}');
  }
  
  void _onDayChange(int index){
    widget.day = _dayList31[index];
    // print('日 ${widget.day}');
  }
  
  void _onHourChange(int index){
    widget.hour = _hourList[index];
    // print('时 ${widget.hour}');
  }
  
  void _onMinuteChange(int index){
    widget.minute = _minuteList[index];
    // print('分 ${widget.minute}');
  }

  void _onSecondChange(int index){
    widget.second = _secondList[index];
    // print('分 ${widget.minute}');
  }

  void _onConfirmPressed(){
    print('时间 ${widget.year}年${widget.month}月${widget.day}日  ${widget.hour}时${widget.minute}分${widget.second}秒');
    widget.onConfirm?.call(DateTime(
      widget.year,
      widget.month,
      widget.day,
      widget.hour,
      widget.minute,
      widget.second,
    ));
    Navigator.pop(context);
  }

  void _onCancelPressed(){
    Navigator.pop(context);
  }

  Widget _buildPickerItem(String content){
    return Center(
      child: Text(content,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
      ),
    );
  }
  
}


