import 'package:flutter/material.dart';
import 'package:liquid_client/application/liquid_application.dart';
import 'package:liquid_client/application/provider/liquid_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider<LiquidProvider>.value(
    value: LiquidProvider(),
    child: LiquidApplication(),
  ));
}
