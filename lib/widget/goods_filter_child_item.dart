import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/entity/goods_list_child_node.dart';
import 'package:flutter_shop/provide/provide_goods_list.dart';
import 'package:flutter_shop/store/store.dart';

class GoodsFilterChildItem extends StatefulWidget {
  final int parentNodeIndex;
  final int childNodeIndex;

  GoodsFilterChildItem({Key key, this.parentNodeIndex, this.childNodeIndex}) : super(key: key);

  @override
  _GoodsFilterChildItemState createState() => _GoodsFilterChildItemState();
}

class _GoodsFilterChildItemState extends State<GoodsFilterChildItem> {

  @override
  void initState() {
    super.initState();
    print('child node item initState');
  }

  @override
  Widget build(BuildContext context) {
    GoodsChildNode childNode = Store.value<ProvideGoodsList>(context).filterNodes[widget.parentNodeIndex].goodsChilds[widget.childNodeIndex];
    return Container(
      height: 30,
      alignment: Alignment.center,
      child: FlatButton(
        child: Text(childNode.name, style: TextStyle(fontSize: ScreenUtil().setSp(26)),),
        textColor: childNode.isChecked ? Colors.purple : Colors.black54,
        onPressed: !childNode.isDisabel ? (){
          childNode.isChecked = !childNode.isChecked;
          Store.value<ProvideGoodsList>(context).updateChildChecked(childNode, childNode.isChecked);
          setState(() {}); 
        } : null,
        clipBehavior: Clip.antiAlias,
        shape: childNode.isChecked ? StadiumBorder(side: BorderSide(color: Colors.purple, width: 1)) : StadiumBorder(),
        color: childNode.isChecked ? Colors.white : Colors.grey[200],
      ),
    );
  }
}