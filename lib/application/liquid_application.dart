
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_client/application/liquid_router.dart';
import 'package:liquid_client/page/boot_page.dart';
import 'package:oktoast/oktoast.dart';

class LiquidApplication extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: CupertinoApp(
        title: 'Liquid',
        theme: CupertinoThemeData(
            primaryColor: Colors.green
        ),
        routes: LiquidRouter.router,
        home: BootPage(),
      ),
    );
  }

}
