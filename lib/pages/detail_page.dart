import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/config/util/i18n.dart';
import 'package:flutter_shop/event/event_bus.dart';
import 'package:flutter_shop/pages/detail_page_tab_comment.dart';
import 'package:flutter_shop/pages/detail_page_tab_recommend.dart';
import 'package:flutter_shop/pages/detail_page_tab_detail.dart';
import 'package:flutter_shop/pages/detail_page_tab_goods.dart';
import 'package:flutter_shop/provide/prvide_detail.dart';
import 'package:flutter_shop/store/store.dart';
import 'package:flutter_shop/widget/comm_img_btn.dart';

class DetailPage extends StatefulWidget {
  final String goodsId;

  DetailPage(this.goodsId);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> with SingleTickerProviderStateMixin {
  StreamSubscription _tabChangeSubscription;
  final tabBarList = _tabDataList.map((item) => item.tab).toList();
  final tabBarViewList = _tabDataList.map((item) => item.body).toList();

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      vsync: this,//固定写法
      length: 4
    );

    WidgetsBinding.instance.addPostFrameCallback((callback){
      Store.value<ProvideDetail>(context).setGoodsId(widget.goodsId);
    });
    
    _tabChangeSubscription = eventBus.on<TabBarChangeEvent>().listen((data) {
      TabBarChangeEvent tabBarChangeEvent = data;
      _tabController.animateTo(tabBarChangeEvent.index);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabChangeSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(I18N.of(context).goodsDetailTitle),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: ScreenUtil().setHeight(70),
              alignment: Alignment.center,
              color: Theme.of(context).primaryColor,
              child: TabBar(
                controller: _tabController,
                isScrollable: true,
                indicatorColor: Colors.purple,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorWeight: 2.0,
                unselectedLabelColor: Colors.white,
                unselectedLabelStyle: TextStyle(fontSize: ScreenUtil().setSp(35)),
                labelColor: Colors.purple,
                labelStyle: TextStyle(fontSize: ScreenUtil().setSp(35)),
                tabs: tabBarList,
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: tabBarViewList,
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Divider(height: 0.5, color: Colors.grey[300],),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      InkWell(
                        onTap: (){Navigator.pop(context);},
                        child: Container(
                          margin: EdgeInsets.only(left: 15),
                          padding: EdgeInsets.all(16),
                          child: Icon(CupertinoIcons.home, size: 30,),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 20),
                        child: CommImgButton(imgpath:'images/right_gradient_full_btn.png', 
                          text:I18N.of(context).buyBtn, onPress: () {})
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      );
  }
}

final _tabDataList = <_TabData>[
  _TabData(tab: Text(I18N.of(Store.widgetCtx).tabGoods), body: DetailTabGoods()),
  _TabData(tab: Text(I18N.of(Store.widgetCtx).tabDetail), body: DetailTabDetail()),
  _TabData(tab: Text(I18N.of(Store.widgetCtx).tabComment), body: DetailTabComment()),
  _TabData(tab: Text(I18N.of(Store.widgetCtx).tabRecommend), body: DetailTabRecomment())
];

class _TabData {
  final Widget tab;
  final Widget body;
  _TabData({this.tab, this.body});
}
