import 'package:flutter/cupertino.dart';
import 'package:liquid_client/compoment/cupertino_string_picker.dart';

class TimePickerDialog extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return TimePickerDialogState();
  }

}

class TimePickerDialogState extends State<TimePickerDialog>{
  final double pickerHeight = 300;
  final int yearOffset = 1970;

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
                        onPressed: (){},
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 96,
                        ),
                        child: Text('请选择交易时间'),
                      ),
                      CupertinoButton(
                        child: Text('确定'),
                        onPressed: (){},
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
                      CupertinoStringPicker(
                        width: 108,
                        height: pickerHeight,
                        itemBuilder: (index){
                          return Center(
                            child: Text('${index + yearOffset}'),
                          );
                        },
                        itemCount: 100,
                      ),
                      Text('年'),
                      CupertinoStringPicker(
                        width: 72,
                        height: pickerHeight,
                        itemBuilder: (index){
                          return Center(
                            child: Text('${index+1}'),
                          );
                        },
                        itemCount: 12,
                      ),
                      Text('月'),
                      CupertinoStringPicker(
                        width: 72,
                        height: pickerHeight,
                        itemBuilder: (index){
                          return Center(
                            child: Text('${index+1}'),
                          );
                        },
                        itemCount: 30,
                      ),
                      Text('日'),
                      CupertinoStringPicker(
                        width: 72,
                        height: pickerHeight,
                        itemBuilder: (index){
                          return Center(
                            child: Text('${index+1}'),
                          );
                        },
                        itemCount: 23,
                      ),
                      Text('时'),
                      CupertinoStringPicker(
                        width: 72,
                        height: pickerHeight,
                        itemBuilder: (index){
                          return Center(
                            child: Text('${index+1}'),
                          );
                        },
                        itemCount: 59,
                      ),
                      Text('分'),
                      CupertinoStringPicker(
                        width: 72,
                        height: pickerHeight,
                        itemBuilder: (index){
                          return Center(
                            child: Text('${index+1}'),
                          );
                        },
                        itemCount: 59,
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

}
