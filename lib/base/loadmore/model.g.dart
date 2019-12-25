// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Model _$modelFromJson(Map<String, dynamic> json) {
  return Model(
      json['code'] as int,
      json['msg'] as String,
      json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>));
}

Map<String, dynamic> _$modelToJson(Model instance) => <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'data': instance.data
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
      (json['goodsList'] as List)
          ?.map((e) =>
              e == null ? null : GoodsList.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      (json['filters'] as List)
          ?.map((e) =>
              e == null ? null : Filters.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['total_page'] as int);
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'goodsList': instance.goodsList,
      'filters': instance.filters,
      'total_page': instance.totalPage
    };

GoodsList _$GoodsListFromJson(Map<String, dynamic> json) {
  return GoodsList(
      json['id'] as int,
      json['goodsimg'] as String,
      json['goodsname'] as String,
      json['shopprice'] as int,
      json['saleprice'] as int,
      json['isgoodssale'] as int,
      json['marketprice'] as int);
}

Map<String, dynamic> _$GoodsListToJson(GoodsList instance) => <String, dynamic>{
      'id': instance.id,
      'goodsimg': instance.goodsimg,
      'goodsname': instance.goodsname,
      'shopprice': instance.shopprice,
      'saleprice': instance.saleprice,
      'isgoodssale': instance.isgoodssale,
      'marketprice': instance.marketprice
    };

Filters _$FiltersFromJson(Map<String, dynamic> json) {
  return Filters(
      json['p_name'] as String,
      json['p_id'] as int,
      (json['c'] as List)
          ?.map((e) => e == null ? null : C.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$FiltersToJson(Filters instance) => <String, dynamic>{
      'p_name': instance.pName,
      'p_id': instance.pId,
      'c': instance.c
    };

C _$CFromJson(Map<String, dynamic> json) {
  return C(json['c_id'] as int, json['c_name'] as String,
      json['c_urlId'] as String, json['select'] as String);
}

Map<String, dynamic> _$CToJson(C instance) => <String, dynamic>{
      'c_id': instance.cId,
      'c_name': instance.cName,
      'c_urlId': instance.cUrlId,
      'select': instance.select
    };
