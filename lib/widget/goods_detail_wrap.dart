import 'package:flutter/material.dart';
import 'package:flutter_shop/entity/detail_wrap_parent_node.dart';
import 'package:flutter_shop/provide/prvide_detail.dart';
import 'package:flutter_shop/store/store.dart';
import 'package:flutter_shop/widget/goods_detail_wrap_parent.dart';

class GoodsDetailWrap extends StatefulWidget {
  GoodsDetailWrap({Key key}) : super(key: key);

  @override
  _GoodsDetailWrapState createState() => _GoodsDetailWrapState();
}

class _GoodsDetailWrapState extends State<GoodsDetailWrap> {
  @override
  Widget build(BuildContext context) {
    List<DetailWrapParentNode> parentNode = Store.value<ProvideDetail>(context).wrapNodes;
    return ListView.builder(
      physics: AlwaysScrollableScrollPhysics(),
      itemCount: parentNode.length,
      itemBuilder: (context,index){
        return GoodsDetailWrapParent(parentIndex: index, parentName: parentNode[index].name,);
      }
    );
  }
}