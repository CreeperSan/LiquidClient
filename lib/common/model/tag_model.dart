
import 'package:flutter/cupertino.dart';

class TagModel{
  final int id;
  final String name;
  final Color color;
  final String icon;
  final List<TagModel> childList;

  TagModel.single({
    this.id = 0,
    this.name = '',
    this.color = const Color(0xFF66CCFF),
    this.icon = '',
  }) : childList = null;

  TagModel.parent({
    this.id = 0,
    this.name = '',
    this.color = const Color(0xFF66CCFF),
    this.icon = '',
    this.childList = const [],
  });

}

