import 'package:flutter_shop/entity/goods_list_child_node.dart';

class GoodsParent {
  List<GoodsParentNode> goodsParents;
  
  GoodsParent({
    this.goodsParents,
  });
}

class GoodsParentNode {
  int id;
  String name;
  bool isExpen;
  List<GoodsChildNode> goodsChilds;
}