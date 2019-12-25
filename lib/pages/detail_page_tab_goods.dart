import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/config/service_url.dart';
import 'package:flutter_shop/config/string_constant.dart';
import 'package:flutter_shop/config/ui_config.dart';
import 'package:flutter_shop/config/util/i18n.dart';
import 'package:flutter_shop/entity/detail_page_like.dart';
import 'package:flutter_shop/event/event_bus.dart';
import 'package:flutter_shop/provide/prvide_detail.dart';
import 'package:flutter_shop/store/store.dart';
import 'package:flutter_shop/widget/comm_item.dart';
import 'package:flutter_shop/widget/goods_detail_bottomsheet.dart';
import 'package:flutter_shop/widget/goods_detail_fraction_pagination.dart';
import 'package:flutter_shop/widget/goods_detail_spec_value.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class DetailTabGoods extends StatefulWidget {
  @override
  _DetailTabGoodsState createState() => _DetailTabGoodsState();
}

class _DetailTabGoodsState extends State<DetailTabGoods> with AutomaticKeepAliveClientMixin {
  
  @override
  bool get wantKeepAlive =>true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((callback){
      Store.value<ProvideDetail>(context).getGoodsDetail();
    });
    print('DetailTabGoods initState');
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _detailGoodsContent(context);
  }

  @override
  void deactivate() {
    super.deactivate();
    Store.value<ProvideDetail>(context).clearCache();
  }
}

Widget _detailGoodsContent(BuildContext context) {
  var data = Store.value<ProvideDetail>(context).responseJson;
  if(data != null) {
    print('渲染商品数据');
    return Store.connect<ProvideDetail>(builder: (context, goods, child) {
      return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SwiperDiy(swiperDataList:goods.entity.gallery),//页面顶部轮播组件
            _titleContent(goods.entity.goodsName, goods.entity.shopPrice, goods.entity.marketPrice),
            _choiceContent(context, goods.entity.goodsImg, goods.entity.shopPrice, goods.entity.marketPrice),
            _commentContent(context),
            _guessLike(context),
            _detailContentHtml(context),
          ],
        ),
      );
    });
  } else {
    return Center(
      child: SpinKitCircle(
        color: Theme.of(context).primaryColor,
      )
    );
  }
}

Widget _titleContent(String title, String preferentialPrice, String price) {
  return Container(
    color:Colors.white,
    padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
    child: Column(
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(35),
            color:Colors.black),
            maxLines: 2),
        Container(
          padding: EdgeInsets.only(top: 6),
          child: Row(
            children: <Widget>[
              Text(
                '¥''$preferentialPrice',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(30),
                  color:Colors.black),
                  maxLines: 1),
              Container(
                padding: EdgeInsets.only(left: 12),
                child: Text(
                  '¥''$price',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(30),
                    color:Colors.grey[400],
                    decoration: TextDecoration.lineThrough
                  ),
                  maxLines: 1
                ),
              )
            ],
          )
        )
      ],
    ),
  );
}

Widget _choiceContent(BuildContext context, String img, String preferentialPrice, String price) {
  String realPrice = preferentialPrice != null && preferentialPrice.length > 0 ? preferentialPrice : price;
  return Container(
    color:Colors.white,
    margin: EdgeInsets.only(top: 8),
    padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
    child: Column(
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(right: 12, bottom: 5, top: 5),
              child: Text(
                I18N.of(context).getChoice,
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(30),
                  color: Colors.grey[400]
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(right: 0, bottom: 5, top: 5),
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: (){
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (context) => GoodsDetailBottomSheet(img: img, price: realPrice,),
                    );
                  },
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: GoodsDetailSpecValue(),
                      ),
                      Icon(Icons.keyboard_arrow_right, color: Colors.purple,)
                    ],
                  ),
                ),
              )
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(right: 12, top: 5, bottom: 5),
              child: Text(
                I18N.of(context).getService,
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(30),
                  color: Colors.grey[400]),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(right: 12, top: 5, bottom: 5),
                child: Text(
                  StringConstant.shopServiceStr,
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(30),
                    color: Colors.black54,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
          ],
        )
      ],
    )
  );
}

