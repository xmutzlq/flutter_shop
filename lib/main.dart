import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_shop/config/util/i18n_delegate.dart';
import 'package:flutter_shop/pages/index_page.dart';
import 'package:flutter_shop/provide/provide_locale_state.dart';
import 'package:flutter_shop/provide/provide_theme_state.dart';
import 'package:flutter_shop/routers/application.dart';
import 'package:flutter_shop/routers/routes.dart';
import 'package:flutter_shop/store/store.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    print('根部重建: $context');
    Store.context = context;
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;
    return Store.init(
      context: context,
      child:Container(
        child: Store.connect2<ThemeState, LocaleState>(builder: (_, themeState, localeState, __)=>
          MaterialApp(
            title: '新乐纪',
            debugShowCheckedModeBanner: false,
            onGenerateRoute: Application.router.generator,
            theme: themeState.themeData,
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              I18nDelegate.delegate, //添加
            ],
            locale: localeState.locale,
            supportedLocales: [localeState.locale],
            home: Builder(
              builder: (context) {
                Store.widgetCtx = context;
                print('widgetCtx: $context');
                return IndexPage();
              },
            ),
          )
        ),
      )
    );
  }
}