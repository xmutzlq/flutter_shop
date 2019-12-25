import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/config/service_url.dart';

class CommItemHor extends StatelessWidget {
  
  final String img;
  final String name;
  final int price;
  final int marketPrice;

  CommItemHor(this.img, this.name, this.price, this.marketPrice);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(180),
            height: ScreenUtil().setHeight(180),
            child: new ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Image.network(urlParser(img)),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 15),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 5),
                    child: Text(
                      name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        wordSpacing: 0.0, //单词间隙(负值可以让单词更紧凑)
                        letterSpacing: 0.0, //字母间隙(负值可以让字母更紧凑)
                        color:Colors.black87, 
                        fontSize: ScreenUtil().setSp(30)
                      )
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        marketPrice == null ? 'RMB/$price' : '¥$price', 
                        maxLines: 1,
                        style: TextStyle(
                          color: marketPrice != null ? Colors.black : Colors.grey, 
                          fontSize: ScreenUtil().setSp(28),
                          letterSpacing: 0.0
                        ), 
                        overflow: TextOverflow.ellipsis,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text(
                          '${marketPrice == null ? "" : "¥$marketPrice"}', 
                          maxLines: 1,
                          style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color:Colors.grey, 
                            fontSize: ScreenUtil().setSp(25),
                            letterSpacing: 0.0
                          ), 
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ) 
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}