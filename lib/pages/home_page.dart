import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/config/service_url.dart';
import 'package:flutter_shop/config/ui_config.dart';
import 'package:flutter_shop/config/util/i18n.dart';
import 'package:flutter_shop/provide/provide_home.dart';
import 'package:flutter_shop/store/store.dart';
import 'package:flutter_shop/widget/home_ad_flow.dart';
import 'package:flutter_shop/widget/home_brand.dart';
import 'package:flutter_shop/widget/comm_top_row.dart';
import 'package:flutter_shop/widget/home_cates.dart';
import 'package:flutter_shop/widget/home_collection.dart';
import 'package:flutter_shop/widget/home_collection_hor.dart';
import 'package:flutter_shop/widget/home_flow.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {

  GlobalKey<RefreshHeaderState> refreshKey = new GlobalKey<RefreshHeaderState>();

  @override
  bool get wantKeepAlive =>true;

  @override
  void initState() {
    print('HomePage_initState');
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((callback){
      Store.value<ProvideHome>(context).getHome();
    });
  }

  @override
  void didChangeDependencies() {
    print('HomePage_didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print('HomePage_build');
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(I18N.of(context).title),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(ScreenUtil().setHeight(UIConfig.app_bar_bottom_height)),
          child: Container(
            height: ScreenUtil().setHeight(UIConfig.app_bar_bottom_height),
            alignment: Alignment.center,
            child: CommTopRow(),
          ),
        ),
      ),
      body: _homeContent(),
    );
  }

  Widget _homeContent() {
    var data = Store.value<ProvideHome>(context).responseJson;
    if(data != null){
      print('渲染首页数据');
      return Store.connect<ProvideHome>(builder: (context, home, child) {
        return EasyRefresh(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                ///首页顶部轮播组件
                SwiperDiy(swiperDataList:home.swiperDataList),
                ///首页BRAND
                HomeBrand(brandList:home.brandList, brandImg:home.flagImgs[0]['imageUrl']),
                ///首页Brand下面两张图片
                HomeFlow(flowImg1:home.flagImgs[1]['imageUrl'], flowImg2:home.flagImgs[2]['imageUrl']),
                ///首页NEW COLLECTION
                HomeCollection(collectionList:home.collectionList, collectionImg: home.flagImgs[3]['imageUrl'],),
                ///首页横向列表1
                HomeCollectionHor(recommendList: home.collectionHorList, recommendImg: home.flagImgs[4]['imageUrl'],),
                ///首页COLLECTION广告
                HomeAdFlow(adList: home.ads,),
                ///首页三个菜单项
                HomeCates(cateShose: home.shoseCate, cateCloth: home.clothCate, cateAcces: home.accesCate,),
                ///首页横向列表-板鞋
                HomeCollectionHor(recommendList: home.catesBxHorList, 
                  recommendImg: home.flagImgs[11]['imageUrl'], urlids: home.flagImgs[11]['urlids']),
                ///首页横向列表-休闲鞋
                HomeCollectionHor(recommendList: home.catesXxHorList, 
                  recommendImg: home.flagImgs[12]['imageUrl'], urlids: home.flagImgs[12]['urlids']),
                ///首页横向列表-跑步鞋
                HomeCollectionHor(recommendList: home.catesPbHorList, 
                  recommendImg: home.flagImgs[13]['imageUrl'], urlids: home.flagImgs[13]['urlids']),
                ///首页横向列表-篮球鞋
                HomeCollectionHor(recommendList: home.catesLqHorList, 
                  recommendImg: home.flagImgs[14]['imageUrl'], urlids: home.flagImgs[14]['urlids']),
                ///首页横向列表-卫衣
                HomeCollectionHor(recommendList: home.catesWyHorList, 
                  recommendImg: home.flagImgs[15]['imageUrl'], urlids: home.flagImgs[15]['urlids']),
                ///首页横向列表-卫裤
                HomeCollectionHor(recommendList: home.catesWkHorList, 
                  recommendImg: home.flagImgs[16]['imageUrl'], urlids: home.flagImgs[16]['urlids'],),
              ],
            ),
          ),
          firstRefresh: false,
          refreshHeader: MaterialHeader(
            key: refreshKey,
          ),
          onRefresh: () async {
            Store.value<ProvideHome>(context).getHome();
          },
        ); 
      });
    }else{
      return Center(
        child: SpinKitCircle(
          color: Theme.of(context).primaryColor,
        )
      );
    }
  }
}

// 首页轮播组件编写
class SwiperDiy extends StatelessWidget {
  final List swiperDataList;
  SwiperDiy({Key key,this.swiperDataList}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(UIConfig.banner_height),
      child: Swiper(
        itemBuilder: (BuildContext context,int index){
          String imgUrl = urlParser(swiperDataList[index]['imageUrl']);
          return Image.network(imgUrl, fit:BoxFit.fill);
        },
        autoplayDelay: 5000,
        autoplayDisableOnInteraction:true, //当用户拖拽的时候，停止自动播放
        itemCount: swiperDataList.length,
        pagination: new SwiperPagination(builder: DotSwiperPaginationBuilder(
          color: Colors.white,
          activeColor: Theme.of(context).primaryColor,
          activeSize: 8
        )),
        autoplay: false,
      ),
    );
  }
}