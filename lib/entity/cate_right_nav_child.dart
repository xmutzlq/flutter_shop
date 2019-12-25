class CateRightNavChild {
  String urlids;
  int parentId;
  String catName;
  String catImg;

  CateRightNavChild({
    this.urlids,
    this.parentId,
    this.catImg,
    this.catName
  });

  factory CateRightNavChild.fromJson(dynamic json) {
    return CateRightNavChild(
      urlids:json['urlids'],
      parentId:json['parentId'],
      catName:json['catName'],
      catImg:json['catImg']
    );
  }
}