Widget _commentContent(BuildContext context) {
  bool isMore = Store.value<ProvideDetail>(context).isCommentMore();
  return Container(
    color:Colors.white,
    margin: EdgeInsets.only(top: 8),
    padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
    child: Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              I18N.of(context).goodsCommentTip, 
              style: TextStyle(
                fontSize: ScreenUtil().setSp(30),
                color: Colors.black54,
              )
            ),
            Expanded(
              child: Text(
                Store.value<ProvideDetail>(context).getCommentStr(),
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(30),
                  color: Theme.of(context).primaryColor
                ),
              ),
            ),
            isMore ? 
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                eventBus.fire(TabBarChangeEvent(2));
              },
              child: Row(
                children: <Widget>[
                  Text(
                    I18N.of(context).seeAll, 
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(30),
                      color: Colors.purple,
                    )
                  ),
                  Icon(Icons.keyboard_arrow_right, color: Colors.purple,)
                ],
              ),
            ) : Container()
          ],
        ),
        //评价列表
        _commentList(context),
      ],
    ),
  );
}

Widget _commentList(BuildContext context) {
  List commentList = Store.value<ProvideDetail>(context).getCommentList();
  return Container(
    child: ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: commentList.length,
      itemBuilder: (context, index){
        return _commentItem(commentList, index);
      },
    )
  );
}

Widget _commentItem(List commentList, int index) {
  return InkWell(
    onTap: (){},
    child: Container(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 10),
                width: ScreenUtil().setWidth(60),
                height: ScreenUtil().setHeight(50),
                child: CircleAvatar(
                  radius: 100.0,
                  backgroundImage: NetworkImage(commentList[index].userPhoto),
                  backgroundColor: Colors.grey[400],
                ),
              ),
              Text(
                commentList[index].loginName,
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(25),
                  color: Colors.black54,
                )
              )
            ],
          ),
          commentList[index].content != null ?
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
              commentList[index].content,
              style: TextStyle(
                fontSize: ScreenUtil().setSp(30),
                color: Colors.black54,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ) : Container()
        ],
      ),
    )
  );
}

Widget _guessLike(BuildContext context) {
  bool isMore = Store.value<ProvideDetail>(context).isLikeMore();
  return Container(
    color:Colors.white,
    margin: EdgeInsets.only(top: 8),
    padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
    child: Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                I18N.of(context).goodsLikeTip, 
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(30),
                  color: Colors.black54,
                )
              ),
            ),
            isMore ? 
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: (){eventBus.fire(TabBarChangeEvent(3));},
              child: Row(
                children: <Widget>[
                  Text(
                    I18N.of(context).seeAll, 
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(30),
                      color: Colors.purple,
                    )
                  ),
                  Icon(Icons.keyboard_arrow_right, color: Colors.purple,)
                ],
              )
            ) : Container()
          ],
        ),
        //评价列表
        GridView.count(
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
          children: Store.value<ProvideDetail>(context).getLikes().map((item){
            return _gridViewItemUI(context, item);
          }).toList(),
        ),
      ],
    ),
  );
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

Widget _detailContentHtml(BuildContext context) {
  return Container(
    color:Colors.white,
    margin: EdgeInsets.only(top: 8),
    padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Text(
            I18N.of(context).goodsDetailTip, 
            style: TextStyle(
              fontSize: ScreenUtil().setSp(35),
              color: Colors.grey
            ),
          ),
        ),
        Html(
          data: Store.value<ProvideDetail>(context).getDetailContentHtml(),
        )
      ],
    ),
  );
}

// 首页轮播组件编写
class SwiperDiy extends StatelessWidget {
  final List swiperDataList;
  SwiperDiy({Key key,this.swiperDataList}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(UIConfig.detail_banner_height),
      child: Swiper(
        itemBuilder: (BuildContext context,int index){
          String imgUrl = urlParser(swiperDataList[index].toString());
          return Image.network(imgUrl, fit:BoxFit.fill);
        },
        autoplayDelay: 5000,
        autoplayDisableOnInteraction:true, //当用户拖拽的时候，停止自动播放
        itemCount: swiperDataList.length,
        pagination: new SwiperPagination(
          builder: new GoodsDetailFractionPagination(
            activeColor: Colors.white,
            color: Colors.white,
            activeFontSize: 12.0,
            fontSize: 12.0,
          ),
          alignment: Alignment.bottomRight
        ),
        autoplay: false,
      ),
    );
  }
}