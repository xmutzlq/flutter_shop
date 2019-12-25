import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_shop/pages/detail_page.dart';
import 'package:flutter_shop/pages/goods_list_page.dart';
import 'package:flutter_shop/pages/search_page.dart';

Handler detailsHandler = Handler(
  handlerFunc: (BuildContext context,Map<String, List<String>> params){
    String goodsId = params['id'].first;
    print('index>details goodsID is $goodsId');
    return DetailPage(goodsId);
  }
);

Handler searchHandler = Handler(
  handlerFunc: (BuildContext context,Map<String, List<String>> params){
    String input = params['input'].first;
    print('index>input content is $input');
    return SearchPage(inputContent: input,);
  }
);

Handler goodsListHandler = Handler(
  handlerFunc: (BuildContext context,Map<String, List<String>> params){
    String urlid = params["urlid"].first;
    String input = params['input'].first;
    print('index>input content is $input');
    return GoodsListPage(urlid, input,);
  }
);