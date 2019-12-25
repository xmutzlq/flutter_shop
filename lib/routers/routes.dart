import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_shop/routers/router_handler.dart';

class Routes{
  static String root          = '/';
  static String detailsPage   = '/detail';
  static String searchPage    = '/search';
  static String goodsListPage = '/goods_list';

  static void configureRoutes(Router router){
    router.notFoundHandler = new Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params){
        print('ERROR====>ROUTE WAS NOT FONUND!!!');
      }
    );
    router.define(detailsPage,    handler:detailsHandler);
    router.define(searchPage,     handler:searchHandler);
    router.define(goodsListPage,  handler:goodsListHandler);
  }

}