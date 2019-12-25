import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/config/util/i18n.dart';

import 'comm_text_field.dart';

class CommTopRow extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Container(
      alignment: Alignment.center,
      child: new Row(
        mainAxisSize: MainAxisSize.max, //有效，外层Colum高度为整个屏幕
        children: <Widget>[
          new Container(
            padding: const EdgeInsets.all(8.0),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max, //有效，内层Colum高度占满外部Column
              children: <Widget>[
                new Image.asset('images/icon_scan_white.png'),
                new Text(I18N.of(context).scan, style: TextStyle(color: Colors.white, fontSize: 10))
              ],
            ),
          ),
          Expanded(
            child: new CommTextField(isEnable: false, hintStr: I18N.of(context).getSearch, isNeedPop: false,),
          ),
          new Container(
            padding: const EdgeInsets.all(8.0),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max, //有效，内层Colum高度占满外部Column
              children: <Widget>[
                new Image.asset('images/icon_member.png'),
                new Text(I18N.of(context).code, style: TextStyle(color: Colors.white, fontSize: 10))
              ],
            ), 
          )
        ],
      ),
    );
  }
}