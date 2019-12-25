import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_shop/config/service_url.dart';
import 'package:flutter_shop/service/service_method.dart';

class ProvideCard with ChangeNotifier {
  getGoodsList() async {
    FormData formData = getSimpleFormData({"sprice" : 0.0, "eprice" : 0.0, "only" : 1,
      "urlids" : "0a2-0f1", "keyword" : "阿迪达斯", "page" : 1, "limit" : 10,
      "mdesc" : 0, "msort" : 1, "method" : "Lists/goodsList"});
      await request('goodsListContext', formData: formData);
  }
}