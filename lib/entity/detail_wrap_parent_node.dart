import 'package:flutter_shop/entity/detail_wrap_child_node.dart';

class DetailWrapParent {
  List<DetailWrapParentNode> detailWrapParents;
  
  DetailWrapParent({
    this.detailWrapParents,
  });
}

class DetailWrapParentNode {
  int id;
  String name;
  List<DetailWrapChildNode> goodsChilds;
}