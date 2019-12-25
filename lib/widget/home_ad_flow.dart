import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/config/service_url.dart';
import 'package:flutter_shop/provide/provide_goods_list.dart';
import 'package:flutter_shop/store/store.dart';

class HomeAdFlow extends StatelessWidget {

  final List adList;

  HomeAdFlow({Key key, this.adList}) : super(key: key);

  void imgClick(BuildContext context, String urlids) {
    if(urlids != null) {
      Store.value<ProvideGoodsList>(context).goGoodsListPageNormal(context, urlids, "");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(0, 0, 0, 8.0),
            child: Image.network(urlParser(adList[0]['imageUrl']), width: ScreenUtil().setWidth(300)),
          ),
          GestureDetector(
            onTap: ()=> imgClick(context, adList[1]['urlids']),
            child: Image.network(urlParser(adList[1]['imageUrl'])),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
            child: Image.network(urlParser(adList[2]['imageUrl']), width: ScreenUtil().setWidth(300)),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(15.0, 0, 7.5, 15.0),
                  child: GestureDetector(
                    onTap: ()=> imgClick(context, adList[3]['urlids']),
                    child: Image.network(urlParser(adList[3]['imageUrl'])),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(7.5, 0, 15.0, 15.0),
                  child: GestureDetector(
                    onTap: ()=> imgClick(context, adList[4]['urlids']),
                    child: Image.network(urlParser(adList[4]['imageUrl'])),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}