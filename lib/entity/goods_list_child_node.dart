class GoodsChild {

  List<GoodsChildNode> goodsChilds;

  GoodsChild({
    this.goodsChilds,
  });
}

class GoodsChildNode {
  int parentId;
  int id;
  String name;
  String urlIds;
  bool isChecked;
  bool isDisabel;
}