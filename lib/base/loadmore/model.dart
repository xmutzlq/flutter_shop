import 'package:json_annotation/json_annotation.dart'; 
  
part 'model.g.dart';


@JsonSerializable()
  class Model extends Object {

  @JsonKey(name: 'code')
  int code;

  @JsonKey(name: 'msg')
  String msg;

  @JsonKey(name: 'data')
  Data data;

  bool isSuccess() {
    return this.code == 1;
  }

  bool isError() {
    return !isSuccess();
  }

  Model(this.code,this.msg,this.data,);

  factory Model.fromJson(Map<String, dynamic> srcJson) => _$modelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$modelToJson(this);

}

  
@JsonSerializable()
  class Data extends Object {

  @JsonKey(name: 'goodsList')
  List<GoodsList> goodsList;

  @JsonKey(name: 'filters')
  List<Filters> filters;

  @JsonKey(name: 'total_page')
  int totalPage;

  Data(this.goodsList,this.filters,this.totalPage,);

  factory Data.fromJson(Map<String, dynamic> srcJson) => _$DataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataToJson(this);

}

  
@JsonSerializable()
  class GoodsList extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'goodsimg')
  String goodsimg;

  @JsonKey(name: 'goodsname')
  String goodsname;

  @JsonKey(name: 'shopprice')
  int shopprice;

  @JsonKey(name: 'saleprice')
  int saleprice;

  @JsonKey(name: 'isgoodssale')
  int isgoodssale;

  @JsonKey(name: 'marketprice')
  int marketprice;

  GoodsList(this.id,this.goodsimg,this.goodsname,this.shopprice,this.saleprice,this.isgoodssale,this.marketprice,);

  factory GoodsList.fromJson(Map<String, dynamic> srcJson) => _$GoodsListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$GoodsListToJson(this);

}
  
@JsonSerializable()
  class Filters extends Object {

  @JsonKey(name: 'p_name')
  String pName;

  @JsonKey(name: 'p_id')
  int pId;

  @JsonKey(name: 'c')
  List<C> c;

  Filters(this.pName,this.pId,this.c,);

  factory Filters.fromJson(Map<String, dynamic> srcJson) => _$FiltersFromJson(srcJson);

  Map<String, dynamic> toJson() => _$FiltersToJson(this);

}

  
@JsonSerializable()
  class C extends Object {

  @JsonKey(name: 'c_id')
  int cId;

  @JsonKey(name: 'c_name')
  String cName;

  @JsonKey(name: 'c_urlId')
  String cUrlId;

  @JsonKey(name: 'select')
  String select;

  C(this.cId,this.cName,this.cUrlId,this.select,);

  factory C.fromJson(Map<String, dynamic> srcJson) => _$CFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CToJson(this);

}

  
