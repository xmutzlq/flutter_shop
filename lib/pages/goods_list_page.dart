import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/base/loading_empty_indicator.dart';
import 'package:flutter_shop/base/loading_indicator.dart';
import 'package:flutter_shop/base/loading_more_base.dart';
import 'package:flutter_shop/base/loadmore/load_more_goods_list.dart';
import 'package:flutter_shop/base/loadmore/model.dart';
import 'package:flutter_shop/config/ui_config.dart';
import 'package:flutter_shop/config/util/i18n.dart';
import 'package:flutter_shop/event/event_bus.dart';
import 'package:flutter_shop/provide/provide_goods_list.dart';
import 'package:flutter_shop/store/store.dart';
import 'package:flutter_shop/widget/comm_item.dart';
import 'package:flutter_shop/widget/comm_item_hor.dart';
import 'package:flutter_shop/widget/comm_text_field.dart';
import 'package:flutter_shop/widget/goods_filter_drawer.dart';
import 'package:flutter_shop/widget/popup_price_desc.dart';
import 'package:flutter_shop/widget/popup_window.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class GoodsListPage extends StatefulWidget {

  final String searchContent;
  final String _id;

  GoodsListPage(this._id, this.searchContent);

  @override
  _GoodsListPageState createState() => _GoodsListPageState();
}

class _GoodsListPageState extends State<GoodsListPage> with AutomaticKeepAliveClientMixin {
  List<String> priceSorts = [ I18N.of(Store.widgetCtx).goodsSortDefault,
                              I18N.of(Store.widgetCtx).goodsSortDesc,
                              I18N.of(Store.widgetCtx).goodsSortAsc,];
  List<String> sorts      = [ I18N.of(Store.widgetCtx).goodsSortDefault,
                              I18N.of(Store.widgetCtx).goodsDesc,
                              I18N.of(Store.widgetCtx).goodsAsc,];
  
  DataLoader _loader;
  //网络加载cancel
  CancelToken _cancelToken = new CancelToken();
  //Popwindow
  GlobalKey _popBottomKey = GlobalKey();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<GoodsFilterDrawerState> _drawerKey = GlobalKey<GoodsFilterDrawerState>();
  //EventBus句柄
  StreamSubscription _priceSubscription;
  StreamSubscription _arrowSubscription;
  StreamSubscription _filterSubscription;
  //保存当前价格排序类型[默认、升、降]
  int currentPriceSortIndex = 0; //默认

  GoodsFilterDrawer _goodsFilterDrawer;

  @override
  bool get wantKeepAlive => true;
  
