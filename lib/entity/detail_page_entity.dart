import 'package:flutter_shop/entity/detail_page_comment.dart';
import 'package:flutter_shop/entity/detail_page_like.dart';
import 'package:flutter_shop/entity/detail_page_spec.dart';

class DetailPageEntity {
  int goodsId;
  String goodsSn;
  String productNo;
  String goodsName;
  String goodsImg;
  String goodsVideo;
  int shopId;
  int goodsType;
  String marketPrice;
  String shopPrice;
  String salePrice;
  String bakPrice;
  int goodsStock;
  int webStock;
  String goodsUnit;
  int goodsCatId;
  int shopCatId1;
  int shopCatId2;
  int brandId;
  String goodsDesc;
  int saleNum;
  String updateTIme;
  List<dynamic> gallery;
  List<Comment> goodsAppr;
  List<Like> like;
  Spec spec;
  DefaultSpecs defaultSpecs;

  DetailPageEntity({
    this.goodsId,
    this.goodsSn,
    this.productNo,
    this.goodsName,
    this.goodsImg,
    this.goodsVideo,
    this.shopId,
    this.goodsType,
    this.marketPrice,
    this.shopPrice,
    this.salePrice,
    this.bakPrice,
    this.goodsStock,
    this.webStock,
    this.goodsUnit,
    this.goodsCatId,
    this.shopCatId1,
    this.shopCatId2,
    this.brandId,
    this.goodsDesc,
    this.saleNum,
    this.updateTIme,
    this.gallery,
    this.goodsAppr,
    this.like,
    this.spec,
    this.defaultSpecs,
  });

  factory DetailPageEntity.fromJson(Map<String, dynamic> parsedJson) {
    Spec spec = Spec.fromJson(parsedJson['spec']);
    DefaultSpecs defaultSpecs = DefaultSpecs.fromJson(parsedJson['defaultSpecs']);

    var originCommentList = parsedJson['goodsAppr'] as List;
    List<Comment> commentList = originCommentList.map((value) => Comment.fromJson(value)).toList();

    var originLikeList = parsedJson['like'] as List;
    List<Like> likeList = originLikeList.map((value) => Like.fromJson(value)).toList();

    return DetailPageEntity(
      goodsId: parsedJson['goodsId'],
      goodsSn: parsedJson['goodsSn'],
      productNo: parsedJson['productNo'],
      goodsName: parsedJson['goodsName'],
      goodsImg: parsedJson['goodsImg'],
      goodsVideo: parsedJson['goodsVideo'],
      shopId: parsedJson['shopId'],
      goodsType: parsedJson['goodsType'],
      marketPrice: parsedJson['marketPrice'],
      shopPrice: parsedJson['shopPrice'],
      salePrice: parsedJson['salePrice'],
      bakPrice: parsedJson['bakPrice'],
      goodsStock: parsedJson['goodsStock'],
      webStock: parsedJson['webStock'],
      goodsUnit: parsedJson['goodsUnit'],
      goodsCatId: parsedJson['goodsCatId'],
      shopCatId1: parsedJson['shopCatId1'],
      shopCatId2: parsedJson['shopCatId2'],
      brandId: parsedJson['brandId'],
      goodsDesc: parsedJson['goodsDesc'],
      saleNum: parsedJson['saleNum'],
      updateTIme: parsedJson['updateTIme'],
      gallery: parsedJson['gallery'],
      goodsAppr: commentList,
      like: likeList,
      spec: spec,
      defaultSpecs: defaultSpecs,
    );
  }
}

