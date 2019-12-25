import 'package:flutter/material.dart';
import 'package:flutter_shop/base/loadmore/model.dart';
import 'package:flutter_shop/entity/goods_list_child_node.dart';
import 'package:flutter_shop/entity/goods_list_parent_node.dart';
import 'package:flutter_shop/routers/application.dart';

class ProvideGoodsList with ChangeNotifier {
  //价格排序
  static const String SORT_TYPE_DEFAULT = "sort_type_default";
  static const String SORT_TYPE_DESC = "sort_type_desc";
  static const String SORT_TYPE_AESC = "sort_type_aesc";

  //选择项
  static const String TAB_PRICE = "tab_price";
  static const String TAB_NEWEST = "tab_newest";
  static const String TAB_HOT = "tab_hot";
  static const String TAB_FILTER = "tab_filter";

  //当前选项
  String _currentTab = TAB_PRICE;
  String get currentTab => _currentTab;
  void setCurrentTab(String tab) {
    _currentTab = tab;
    notifyListeners();
  }

  //是否列表模式
  bool _isListStatu = true;
  bool get isListStatu => _isListStatu;
  void setListStatu() {
    _isListStatu = !_isListStatu;
    notifyListeners();
  }

  //是否ArrowIcon为Up或者Down
  bool _isArrowUp = false;
  bool get isArrowUp => _isArrowUp;
  void setArrowUp() {
    _isArrowUp = !_isArrowUp;
    notifyListeners();
  }

  //过滤条件
  List<GoodsParentNode> _filterNodes;
  List<GoodsParentNode> get filterNodes => _filterNodes;

  ///获取过滤urlids条件
  List<String> getAllCheckedUrlids() {
    List<String> allCheckedUrlids = List();
    for (GoodsParentNode parentNode in _filterNodes) {
      for (GoodsChildNode childNode in parentNode.goodsChilds) {
        if(childNode.isChecked) {
          allCheckedUrlids.add(childNode.urlIds);
        }
      }
    }
    return allCheckedUrlids;
  }

  ///更新更多
  void updateParentExpended(GoodsParentNode parentNode, bool expend) {
    int parentIndex = _filterNodes.indexOf(parentNode);
    _filterNodes[parentIndex].isExpen = expend;
  }

  ///更新选择
  void updateChildChecked(GoodsChildNode childNode, bool isChecked) {
    int parentIndex;
    for (var i = 0; i < _filterNodes.length; i++) {
      if(_filterNodes[i].id == childNode.parentId) {
        parentIndex = i;
        break;
      }
    }
    int childIndex = _filterNodes[parentIndex].goodsChilds.indexOf(childNode);
    _filterNodes[parentIndex].goodsChilds[childIndex].isChecked = isChecked;
  }

  ///重置
  void reSetFilter() {
    for(int i = 0; i < _filterNodes.length; i++) {
      for(int j = 0; j < _filterNodes[i].goodsChilds.length; j++) {
        _filterNodes[i].goodsChilds[j].isChecked = false;
      }
    }
  }

  //构造过滤条件
  void buildFilterDatas(List<Filters> filters) {
    if(_filterNodes == null || _filterNodes.length == 0) {
      _filterNodes = List();
      for(int i = 0; i < filters.length; i++) {
        Filters parent = filters[i];
        List<GoodsChildNode> childNodes = List();
        GoodsParentNode pNode = GoodsParentNode();
        pNode.id = parent.pId;
        pNode.name = parent.pName;
        for (int i = 0; i < parent.c.length; i++) {
          C child = parent.c[i];
          GoodsChildNode cNode = GoodsChildNode();
          cNode.parentId = parent.pId;
          cNode.id = child.cId;
          cNode.name = child.cName;
          cNode.urlIds = child.cUrlId;
          cNode.isChecked = false;
          cNode.isDisabel = false;
          childNodes.add(cNode);
        }
        pNode.isExpen = false;
        pNode.goodsChilds = childNodes;
        _filterNodes.add(pNode);
      }
    }
  }

  goDetail(BuildContext context, var goodsId) {
    Application.router.navigateTo(context,"/detail?id=$goodsId");
  }

  goGoodsListPageNormal(BuildContext context, String urlid, String inputContent) {
    goGoodsListPage(context, urlid, inputContent, false);
  }

  goGoodsListPage(BuildContext context, 
    String urlid, String inputContent, bool popCurrentPage) {
    if(popCurrentPage) Navigator.of(context).pop();
    Application.router.navigateTo(context,"/goods_list?urlid=${Uri.encodeComponent(urlid)}&input=${Uri.encodeComponent(inputContent)}");
  }

  void reSet() {
    _currentTab = TAB_PRICE;
    _isListStatu = true;
    _isArrowUp = false;
    _filterNodes = null;
  }
}