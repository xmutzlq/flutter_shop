import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/config/util/i18n.dart';
import 'package:flutter_shop/store/store.dart';

import 'cart_page.dart';
import 'category_page.dart';
import 'home_page.dart';
import 'member_page.dart';

class IndexPage extends StatefulWidget {
  
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> with WidgetsBindingObserver {

  PageController _pageController;

  List<BottomNavigationBarItem> getBottomTabs() {
    return [
      BottomNavigationBarItem(
        icon:Icon(CupertinoIcons.home),
        title:Text(I18N.of(Store.widgetCtx).bottomNavigationHome)
      ),
      BottomNavigationBarItem(
        icon:Icon(CupertinoIcons.search),
        title:Text(I18N.of(Store.widgetCtx).bottomNavigationCate)
      ),
      BottomNavigationBarItem(
        icon:Icon(CupertinoIcons.shopping_cart),
        title:Text(I18N.of(Store.widgetCtx).bottomNavigationCart)
      ),
      BottomNavigationBarItem(
        icon:Icon(CupertinoIcons.profile_circled),
        title:Text(I18N.of(Store.widgetCtx).bottomNavigationUser)
      ),
    ];
  }

  final List<Widget> tabBodies = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    MemberPage()
  ];
  int currentIndex= 0;
  var currentPage ;

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  void initState() {
    print('index_page initState');
    currentPage = tabBodies[currentIndex];
    _pageController = new PageController()..addListener(() {
      if (currentPage != _pageController.page.round()) {
        setState(() {
          currentPage = _pageController.page.round();
        });
      }
    });
    super.initState();
  }

  void onTap(int index) {
    _pageController.jumpToPage(index);
  }

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
      currentPage = tabBodies[currentIndex];
    });
  }

  void onLocaleStateChange() {
    setState(() {
      
    });
  }

  //重写 WidgetsBindingObserver 中的 didChangeAppLifecycleState
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    ///通过state判断App前后台切换
    if (state == AppLifecycleState.resumed) {

    }
  }

  //1、使用PageView+AutomaticKeepAliveClientMixin可以实现懒加载页面
  //2、使用IndexedStack实现的话，可以加载所有一级子页面
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return WillPopScope(
      onWillPop: () => _dialogExitApp(context),
      child: Scaffold(
        backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          items: getBottomTabs(),
          onTap: onTap,
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: onPageChanged,
          children: tabBodies,
          physics: NeverScrollableScrollPhysics(),
        )
      ),
    );
  }

  /// 单击提示退出
  Future<bool> _dialogExitApp(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        content: new Text("是否退出商城"),
        actions: <Widget>[
          new FlatButton(onPressed: () => Navigator.of(context).pop(false), child:  new Text("取消")),
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text("确定")
          ),
        ],
      )
    );
  }
}