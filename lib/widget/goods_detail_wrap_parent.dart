import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/widget/goods_detail_wrap_child.dart';

class GoodsDetailWrapParent extends StatelessWidget {
  final int parentIndex;
  final String parentName;

  GoodsDetailWrapParent({Key key, this.parentIndex, this.parentName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _parentWidget(),
    );
  }

  Widget _parentWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: Text(parentName, style: TextStyle(fontSize: ScreenUtil().setSp(28)),),
        ),
        GoodsDetailWrapChild(parentIndex: parentIndex,),
      ],
    );
  }
}