import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_shop/config/service_url.dart';
import 'package:flutter_shop/config/util/i18n.dart';
import 'package:flutter_shop/entity/detail_page_comment.dart';
import 'package:flutter_shop/entity/detail_page_entity.dart';
import 'package:flutter_shop/entity/detail_page_like.dart';
import 'package:flutter_shop/entity/detail_page_spec.dart';
import 'package:flutter_shop/entity/detail_wrap_child_node.dart';
import 'package:flutter_shop/entity/detail_wrap_parent_node.dart';
import 'package:flutter_shop/routers/application.dart';
import 'package:flutter_shop/service/service_method.dart';

class ProvideDetail with ChangeNotifier {

  var responseJson;
  String _goodsId;
  DetailPageEntity entity;

  //warp
  List<DetailWrapParentNode> _wrapNodes;
  List<DetailWrapParentNode> get wrapNodes => _wrapNodes;

  get goodsId => _goodsId;
  void setGoodsId(String goodsId) {
    _goodsId = goodsId;
  } 

  Spec getSpec() {
    return entity.spec;
  } 

  ///更新选择
  bool updateChildChecked(DetailWrapChildNode childNode) {
    int parentIndex;
    for (int i = 0; i < _wrapNodes.length; i++) {
      if(_wrapNodes[i].id == childNode.parentId) {
        parentIndex = i;
        break;
      }
    }

    int childIndex = _wrapNodes[parentIndex].goodsChilds.indexOf(childNode);
    if(_wrapNodes[parentIndex].goodsChilds[childIndex].isChecked) {
      return false;
    }

    for (DetailWrapChildNode childNode in _wrapNodes[parentIndex].goodsChilds) {
      childNode.isChecked = false;
    }

    _wrapNodes[parentIndex].goodsChilds[childIndex].isChecked = true;
    return true;
  }

  //构造过滤条件
  void buildWrapDatas() {
    _wrapNodes = List();
    //color
    DetailWrapParentNode detailWrapColorsParentNode = DetailWrapParentNode();
    detailWrapColorsParentNode.id = 0;
    detailWrapColorsParentNode.name = entity.spec.specDesItem.name;
    List<DetailWrapChildNode> childColorNodes = List();
    for (SpecDesList specDes in entity.spec.specDesItem.list) {
      DetailWrapChildNode detailWrapChildNode = DetailWrapChildNode();
      detailWrapChildNode.parentId = 0;
      detailWrapChildNode.id = specDes.itemId;
      detailWrapChildNode.name = specDes.itemName;
      detailWrapChildNode.isDisabel = false;
      detailWrapChildNode.isChecked = (specDes.isDefault == 1);
      childColorNodes.add(detailWrapChildNode);
    }
    detailWrapColorsParentNode.goodsChilds = childColorNodes;
    _wrapNodes.add(detailWrapColorsParentNode);

    //size
    DetailWrapParentNode detailWrapSizeParentNode = DetailWrapParentNode();
    detailWrapSizeParentNode.id = 1;
    detailWrapSizeParentNode.name = entity.spec.specSizeItem.name;
    List<DetailWrapChildNode> childSizeNodes = List();
    for (SpecDesList specDes in entity.spec.specSizeItem.list) {
      DetailWrapChildNode detailWrapChildNode = DetailWrapChildNode();
      detailWrapChildNode.parentId = 1;
      detailWrapChildNode.id = specDes.itemId;
      detailWrapChildNode.name = specDes.itemName;
      detailWrapChildNode.isDisabel = false;
      detailWrapChildNode.isChecked = specDes.isDefault == 1;
      childSizeNodes.add(detailWrapChildNode);
    }
    detailWrapSizeParentNode.goodsChilds = childSizeNodes;
    _wrapNodes.add(detailWrapSizeParentNode);

    //配送
    DetailWrapParentNode detailWrapSendParentNode = DetailWrapParentNode();
    detailWrapSendParentNode.id = 2;
    detailWrapSendParentNode.name = "取件方式";
    List<DetailWrapChildNode> childSendNodes = List();
    DetailWrapChildNode detailWrapKDChildNode = DetailWrapChildNode();
    detailWrapKDChildNode.parentId = 2;
    detailWrapKDChildNode.id = 0;
    detailWrapKDChildNode.name = "快递配送";
    detailWrapKDChildNode.isDisabel = true;
    detailWrapKDChildNode.isChecked = false;
    childSendNodes.add(detailWrapKDChildNode);
    DetailWrapChildNode detailWrapZQChildNode = DetailWrapChildNode();
    detailWrapZQChildNode.parentId = 2;
    detailWrapZQChildNode.id = 1;
    detailWrapZQChildNode.name = "到店自取";
    detailWrapZQChildNode.isDisabel = true;
    detailWrapZQChildNode.isChecked = false;
    childSendNodes.add(detailWrapZQChildNode);
    detailWrapSendParentNode.goodsChilds = childSendNodes;
    _wrapNodes.add(detailWrapSendParentNode);
  }

  //更新选中的内容
  String updateChoiceDetail(BuildContext context, [bool isNormal = true]) {
    String color = "";
    String size = "";
    if(wrapNodes != null) {
      if(wrapNodes.length > 0) {
        color = _getCheckedContent(0);
      }
      
      if(wrapNodes.length > 1) {
        size = _getCheckedContent(1);
      }
    }
    return _makeChoiceDetail(context, color, size, isNormal);
  }

  String _getCheckedContent(int index) {
    for (DetailWrapChildNode childNode in wrapNodes[index].goodsChilds) {
      if(childNode.isChecked) {
        return childNode.name;
      }
    }
    return "";
  }

  String _makeChoiceDetail(BuildContext context, String color, String size, bool isNormal) {
    return isNormal ?
    color + "；" + size 
      + I18N.of(context).chosedSize :
    I18N.of(context).chosedTip 
      + "“" + color + "；" + size 
      + I18N.of(context).chosedSize + "”";
  }

  String getCommentStr() {
    String commentCount = "0";
    if(entity.goodsAppr != null || entity.goodsAppr.length > 0) {
      commentCount = '${entity.goodsAppr.length}';
    }
    return '($commentCount)';
  }

  bool isCommentMore() {
    return entity != null && entity.goodsAppr != null && entity.goodsAppr.length > 0;
  }

  bool isLikeMore() {
    return entity != null && entity.like != null && entity.like.length > 0;
  }

  List<Like> getLikes() {
    return entity != null ? entity.like : null;
  }

  List<Comment> getCommentList() {
    return entity != null ? entity.goodsAppr : null;
  }

  String getDetailContentHtml() {
    return entity != null ? entity.goodsDesc : null;
  }

  goDetail(BuildContext context, var goodsId) {
    clearCache();
    Navigator.of(context).pop();
    Application.router.navigateTo(context,"/detail?id=$goodsId");
  }

  clearCache() {
    responseJson = null;
    entity = null;
  }

  getGoodsDetail() async {
    FormData formData = getFormData({"goodsId": _goodsId}, "Goods/goodsDetail");
    await request('detailPageContext', formData: formData).then((val){
      responseJson = val;
      entity = DetailPageEntity.fromJson(responseJson['data']);
      buildWrapDatas();
      notifyListeners();
    });
  }
}