  @override
  void initState() {
    print('商品列表initState');

    super.initState();

    _goodsFilterDrawer = GoodsFilterDrawer(key: _drawerKey,);
    
    _priceSubscription = eventBus.on<GoodsListSortByPriceEvent>().listen((data) => priceEventNotify(data));
    _arrowSubscription = eventBus.on<ArrowIconUpdateEvent>().listen((data) {
      Store.value<ProvideGoodsList>(context).setArrowUp();
    });
    _filterSubscription = eventBus.on<FilterCommitEvent>().listen((data){
      List<String> checkedUrlids = Store.value<ProvideGoodsList>(context).getAllCheckedUrlids();
      if(_loader.setUrlids(checkedUrlids)) {
        _loader.obtainData(true);
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((callback){
      Store.value<ProvideGoodsList>(context).reSet(); //清除缓存条件
    });

    _loader = DataLoader(widget._id, widget.searchContent, _cancelToken);
    _loader.obtainData(false);
  }

  ///选择价格排序后，EventBus通知此处回调
  void priceEventNotify(GoodsListSortByPriceEvent data) {
    if(data == null || data.priceSortType == null) return;
    if(ProvideGoodsList.SORT_TYPE_DEFAULT == data.priceSortType) {
      currentPriceSortIndex = 0;
      _loader.setPriceParams(1, 1);
    } else if(ProvideGoodsList.SORT_TYPE_DESC == data.priceSortType) {
      currentPriceSortIndex = 1;
      _loader.setPriceParams(3, 1);
    } else if(ProvideGoodsList.SORT_TYPE_AESC == data.priceSortType) {
      currentPriceSortIndex = 2;
      _loader.setPriceParams(3, 0);
    }
    Store.value<ProvideGoodsList>(context).setCurrentTab(ProvideGoodsList.TAB_PRICE);
    _loader.obtainData(true);
  }

  ///选择过滤条件后，EventBus通知此处回调

  @override
  void dispose() {
    _cancelToken.cancel("goods list cancelled");
    _loader.dispose();
    super.dispose();
    _priceSubscription.cancel();
    _arrowSubscription.cancel();
    _filterSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    print('商品列表build');
    return Scaffold(
      appBar: AppBar(
        title: Text(I18N.of(context).goodsListTitle),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(ScreenUtil().setHeight(UIConfig.app_bar_bottom_height)),
          child: Container(
            height: ScreenUtil().setHeight(UIConfig.app_bar_bottom_height),
            alignment: Alignment.center,
            child: Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: CommTextField(isEnable: false, hintStr: I18N.of(context).getSearch, isNeedPop: true,),
            ),
          ),
        ),
      ),
      body: Scaffold(
        key: _scaffoldKey,
        body: _goodsListFilterHor(),
        endDrawer: _goodsFilterDrawer,
        ///禁止手势划出
        drawerEdgeDragWidth: 0.0,
      ) 
    );
  }

  Widget _goodsListFilterHor() {
    return Store.connect<ProvideGoodsList>(builder: (_, goodsList, __){
      return Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => PopupWindow.showPopWindow(
                      context, "", _popBottomKey, PopDirection.bottom, PopPriceDesc(
                        currentSortIndex: currentPriceSortIndex,
                        defaultStr: priceSorts[0],
                        descStr: priceSorts[1],
                        aesStr: priceSorts[2],), 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          sorts[currentPriceSortIndex],
                          style: TextStyle(
                            color: goodsList.currentTab == ProvideGoodsList.TAB_PRICE ? 
                            Colors.purple : Colors.black),),
                          Icon(
                            goodsList.isArrowUp ? Icons.arrow_drop_up : Icons.arrow_drop_down, 
                            color: goodsList.currentTab == ProvideGoodsList.TAB_PRICE ? 
                            Colors.purple : Colors.black,)
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: (){
                      if(ProvideGoodsList.TAB_NEWEST != Store.value<ProvideGoodsList>(context).currentTab) {
                        Store.value<ProvideGoodsList>(context).setCurrentTab(ProvideGoodsList.TAB_NEWEST);
                        _loader.setPriceParams(5, 1);
                        _loader.obtainData(true);
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          I18N.of(context).goodsNewest,
                          style: TextStyle(
                              color: goodsList.currentTab == ProvideGoodsList.TAB_NEWEST ? 
                              Colors.purple : Colors.black),),
                      ],
                    )
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: (){
                      if(ProvideGoodsList.TAB_HOT != Store.value<ProvideGoodsList>(context).currentTab) {
                        Store.value<ProvideGoodsList>(context).setCurrentTab(ProvideGoodsList.TAB_HOT);
                        _loader.setPriceParams(2, 1);
                        _loader.obtainData(true);
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          I18N.of(context).goodsLikely,
                          style: TextStyle(
                              color: goodsList.currentTab == ProvideGoodsList.TAB_HOT ? 
                              Colors.purple : Colors.black),),
                      ],
                    )
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => Store.value<ProvideGoodsList>(context).setListStatu(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Store.value<ProvideGoodsList>(context).isListStatu ?
                        Image.asset('images/ic_grid.png', width: ScreenUtil().setWidth(40),) :
                        Image.asset('images/ic_list.png', width: ScreenUtil().setWidth(40),)
                      ],
                    )
                  )
                ),
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      _scaffoldKey.currentState.openEndDrawer();
                      // _drawerKey.currentState.showDrawer();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: ScreenUtil().setWidth(1),
                          height: ScreenUtil().setHeight(40),
                          color: Colors.grey[400],
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10, right: 5),
                          child: Text(I18N.of(context).goodsFilter),
                        ),
                        Image.asset('images/ic_filter.png', width: ScreenUtil().setWidth(40),),
                      ],
                    )
                  ),
                )
              ],
            )
          ),
          ///分割线
          Container(
            key: _popBottomKey,
            width: double.infinity, height: ScreenUtil().setHeight(2), color: Colors.grey[200],),
          ///列表
          Expanded(
            child: StreamBuilder<DataLoadMoreBase<GoodsList, Model>>(
              stream: _loader.stream,
              builder: (context, snapshot) {
                /// 监听滑动结束广播
                return NotificationListener<ScrollEndNotification>(onNotification: (notification) {
                  if (notification.depth != 0) return false;
                  if (notification.metrics.axisDirection != AxisDirection.down) return false;
                  if (notification.metrics.pixels < notification.metrics.maxScrollExtent) return false;

                  /// 如果没有更多, 服务返回错误信息, 网络异常, 那么不允许上拉加载更多
                  print('hasData = ''${snapshot.data == null}');
                  print('hasMore> = ''${snapshot.data.hasMore()}');
                  print('hasError = ''${snapshot.data.hasError}');
                  print('hasException = ''${snapshot.data.hasException}');
                  if (snapshot.data == null ||
                      !snapshot.data.hasMore() ||
                      snapshot.data.hasError ||
                      snapshot.data.hasException) return false;

                  // 加载更多
                  _loader.obtainData(false);
                  return false;
                },

                /// 下拉刷新
                child: RefreshIndicator(
                  child: _buildList(snapshot.data),
                  onRefresh: () => _loader.obtainData(true),
                )
              );
            }),
          )
        ],
      );
    });
  }

  Widget _buildList(DataLoadMoreBase<GoodsList, Model> dataLoader) {
    /// 初始化时LoadingView
    if (dataLoader == null) {
      return Container(
        child: SpinKitCircle(
          color: Theme.of(context).primaryColor,
        ),
      );
    }

    /// 没有数据时候显示的View构建
    if (!dataLoader.hasData) {
      return LoadingEmptyIndicator(dataLoader: dataLoader);
    }

    bool isListStatu = Store.value<ProvideGoodsList>(context).isListStatu;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          GridView.builder(
            padding: EdgeInsets.all(15.0),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: dataLoader.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //横轴元素个数
              crossAxisCount: isListStatu ? 1 : 2,
              //纵轴间距
              mainAxisSpacing: 15.0,
              //横轴间距
              crossAxisSpacing: 15.0,
              //子组件宽高长度比例
              childAspectRatio: isListStatu ? 4 : 0.70,
            ),
            itemBuilder: (BuildContext context, int index) {
              return AnimatedSwitcher(
                transitionBuilder: (child, anim){
                  return FadeTransition(opacity:anim, child: child);
                },
                duration: Duration(milliseconds: 300),
                child: isListStatu ? _listWidget(dataLoader, index) : _gridWidget(dataLoader, index),
              );
            }
          ),
          LoadingIndicator(dataLoader: dataLoader)
        ],
      ),
    );
    // 使用ListView和GirdView切换，widget build后会导致从头开始显示，不合适
    // return AnimatedSwitcher(
    //   transitionBuilder: (child, anim){
    //     return FadeTransition(opacity:anim, child: child);
    //   },
    //   duration: Duration(milliseconds: 300),
    //   child: Store.value<ProvideGoodsList>(context).isListStatu ?
    //     ListView.separated(
    //       itemCount: dataLoader.length + 1,
    //       physics: const AlwaysScrollableScrollPhysics(),
    //       separatorBuilder: (content, index) {
    //         return Container(height: ScreenUtil().setHeight(10), color: Colors.white);
    //       },
    //       itemBuilder: (context, index) {
    //         if (index == dataLoader.length) {
    //           return LoadingIndicator(dataLoader: dataLoader);
    //         } else {
    //           return Material(
    //             color: Colors.white,
    //             child: _listWidget(dataLoader, index),
    //           );
    //         }
    //       },
    //     )
    //     :
    //     SingleChildScrollView(
    //       child: Column(
    //         children: <Widget>[
    //           GridView.builder(
    //             padding: EdgeInsets.all(10.0),
    //             shrinkWrap: true,
    //             physics: const NeverScrollableScrollPhysics(),
    //             itemCount: dataLoader.length,
    //             //SliverGridDelegateWithFixedCrossAxisCount 构建一个横轴固定数量Widget
    //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //               //横轴元素个数
    //               crossAxisCount: 2,
    //               //纵轴间距
    //               mainAxisSpacing: 10.0,
    //               //横轴间距
    //               crossAxisSpacing: 10.0,
    //               //子组件宽高长度比例
    //               childAspectRatio: 0.70,
    //             ),
    //             itemBuilder: (BuildContext context, int index) {
    //               //Widget Function(BuildContext context, int index)
    //               return _gridWidget(dataLoader, index);
    //             }
    //           ),
    //           LoadingIndicator(dataLoader: dataLoader)
    //         ],
    //       ),
    //     ),
    // );
  }

  //List
  Widget _listWidget(DataLoadMoreBase<GoodsList, Model> dataLoader, int index) {
    return InkWell(
      child: Padding(
        padding: EdgeInsets.all(0),
        child: CommItemHor(
          dataLoader[index].goodsimg, 
          dataLoader[index].goodsname,
          dataLoader[index].shopprice,
          dataLoader[index].marketprice),
      ),
      onTap: () {
        Store.value<ProvideGoodsList>(context).goDetail(context, dataLoader[index].id);
      },
    );
  }

  //List
  Widget _gridWidget(DataLoadMoreBase<GoodsList, Model> dataLoader, int index) {
    return InkWell(
      onTap: () {
        Store.value<ProvideGoodsList>(context).goDetail(context, dataLoader[index].id);
      },
      child: CommItem(
        roundRectangle: true,
        img: dataLoader[index].goodsimg, 
        name: dataLoader[index].goodsname,
        price: dataLoader[index].shopprice.toString(),
        marketPrice : dataLoader[index].marketprice.toString()
      )
    );
  }
}