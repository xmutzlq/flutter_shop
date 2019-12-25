import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/config/service_url.dart';
import 'package:flutter_shop/event/event_bus.dart';
import 'package:flutter_shop/provide/prvide_detail.dart';
import 'package:flutter_shop/store/store.dart';
import 'package:flutter_shop/widget/goods_detail_wrap.dart';
import 'package:transparent_image/transparent_image.dart';

class GoodsDetailBottomSheet extends StatefulWidget {
  final String img;
  final String price; //活动价

  GoodsDetailBottomSheet({Key key, this.img, this.price}) : super(key: key);

  @override
  _GoodsDetailBottomSheetState createState() => _GoodsDetailBottomSheetState();
}

class _GoodsDetailBottomSheetState extends State<GoodsDetailBottomSheet> {

  StreamSubscription _specsChangeSubscription;

  @override
  void initState() {
    super.initState();
    _specsChangeSubscription = eventBus.on<SpecsChangeEvent>().listen((data) {
      setState(() {
        
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _specsChangeSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    String choiceStr = Store.value<ProvideDetail>(context).updateChoiceDetail(context, false);
    return Container(
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(height: ScreenUtil().setHeight(50), color: Colors.transparent,),
                  Container(height: ScreenUtil().setHeight(150), color: Color.fromARGB(0xff, 0xfa, 0xfa, 0xfa),)
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    child: new ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: FadeInImage.memoryNetwork(
                        width:ScreenUtil().setWidth(200),
                        height:ScreenUtil().setHeight(200),
                        placeholder: kTransparentImage,
                        image: urlParser(widget.img),
                      ),
                    ),
                  ), 
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 15),
                      padding: EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '¥''${widget.price}',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(30),
                              color:Colors.black),
                              maxLines: 1),
                          Text(
                            choiceStr,
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(30),
                              color:Colors.black),
                              maxLines: 2),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 35,
                right: 10,
                child: InkWell(
                  onTap: (){Navigator.pop(context);},
                  child: Icon(CupertinoIcons.clear_circled),
                )
              )
            ],
          ),
          Container(
            color: Color.fromARGB(0xff, 0xfa, 0xfa, 0xfa),
            child: Divider(color: Colors.grey[300], height: 0.5,),
          ),
          //选择列表
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              color: Color.fromARGB(0xff, 0xfa, 0xfa, 0xfa),
              child: GoodsDetailWrap(),
            )
          ),
        ],
      ),
    );
  }
}