import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/config/service_url.dart';
import 'package:flutter_shop/provide/provide_home.dart';
import 'package:flutter_shop/store/store.dart';
import 'package:flutter_shop/widget/comm_item.dart';

class HomeCollection extends StatelessWidget {
  final String collectionImg;
  final List collectionList;
  HomeCollection({Key key, this.collectionList, this.collectionImg}) : super(key: key);

  Widget _gridViewItemUI(BuildContext context, item) {
    return Store.connect<ProvideHome>(
      builder: (context, home, child) {
        return InkWell(
          onTap: (){
            home.goDetail(context, item);
          },
          child: Container(
            child: CommItem(img: item['imageUrl'], name: item['goodsName'], price: item['shopPrice']),
          )
        ); 
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(0, 15.0, 0, 0),
            child: Image.network(urlParser(collectionImg), width: ScreenUtil().setWidth(300)),
          ),
          GridView.count(
            //内容适配(非常重要的一个属性)
            shrinkWrap: true,
            //水平子Widget的个数
            crossAxisCount: 2,
            //水平子Widget之间间距
            crossAxisSpacing: 15.0,
            //垂直子Widget之间间距
            mainAxisSpacing: 15.0,
            childAspectRatio: 0.70,
            //去除滚动效果
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.all(15.0),
            children: collectionList.map((item){
              return _gridViewItemUI(context, item);
            }).toList(),
          )
        ],
      ),
    ); 
  }
}