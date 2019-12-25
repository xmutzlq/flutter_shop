
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:flutter_shop/config/service_url.dart';
import 'package:flutter_shop/routers/application.dart';
import 'package:flutter_shop/service/service_method.dart';

class ProvideHome with ChangeNotifier {
  var responseJson;

  List<Map> flagImgs = [];
  List<Map> swiperDataList = [];
  List<Map> brandList = [];
  List<List<dynamic>> goodsList = [];
  List<dynamic> collectionList = [];
  List<dynamic> collectionHorList = [];
  List ads = [];
  List<List<dynamic>> catesList = [];
  List<dynamic> shoseCate = [];
  List<dynamic> clothCate = [];
  List<dynamic> accesCate = [];

  List<dynamic> catesBxHorList = [];
  List<dynamic> catesXxHorList = [];
  List<dynamic> catesPbHorList = [];
  List<dynamic> catesLqHorList = [];
  List<dynamic> catesWyHorList = [];
  List<dynamic> catesWkHorList = [];

  goDetail(BuildContext context, var item) {
    Application.router.navigateTo(context,"/detail?id=${item['goodsId']}");
  }

  getHome() {
    request('homePageContext', formData: commFormData).then((val) {
      responseJson = val;
      flagImgs = (responseJson['data']['floor'] as List).cast(); //界面图片
      swiperDataList = (responseJson['data']['slideImg'] as List).cast(); // 顶部轮播组件数
      brandList = (responseJson['data']['brandNav'] as List).cast(); //brand数组
      goodsList = (responseJson['data']['goodsList'] as List).cast(); //goodlist数组
      collectionList = goodsList[0];
      collectionHorList = goodsList[1];
      ads = [flagImgs[6], flagImgs[7], flagImgs[8], flagImgs[9], flagImgs[10]];

      catesList = (responseJson['data']['classify'] as List).cast();
      shoseCate = catesList[0];
      clothCate = catesList[1];
      accesCate = catesList[2];

      catesBxHorList = goodsList[3];
      catesXxHorList = goodsList[4];
      catesPbHorList = goodsList[5];
      catesLqHorList = goodsList[6];
      catesWyHorList = goodsList[7];
      catesWkHorList = goodsList[8];

      notifyListeners();
    });
  }
}