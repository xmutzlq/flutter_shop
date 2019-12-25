import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/config/service_url.dart';
import 'package:flutter_shop/provide/provide_goods_list.dart';
import 'package:flutter_shop/provide/provide_home.dart';
import 'package:flutter_shop/store/store.dart';
import 'package:flutter_shop/widget/comm_item.dart';

class HomeCollectionHor extends StatelessWidget {
  
  final String recommendImg;
  final String urlids;
  final List recommendList;

  HomeCollectionHor({Key key, this.recommendList, this.recommendImg, this.urlids}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _titleWidget(context),
          _recommendList()
        ],
      ),
    );
  }

  void imgClick(BuildContext context) {
    if(urlids != null) {
      Store.value<ProvideGoodsList>(context).goGoodsListPageNormal(context, urlids, "");
    }
  }

  Widget _titleWidget(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: ()=> imgClick(context),
        child: Image.network(urlParser(recommendImg)),
      ) 
    );
  }

  Widget _recommendList() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(7.5, 15.0, 7.5, 0),
      height: ScreenUtil().setHeight(310),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recommendList.length,
        itemBuilder: (context, index){
          return _item(context, index);
        },
      ),
    );
  }

  Widget _item(BuildContext context, index) {
    return InkWell(
      onTap: () => Store.value<ProvideHome>(context).goDetail(context, recommendList[index]),
      child: Container(
        alignment: Alignment.center,
        height: ScreenUtil().setHeight(310),
        width: ScreenUtil().setWidth(220),
        padding: EdgeInsets.fromLTRB(7.5, 0, 7.5, 0),
        child: CommItem(
          img: recommendList[index]['imageUrl'], name: recommendList[index]['goodsName'], price: recommendList[index]['shopPrice'],)
      ),
    );
  }
}