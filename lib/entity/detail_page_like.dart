class Like {
  int goodsId;
  String goodsName;
  String goodsImg;
  int saleNum;
  String shopPrice;
  String marketPrice;
  int isNew;

  Like({
    this.goodsId,
    this.goodsName,
    this.goodsImg,
    this.shopPrice,
    this.marketPrice,
    this.saleNum,
    this.isNew
  });

  factory Like.fromJson(Map<String, dynamic> parsedJson) {
    return Like(
      goodsId: parsedJson['goodsId'],
      goodsName: parsedJson['goodsName'],
      goodsImg: parsedJson['goodsImg'],
      shopPrice: parsedJson['shopPrice'],
      marketPrice: parsedJson['marketPrice'],
      saleNum: parsedJson['saleNum'],
      isNew: parsedJson['isNew'],
    );
  }
}