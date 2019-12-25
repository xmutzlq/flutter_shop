import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_shop/config/service_url.dart';
import 'package:flutter_shop/entity/cate_left_nav_entity.dart';
import 'package:flutter_shop/entity/cate_right_nav_entity.dart';
import 'package:flutter_shop/service/service_method.dart';

class ProvideCategory with ChangeNotifier {
  var _responseJson;
  get responseJson => _responseJson;

  CateLeftNavEnity _leftEnity;
  CateLeftNavEnity get leftEntity => _leftEnity;

  CateRightNavEnity _enity;
  CateRightNavEnity get rightEntity => _enity;

  String _currentSex = SEX_MAN;
  String get currentSex => _currentSex;

  int _listIndex = 0; //索引
  int get listIndex => _listIndex;

  setListIndex(int index) {
    _enity = null;
    _listIndex = index;
    notifyListeners();
    _getCategoryChild(_currentSex, _leftEnity.data[_listIndex].catId);
  }

  getCategory() {
    request('catePageContext', formData: getFormData({}, "GoodsCats/getTopCat")).then((val){
      _responseJson = val;
      List listData = (responseJson['data'] as List).cast();
      _leftEnity = CateLeftNavEnity.fromJson(listData);
      _getCategoryChild(_currentSex, _leftEnity.data[_listIndex].catId);
    });
  }

  setCurrentSex(String sex) {
    _leftEnity = null;
    _enity = null;
    _currentSex = sex;
    notifyListeners();
    getCategory();
  }

  _getCategoryChild(String sex, int catId) async {
    FormData formData = getFormData({"sex": sex, "catId": catId.toString()}, "GoodsCats/getTopCat");
    await request('cateGoodsListContext', formData: formData).then((val){
      var responseJson = val;
      List listData = (responseJson['data'] as List).cast();
      _enity = CateRightNavEnity.fromJson(listData);
      notifyListeners();
    });
  }
} 