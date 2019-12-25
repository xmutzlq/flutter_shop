class DefaultSpecs {
  int specDesIndex;
  int specSizeIndex;

  DefaultSpecs({this.specDesIndex, this.specSizeIndex});

  factory DefaultSpecs.fromJson(Map<String, dynamic> parsedJson) {
    return DefaultSpecs(
      specDesIndex: parsedJson['1'],
      specSizeIndex: parsedJson['5'],
    );
  }
}

class Spec {
  SpecDes specDesItem;
  SpecDes specSizeItem;

  Spec({this.specDesItem, this.specSizeItem});

  factory Spec.fromJson(Map<String, dynamic> parsedJson) {
    SpecDes specDesItem = SpecDes.fromJson(parsedJson['1']); 
    SpecDes specSizeItem = SpecDes.fromJson(parsedJson['5']); 
    return Spec(
      specDesItem: specDesItem,
      specSizeItem: specSizeItem,
    );
  }
}

class SpecDes {
  String name;
  List<SpecDesList> list;

  SpecDes({
    this.name,
    this.list
  });

  factory SpecDes.fromJson(Map<String, dynamic> parsedJson) {
    var originList = parsedJson['list'] as List;
    List<SpecDesList> specDesList = originList.map((value) => SpecDesList.fromJson(value)).toList();
    return SpecDes(
      name: parsedJson['name'],
      list: specDesList,
    );
  }
}

class SpecDesList {
  int isAllowImg;
  String catName;
  String productNo;
  int catId;
  int itemId;
  String itemName;
  String itemImg;
  int isDefault;
  int specStock;
  ShopStock shopStock;

  SpecDesList({
    this.isAllowImg,
    this.catName,
    this.productNo,
    this.catId,
    this.itemId,
    this.itemName,
    this.itemImg,
    this.isDefault,
    this.specStock,
    this.shopStock
  });

  factory SpecDesList.fromJson(Map<String, dynamic> json) {
    ShopStock specDesItem = ShopStock.fromJson(json['shopStock']); 
    return SpecDesList(
      isAllowImg:json['isAllowImg'],
      catName:json['catName'],
      productNo:json['productNo'],
      catId:json['catId'],
      itemId:json['itemId'],
      itemName:json['itemName'],
      itemImg:json['itemImg'],
      isDefault:json['isDefault'],
      specStock:json['specStock'],
      shopStock: specDesItem,
    );
  }
}

class ShopStock {
  int allStock;
  int unStock;

  ShopStock({
    this.allStock,
    this.unStock
  });

  factory ShopStock.fromJson(Map<String, dynamic> json) {
    return ShopStock(
      allStock:json['allStock'],
      unStock:json['unStock'],
    );
  }
}