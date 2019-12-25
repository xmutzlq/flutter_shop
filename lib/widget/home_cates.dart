import 'package:flutter/material.dart';
import 'package:flutter_shop/provide/provide_goods_list.dart';
import 'package:flutter_shop/store/store.dart';

class HomeCates extends StatelessWidget {

  final List cateShose; //鞋
  final List cateCloth; //衣
  final List cateAcces; //包

  HomeCates({Key key, this.cateShose, this.cateCloth, this.cateAcces}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                Image.asset('images/icon_sneaker.png', scale: 2.0,),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, item) {
                    return buildListData(context, cateShose[item]['text'], cateShose[item]['urlids']);
                  },
                  separatorBuilder: (BuildContext context, int index) => new Divider(
                    color: Colors.transparent,
                  ),
                  itemCount: cateShose.length
                ),
              ],
            ),
          ),
          
          Container(height: 350, child: VerticalDivider(color: Colors.black, width: 1.0,)),

          Expanded(
            child: Column(
              children: <Widget>[
                Image.asset('images/icon_clothing.png', scale: 2.0,),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, item) {
                    return buildListData(context, cateCloth[item]['text'], cateCloth[item]['urlids']);
                  },
                  separatorBuilder: (BuildContext context, int index) => new Divider(
                    color: Colors.transparent,
                  ),
                  itemCount: cateCloth.length
                ),
              ],
            ),
          ),

          Container(height: 350, child: VerticalDivider(color: Colors.black, width: 1.0,)),
          
          Expanded(
            child: Column(
              children: <Widget>[
                Image.asset('images/icon_accessories.png', scale: 2.0,),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, item) {
                    return buildListData(context, cateAcces[item]['text'], cateAcces[item]['urlids']);
                  },
                  separatorBuilder: (BuildContext context, int index) => new Divider(
                    color: Colors.transparent,
                  ),
                  itemCount: cateAcces.length
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void textClick(BuildContext context, String urlids) {
    if(urlids != null) {
      Store.value<ProvideGoodsList>(context).goGoodsListPageNormal(context, urlids, "");
    }
  }

  Widget buildListData(BuildContext context, String titleItem, String urlids) {
    return Container(
      padding: EdgeInsets.fromLTRB(14.0, 12.0, 0, 0),
      child: GestureDetector(
        onTap: ()=> textClick(context, urlids),
        child: Text(
          titleItem,
          style: TextStyle(fontSize: 15, color: Colors.black, decoration: TextDecoration.underline, decorationColor: Colors.black),
        ),
      )
    );
  }
}