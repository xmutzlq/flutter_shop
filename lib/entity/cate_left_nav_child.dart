class CateLeftNavChild {
  int catId;
  String catName;

  CateLeftNavChild({
    this.catId,
    this.catName
  });

  factory CateLeftNavChild.fromJson(dynamic json) {
    return CateLeftNavChild(
      catId:json['catId'],
      catName:json['catName']
    );
  }
}