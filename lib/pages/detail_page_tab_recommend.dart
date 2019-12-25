import 'package:flutter/material.dart';
import 'package:flutter_shop/config/util/i18n.dart';
import 'package:flutter_shop/entity/detail_page_like.dart';
import 'package:flutter_shop/provide/provide_home.dart';
import 'package:flutter_shop/provide/prvide_detail.dart';
import 'package:flutter_shop/store/store.dart';
import 'package:flutter_shop/widget/comm_item.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DetailTabRecomment extends StatefulWidget {
  @override
  _DetailTabRecommentState createState() => _DetailTabRecommentState();
}

class _DetailTabRecommentState extends State<DetailTabRecomment> with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive =>true;

  @override
  void initState() {
    super.initState();
    print('DetailTabRecomment initState');
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body:_recommentConent(),
    );
  }

  Widget _recommentConent() {
    return Store.connect<ProvideDetail>(builder:(context, goods, child){
      List reComments = (goods == null || goods.entity == null || goods.entity.like == null)
        ? Store.value<ProvideDetail>(context).getLikes() : goods.entity.like;
      return SingleChildScrollView(
        child: _checkRecommendContent(reComments),
      );
    });
  }

  Widget _checkRecommendContent(List reCommends) {
    if(reCommends == null) {
      return Center(
        child: SpinKitCircle(
          color: Theme.of(context).primaryColor,
        )
      );
    } else if(reCommends.length == 0) {
      return Center(child: Text(I18N.of(context).dataRecommendEmpty));
    } else {
      return Container(
        padding: EdgeInsets.only(left:10, right: 10),
        child: GridView.count(
          //内容适配(非常重要的一个属性)
          shrinkWrap: true,
          //水平子Widget的个数
          crossAxisCount: 3,
          //水平子Widget之间间距
          crossAxisSpacing: 7.0,
          //垂直子Widget之间间距
          mainAxisSpacing: 7.0,
          childAspectRatio: 0.6,
          //去除滚动效果
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.only(top:10.0, bottom: 10.0),
          children: reCommends.map((item){
            return _gridViewItemUI(context, item);
          }).toList(),
        )
      );
    }
  }

  Widget _gridViewItemUI(BuildContext context, item) {
    return InkWell(
      onTap: (){
        Store.value<ProvideDetail>(context).goDetail(context, (item as Like).goodsId);
      },
      child: Container(
        child: CommItem(roundRectangle: true, 
        img: item.goodsImg, name: item.goodsName, price: item.shopPrice, marketPrice: item.marketPrice,),
      )
    );
  }
}