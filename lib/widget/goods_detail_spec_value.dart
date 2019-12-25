import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/event/event_bus.dart';
import 'package:flutter_shop/provide/prvide_detail.dart';
import 'package:flutter_shop/store/store.dart';

class GoodsDetailSpecValue extends StatefulWidget {

  GoodsDetailSpecValue({Key key}) : super(key: key);

  @override
  _GoodsDetailSpecValueState createState() => _GoodsDetailSpecValueState();
}

class _GoodsDetailSpecValueState extends State<GoodsDetailSpecValue> {

  StreamSubscription _specsChangeSubscription;

  @override
  void initState() {
    super.initState();
    _specsChangeSubscription = eventBus.on<SpecsChangeEvent>().listen((data) {
      setState(() {
        
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _specsChangeSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    String choiceStr = Store.value<ProvideDetail>(context).updateChoiceDetail(context);
    return Text(
      choiceStr,
      style: TextStyle(
        fontSize: ScreenUtil().setSp(30),
        color: Colors.black54,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}