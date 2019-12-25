import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/entity/goods_list_parent_node.dart';
import 'package:flutter_shop/provide/provide_goods_list.dart';
import 'package:flutter_shop/store/store.dart';
import 'package:flutter_shop/widget/goods_filter_child.dart';

class GoodsFilterParent extends StatefulWidget {
  final int parentNodeIndex;
  final GoodsParentNode parentNodes;

  GoodsFilterParent({Key key, this.parentNodeIndex, this.parentNodes}) : super(key: key);

  @override
  GoodsFilterParentState createState() => GoodsFilterParentState();
}

class GoodsFilterParentState extends State<GoodsFilterParent> {

  GlobalKey<GoodsFilterChildState> textKey = GlobalKey();
  bool _isExpend = false;

  @override
  void initState() {
    super.initState();
    print('parent node initState');
    _isExpend = widget.parentNodes.isExpen;
  }

  @override
  Widget build(BuildContext context) {
    print('parent node build');
    return Container(
       child: _filterWidget(widget.parentNodes),
    );
  }

  Widget _filterWidget(GoodsParentNode parentNode) {
    return Column(
      children: <Widget>[
        _parentWidget(parentNode),
        GoodsFilterChild(key: textKey, parentNodeIndex: widget.parentNodeIndex,
        childNodes: parentNode.goodsChilds, isExpended: parentNode.isExpen,),
      ],
    );
  }

  Widget _parentWidget(GoodsParentNode parentNode) {
    return Container(
      padding: EdgeInsets.only(left: 12.0, right: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Text(
              parentNode.name,
              style: TextStyle(fontSize: ScreenUtil().setSp(28), color: Colors.black),
            ),
          ),
          parentNode.goodsChilds.length > 9 ?
          InkWell(
            onTap: () {
              _isExpend = !_isExpend;
              Store.value<ProvideGoodsList>(context).updateParentExpended(parentNode, _isExpend);
              textKey.currentState.expend();
              setState(() {});
            },
            child: Container(
              width: ScreenUtil().setWidth(80),
              height: ScreenUtil().setHeight(60),
              child: Icon(_isExpend ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down),
            ),
          ) :
          Container(
            width: ScreenUtil().setWidth(80),
            height: ScreenUtil().setHeight(60),
          )
        ],
      )
    );
  }
}