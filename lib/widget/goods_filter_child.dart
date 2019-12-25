import 'package:flutter/material.dart';
import 'package:flutter_shop/entity/goods_list_child_node.dart';
import 'package:flutter_shop/widget/goods_filter_child_item.dart';

class GoodsFilterChild extends StatefulWidget {
  final int parentNodeIndex;
  final List<GoodsChildNode> childNodes;
  final bool isExpended;

  GoodsFilterChild({Key key, this.parentNodeIndex, this.childNodes, this.isExpended = false}) : super(key: key);

  @override
  GoodsFilterChildState createState() => GoodsFilterChildState();
}

class GoodsFilterChildState extends State<GoodsFilterChild> {

  bool _isExpended = false;

  void expend() {
    _isExpended = !_isExpended;
  }

  @override
  void initState() {
    super.initState();
    print('child node initState');
    _isExpended = widget.isExpended;
  }

  @override
  Widget build(BuildContext context) {
    print('child node build');
    return GridView.builder(
      padding: EdgeInsets.all(12.0),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _isExpended ? widget.childNodes.length : (widget.childNodes.length >= 9 ? 9 : widget.childNodes.length),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //横轴元素个数
        crossAxisCount: 3,
        //纵轴间距
        mainAxisSpacing: 6.0,
        //横轴间距
        crossAxisSpacing: 12.0,
        childAspectRatio: 2,
      ),
      itemBuilder: (BuildContext context, int index) {
        return AnimatedSwitcher(
          transitionBuilder: (child, anim){
            return FadeTransition(opacity:anim, child: child);
          },
          duration: Duration(milliseconds: 300),
          child: GoodsFilterChildItem(parentNodeIndex: widget.parentNodeIndex, childNodeIndex: index,),
        );
      }
    );
  }
}