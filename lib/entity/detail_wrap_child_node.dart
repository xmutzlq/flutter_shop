class DetailWrapChild {

  List<DetailWrapChildNode> detailWrapChilds;

  DetailWrapChild({
    this.detailWrapChilds,
  });
}

class DetailWrapChildNode {
  int parentId;
  int id;
  String name;
  bool isChecked; //isdefault
  bool isDisabel;
}