import 'package:dio/dio.dart';
import 'package:flutter_shop/base/loading_more_base.dart';
import 'package:flutter_shop/provide/provide_goods_list.dart';
import 'package:flutter_shop/service/service_method.dart';
import 'package:flutter_shop/store/store.dart';

import 'model.dart';
import 'dart:convert' as convert;

class DataLoader extends DataLoadMoreBase<GoodsList, Model> {
  bool _hasMore = true;

  String urlids; //筛选项
  String keyword; //输入框值
  CancelToken cancelToken;

  //价格升降排序参数
  int msort = 1;
  int mdesc = 1;

  DataLoader(this.urlids, this.keyword, this.cancelToken);

  //设置新品与人气的条件
  setPriceParams(int sort, int desc) {
    msort = sort;
    mdesc = desc;
  }

  //设置过滤条件("-"拼接并按升序排列))
  bool setUrlids(List<String> urlids) {
    String resultUrlids = this.urlids;
    //取this.urlids的第一个过滤条件
    if(resultUrlids != null && resultUrlids.length > 0) {
      List<String> urlidList = resultUrlids.split('-');
      if(urlidList != null && urlidList.length > 0) {
        resultUrlids = urlidList[0];
      }
    }
    print('first_urlid = ''$resultUrlids');
    print('filter_urlids = $urlids');
    //升序排序urlids
    urlids.sort((left,right) {
      if(left.codeUnitAt(1) > right.codeUnitAt(1)) {
        return 1;
      } else if(left.codeUnitAt(1) < right.codeUnitAt(1)) {
        return -1;
      }
      return 0;
    });
    print('filter_urlids_sorted = $urlids');
    //根据“-”拼接新的urlids
    for (int i = 0; i < urlids.length; i++) {
      if(resultUrlids != null && resultUrlids.length > 0) {
        resultUrlids += '-${urlids[i]}';
      } else {
        if(i == urlids.length - 1) {
          resultUrlids += '${urlids[i]}';
        } else {
          resultUrlids += '${urlids[i]}-';
        }
      }
    }
    print('resultUrlids = $resultUrlids');
    //如果是相同的条件，不需要查询
    if(resultUrlids == null || resultUrlids == this.urlids) {
      return false;
    }
    this.urlids = resultUrlids;
    return true;
  }

  @override
  Future<Model> getRequest(bool isRefresh, int currentPage, int pageSize) async {
    var formData = {"sprice" : 0.0, "eprice" : 0.0, "only" : 1,
    "urlids" : urlids, "keyword" : keyword, "page" : isRefresh ? 1 : currentPage - 1, "limit" : pageSize,
    "mdesc" : mdesc, "msort" : msort, "method" : "Lists/goodsList"};
    print(formData);
    String requestJson = convert.jsonEncode(formData);
    var responseJson = await request('goodsListContext', formData: requestJson, cancelToken: cancelToken);
    Model model = Model.fromJson(responseJson);
    return Model(model.code, model.msg, model.data);
  }

  @override
  Future<bool> handlerData(Model model, bool isRefresh) async {
    // 1. 判断是否有业务错误,
    // 2. 将数据存入列表, 如果是刷新清空数据
    // 3. 判断是否有更多数据
    if (model == null || model.isError()) {
      return false;
    }

    if (isRefresh) clear();

    addAll((model.data.goodsList));

    Store.value<ProvideGoodsList>(Store.widgetCtx).buildFilterDatas(model.data.filters);

    //是否更多数据
    _hasMore = (isRefresh ? 1 : tempCurrentPage) < model.data.totalPage;

    return true;
  }

  @override
  bool hasMore() => _hasMore;
}