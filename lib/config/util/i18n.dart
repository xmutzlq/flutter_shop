import 'package:flutter/material.dart';
import 'package:flutter_shop/config/string_constant.dart';

class I18N {
  final Locale locale;

  I18N(this.locale);

  static Map<String, Map<String,String>> _localizedValues = {
    'en': StringConstant.EN,//英文
    'zh': StringConstant.ZN,//中文
  };

  static I18N of(BuildContext context) {
    return Localizations.of(context, I18N);
  }

  get loading {
    return _localizedValues[locale.languageCode]['loading'];
  }

  get dataEmpty {
    return _localizedValues[locale.languageCode]['data_empty'];
  }

  get dataCommentEmpty {
    return _localizedValues[locale.languageCode]['data_comment_empty'];
  }

  get dataRecommendEmpty {
    return _localizedValues[locale.languageCode]['data_recommend_empty'];
  }

  get seeAll {
    return _localizedValues[locale.languageCode]['see_all'];
  }

  get getService {
    return _localizedValues[locale.languageCode]['server'];
  }

  get getChoice {
    return _localizedValues[locale.languageCode]['choice'];
  }

  get getSearch {
    return _localizedValues[locale.languageCode]['search'];
  }

  get title {
    return _localizedValues[locale.languageCode]['title'];
  }

  get bottomNavigationHome {
    return _localizedValues[locale.languageCode]['bottom_navigate_home'];
  }

  get bottomNavigationCate {
    return _localizedValues[locale.languageCode]['bottom_navigate_cate'];
  }

  get bottomNavigationCart {
    return _localizedValues[locale.languageCode]['bottom_navigate_cart'];
  }

  get bottomNavigationUser {
    return _localizedValues[locale.languageCode]['bottom_navigate_user'];
  }

  get scan {
    return _localizedValues[locale.languageCode]['scan'];
  }

  get code {
    return _localizedValues[locale.languageCode]['code'];
  }

  get male {
    return _localizedValues[locale.languageCode]['male'];
  }

  get female {
    return _localizedValues[locale.languageCode]['female'];
  }

  get tabGoods {
    return _localizedValues[locale.languageCode]['tab_goods'];
  }

  get tabDetail {
    return _localizedValues[locale.languageCode]['tab_detail'];
  }

  get tabComment {
    return _localizedValues[locale.languageCode]['tab_comment'];
  }

  get tabRecommend {
    return _localizedValues[locale.languageCode]['tab_recommend'];
  }

  get goodsDetailTitle {
    return _localizedValues[locale.languageCode]['goods_detail_title'];
  }

  get goodsDetailTip {
    return _localizedValues[locale.languageCode]['goods_detail_tip'];
  }

  get goodsLikeTip {
    return _localizedValues[locale.languageCode]['goods_like_tip'];
  }

  get goodsCommentTip {
    return _localizedValues[locale.languageCode]['goods_comment_tip'];
  }

  get btnSearch {
    return _localizedValues[locale.languageCode]['search_btn'];
  }

  get searchHistory {
    return _localizedValues[locale.languageCode]['search_history'];
  }

  get buyBtn {
    return _localizedValues[locale.languageCode]['buy_btn'];
  }

  get goodsListTitle {
    return _localizedValues[locale.languageCode]['goods_list_title'];
  }

  get goodsSortDefault {
    return _localizedValues[locale.languageCode]['goods_sort_default'];
  }

  get goodsSortAsc {
    return _localizedValues[locale.languageCode]['goods_price_sort_asc'];
  }

  get goodsSortDesc {
    return _localizedValues[locale.languageCode]['goods_price_sort_desc'];
  }

  get goodsNewest {
    return _localizedValues[locale.languageCode]['goods_newest'];
  }

  get goodsLikely {
    return _localizedValues[locale.languageCode]['goods_likely'];
  }

  get goodsFilter {
    return _localizedValues[locale.languageCode]['goods_filter'];
  }

  get goodsAsc {
    return _localizedValues[locale.languageCode]['goods_asc'];
  }

  get goodsDesc {
    return _localizedValues[locale.languageCode]['goods_desc'];
  }

  get chosedTip {
    return _localizedValues[locale.languageCode]['chosed_tip'];
  }
  
  get chosedSize {
    return _localizedValues[locale.languageCode]['chosed_size'];
  }
}