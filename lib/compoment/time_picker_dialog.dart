import 'package:flutter/cupertino.dart';
import 'package:liquid_client/compoment/cupertino_string_picker.dart';

class TimePickerDialog extends StatefulWidget{
  int year;
  int month;
  int day;
  int hour;
  int minute;
  int second;

  TimePickerDialog(){
    DateTime currentDateTime = DateTime.now();
    year = currentDateTime.year;
    month = currentDateTime.month;
    day = currentDateTime.day;
    hour = currentDateTime.hour;
    minute = currentDateTime.minute;
    second = currentDateTime.second;
  }

  TimePickerDialog.specify({
    @required this.year,
    @required this.month,
    @required this.day,
    @required this.hour,
    @required this.minute,
    @required this.second,
  });

  @override
  State<StatefulWidget> createState() {
    return TimePickerDialogState();
  }

}

class TimePickerDialogState extends State<TimePickerDialog>{
  final double pickerHeight = 300;
  final int yearOffset = 1970;

  final List<int> yearList = createIntRange(1970, 2050);
  final List<int> monthList = createIntRange(1, 12);
  final List<int> dayList = createIntRange(1, 31);
  final List<int> hourList = createIntRange(0, 23);
  final List<int> minuteList = createIntRange(0, 59);
  final List<int> secondList = createIntRange(0, 59);

  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTheme(
      data: CupertinoThemeData(),
      child: Container(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: EdgeInsets.only(
            bottom: 16,
          ),
          decoration: BoxDecoration(
            color: CupertinoColors.white,
            borderRadius: BorderRadius.all(Radius.circular(36)),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              top: 20,
              bottom: 12,
              left: 20,
              right: 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 36,
                    right: 36,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CupertinoButton(
                        child: Text('取消'),
                        onPressed: _onCancelClick,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 96,
                        ),
                        child: Text('请选择交易时间'),
                      ),
                      CupertinoButton(
                        child: Text('确定'),
                        onPressed: _onConfirmClick,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: pickerHeight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // 年
                      CupertinoStringPicker(
                        width: 108,
                        itemCount: yearList.length,
                        onSelectItemChange : _onYearChange,
                        height: pickerHeight,
                        defaultPosition: widget.year - yearOffset,
                        itemBuilder: (index){
                          return Center(
                            child: Text('${index + yearOffset}'),
                          );
                        },
                      ),
                      Text('年'),

                      // 月
                      CupertinoStringPicker(
                        width: 72,
                        itemCount: monthList.length,
                        defaultPosition: widget.month - 1,
                        onSelectItemChange : _onMonthChange,
                        height: pickerHeight,
                        itemBuilder: (index){
                          return Center(
                            child: Text('${index+1}'),
                          );
                        },
                      ),
                      Text('月'),

                      // 日
                      CupertinoStringPicker(
                        width: 72,
                        itemCount: _getThisMonthDayCount(),
                        defaultPosition: widget.day - 1,
                        height: pickerHeight,
                        itemBuilder: (index){
                          return Center(
                            child: Text('${index+1}'),
                          );
                        },
                      ),
                      Text('日'),

                      // 时
                      CupertinoStringPicker(
                        width: 72,
                        itemCount: hourList.length,
                        defaultPosition: widget.hour,
                        height: pickerHeight,
                        itemBuilder: (index){
                          return Center(
                            child: Text('${index}'),
                          );
                        },
                      ),
                      Text('时'),

                      // 分
                      CupertinoStringPicker(
                        width: 72,
                        itemCount: minuteList.length,
                        defaultPosition: widget.minute,
                        height: pickerHeight,
                        itemBuilder: (index){
                          return Center(
                            child: Text('${index}'),
                          );
                        },
                      ),
                      Text('分'),

                      // 秒
                      CupertinoStringPicker(
                        width: 72,
                        itemCount: secondList.length,
                        defaultPosition: widget.second,
                        height: pickerHeight,
                        itemBuilder: (index){
                          return Center(
                            child: Text('${index}'),
                          );
                        },
                      ),
                      Text('秒'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static List<int> createIntRange(int start, int end, { int step = 1 }){
    List<int> result = [];
    for(int i=start; i<=end; i+=step){
      result.add(i);
    }
    return result;
  }

  int _getThisMonthDayCount(){
    int year = yearOffset + widget.year;
    int month = widget.month;
    DateTime dateTime = DateTime(year, month, 0);
    dateTime.add(Duration(
      days: -1
    ));
    print('${dateTime.year}-${dateTime.month}-${dateTime.day}');
    return dateTime.day;
  }

  void _onYearChange(int newYear){
    setState(() {
      widget.year = newYear;
    });
  }

  void _onMonthChange(int newMonth){
    setState(() {
      widget.month = newMonth;
    });
  }
  
  void _onConfirmClick(){
    Navigator.pop(context, {
      'year' : widget.year,
      'month' : widget.month,
      'day' : widget.day,
      'hour' : widget.hour,
      'minute' : widget.minute,
      'day' : widget.day,
      'datetime' : DateTime(widget.year, widget.month, widget.day, widget.hour, widget.minute, widget.second),
    });
  }
  
  void _onCancelClick(){
    Navigator.pop(context);
  }

}
