import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/config/service_url.dart';
import 'package:flutter_shop/provide/provide_goods_list.dart';
import 'package:flutter_shop/store/store.dart';

class HomeBrand extends StatelessWidget {
  final String brandImg;
  final List brandList;
  HomeBrand({Key key, this.brandList, this.brandImg}) : super(key: key);

  Widget _gridViewItemUI(BuildContext context, item) {
    return InkWell(
      onTap: ()=> Store.value<ProvideGoodsList>(context).goGoodsListPageNormal(context, item['urlids'], ""),
      child: Center(
        child: Image.network(urlParser(item['imageUrl'])),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(0, 15.0, 0, 0),
          child: Image.network(urlParser(brandImg), width: ScreenUtil().setWidth(160)),
        ),
        GridView.count(
          //内容适配(非常重要的一个属性)
          shrinkWrap: true,
          //水平子Widget的个数
          crossAxisCount: 4,
          //水平子Widget之间间距
          crossAxisSpacing: 15.0,
          //垂直子Widget之间间距
          mainAxisSpacing: 15.0,
          //子Widget宽高比
          childAspectRatio: 1,
          //去除滚动效果
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(15.0),
          children: brandList.map((item){
            return _gridViewItemUI(context, item);
          }).toList(),
        )
      ],
    ); 
  }
}