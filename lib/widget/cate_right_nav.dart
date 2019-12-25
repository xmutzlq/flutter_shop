import 'package:flutter/material.dart';
import 'package:flutter_shop/config/service_url.dart';
import 'package:flutter_shop/config/util/i18n.dart';
import 'package:flutter_shop/entity/cate_right_nav_child.dart';
import 'package:flutter_shop/entity/cate_right_nav_entity.dart';
import 'package:flutter_shop/provide/provide_category.dart';
import 'package:flutter_shop/provide/provide_goods_list.dart';
import 'package:flutter_shop/store/store.dart';

class CateRightNav extends StatefulWidget {
  @override
  _CateRightNavState createState() => _CateRightNavState();
}

class _CateRightNavState extends State<CateRightNav> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Store.connect<ProvideCategory>(
        builder: (context, category, child){
          return Container(
            color: Colors.white,
            alignment: Alignment.topCenter,
            child: _rightContent(category.rightEntity)
          );
        }
      )
    );
  }

  Widget _rightContent(CateRightNavEnity enity) {
    if(enity == null) { //加载中
      return Center(child: Text(I18N.of(context).loading)); 
    } else if(enity.data == null || enity.data.length == 0) { //空数据
      return Center(child: Text(I18N.of(context).dataEmpty)); 
    } else {
      return GridView.count(
        //内容适配(非常重要的一个属性)
        shrinkWrap: true,
        //水平子Widget的个数
        crossAxisCount: 3,
        //水平子Widget之间间距
        crossAxisSpacing: 15.0,
        //垂直子Widget之间间距
        mainAxisSpacing: 15.0,
        childAspectRatio: 0.73,
        padding: EdgeInsets.all(15.0),
        children: enity.data.map((item){
          return _rightInkWell(item);
        }).toList(),
      );
    }
  }

  Widget _rightInkWell(CateRightNavChild child){
    return InkWell(
      onTap: (){
        Store.value<ProvideGoodsList>(context).goGoodsListPageNormal(context, child.urlids, child.catName);
      },
      child: Container(
        child: Column(
          children: <Widget>[
            Image.network(urlParser(child.catImg)),
            Container(
              padding: EdgeInsets.only(top: 10.0),
              child: Text(
                child.catName, 
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  wordSpacing: 0.0, //单词间隙(负值可以让单词更紧凑)
                  letterSpacing: 0.0, //字母间隙(负值可以让字母更紧凑)
                  color:Colors.black87, 
                  fontSize: 11
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}