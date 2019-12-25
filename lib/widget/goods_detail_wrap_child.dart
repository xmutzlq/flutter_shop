import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/entity/detail_wrap_child_node.dart';
import 'package:flutter_shop/event/event_bus.dart';
import 'package:flutter_shop/provide/prvide_detail.dart';
import 'package:flutter_shop/store/store.dart';

class GoodsDetailWrapChild extends StatefulWidget {
  final int parentIndex;

  GoodsDetailWrapChild({Key key, this.parentIndex}) : super(key: key);

  @override
  _GoodsDetailWrapChildState createState() => _GoodsDetailWrapChildState();
}

class _GoodsDetailWrapChildState extends State<GoodsDetailWrapChild> {
  @override
  Widget build(BuildContext context) {
    List<DetailWrapChildNode> childNodes = Store.value<ProvideDetail>(context).wrapNodes[widget.parentIndex].goodsChilds;
    return Wrap(
      spacing: 10, //主轴上子控件的间距
      runSpacing: 10, //交叉轴上子控件之间的间距
      alignment: WrapAlignment.start,
      children: _wrapChildNodes(childNodes),
    );
  }

  List<Widget> _wrapChildNodes(List<DetailWrapChildNode> childNodes) {
    List<Widget> wrapChilds = List();
    for (DetailWrapChildNode childNode in childNodes) {
      wrapChilds.add(Container(
        height: 30,
        child: FlatButton(
          child: Text(childNode.name, style: TextStyle(fontSize: ScreenUtil().setSp(26)),),
          textColor: childNode.isChecked ? Colors.purple : Colors.black54,
          onPressed: !childNode.isDisabel ? (){
            if(Store.value<ProvideDetail>(context).updateChildChecked(childNode)) {
              eventBus.fire(SpecsChangeEvent());
            }
          } : null,
          clipBehavior: Clip.antiAlias,
          shape: childNode.isChecked ? StadiumBorder(side: BorderSide(color: Colors.purple, width: 1)) : StadiumBorder(),
          color: childNode.isChecked ? Colors.white : Colors.grey[200],
        ),
      ));
    }
    return wrapChilds;
  }
}