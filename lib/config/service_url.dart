import 'package:dio/dio.dart';
import 'package:flutter_shop/api/api.dart';

const String SEX_MAN = "1";
const String SEX_WOMEN = "2";

const servicePath={
  'homePageContext': Api.BANNER_URL, // 商家首页信息
  'catePageContext': Api.CATEGORY_URL, //商家分类左边列表
  'cateGoodsListContext': Api.CATEGORY_GOODS_LIST_URL, //商家分类右边列表
  'detailPageContext': Api.GOODS_DETAILS_URL, //商品详情
  'goodsListContext': Api.GOODS_LIST_URL, //商品列表
};

Map<String, dynamic> getParams(Map<String, dynamic> params, String method) {
  if(params == null) params = {};
  params.putIfAbsent("appType", ()=>"erp");
  params.putIfAbsent("appToken", ()=>"erXwIxQo8dEFWTBparp");
  params.putIfAbsent("method", ()=>method);
  return params;
}

FormData getFormData(Map<String, dynamic> params, String method) {
  Map<String, dynamic> param = getParams(params, method);
  print(param);
  return new FormData.from(param);
}

FormData getSimpleFormData(Map<String, dynamic> params) {
  return new FormData.from(params);
}

var commFormData = new FormData.from(getParams({}, "Shops/getShopData"));

String urlParser(String fixUrl) {
  return "${Api.BASE_URL}"'/'"$fixUrl";
}