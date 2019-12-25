//HomePageEntity子对象
class HomePageChild {
  List<SlideImg> slideImg;
  List<BrandNav> brandNav;
  List<List<Classify>> classify;
  List<List<GoodsList>> goodsList;
  List<Floor> floor;

  HomePageChild({
    this.slideImg,
    this.brandNav,
    this.classify,
    this.goodsList,
    this.floor
  });

  factory HomePageChild.fromJson(Map<String, dynamic> parsedJson) {
    return HomePageChild(
      slideImg: parsedJson['slideImg'],
      brandNav: parsedJson['brandNav'],
      classify: parsedJson['classify'],
      goodsList: parsedJson['goodsList'],
      floor: parsedJson['floor']
    );
  }
}

class SlideImg {
  String imageUrl;
  String url;
}

class BrandNav {
  String imageUrl;
  String urlids;
}

class Classify {
  String text;
  String urlids;
}

class GoodsList {
  String imageUrl;
  String pdu;
  String goodsId;
  String goodsName;
  String shopPrice;
}

class Floor {
  String imageUrl;
  String urlids;
}