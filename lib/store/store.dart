import 'package:flutter/material.dart' show BuildContext;
import 'package:flutter_shop/config/global_config.dart';
import 'package:flutter_shop/provide/provide_card.dart';
import 'package:flutter_shop/provide/provide_category.dart';
import 'package:flutter_shop/provide/provide_goods_list.dart';
import 'package:flutter_shop/provide/provide_home.dart';
import 'package:flutter_shop/provide/provide_search.dart';
import 'package:flutter_shop/provide/provide_theme_state.dart';
import 'package:flutter_shop/provide/prvide_detail.dart';
import 'package:provider/provider.dart'
  show ChangeNotifierProvider, Consumer, Consumer2, Consumer3, MultiProvider, Provider;

class Store {
  static BuildContext context;
  static BuildContext widgetCtx;

  static init({context, child}) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (_) => ProvideHome()),
        ChangeNotifierProvider(builder: (_) => ProvideCategory()),
        ChangeNotifierProvider(builder: (_) => ProvideDetail()),
        ChangeNotifierProvider(builder: (_) => ProvideCard()),
        ChangeNotifierProvider(builder: (_) => ProvideSearch()),
        ChangeNotifierProvider(builder: (_) => ProvideGoodsList()),
        ChangeNotifierProvider(builder: (_) => ThemeState(GlobalConfig.initIndex, GlobalConfig.initThemeData)),
        ChangeNotifierProvider(builder: (_) => GlobalConfig.language),
      ],
      child: child,
    );
  }

  //  通过Provider.value<T>(context)获取状态数据
  static T value<T>(context) {
    return Provider.of(context);
  }

  //  通过Consumer获取状态数据
  static Consumer connect<T>({builder, child}) {
    return Consumer<T>(builder: builder, child: child);
  }

  static Consumer2 connect2<T1, T2>({builder, child}) {
    return Consumer2<T1, T2>(builder: builder, child: child);
  }

  static Consumer3 connect3<T1, T2, T3>({builder, child}) {
    return Consumer3<T1, T2, T3>(builder: builder, child: child);
  }
}