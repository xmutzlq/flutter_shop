import 'package:flutter/material.dart';
import 'package:flutter_shop/config/service_url.dart';

class CommItem extends StatelessWidget {

  final bool roundRectangle;
  final String img, name, price, marketPrice;

  CommItem({Key key, this.roundRectangle, this.img, this.name, 
    this.price, this.marketPrice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        (roundRectangle != null && roundRectangle) ? 
        Container(
          child: new ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: Image.network(urlParser(img)),
          ),
        ) :
        Image.network(urlParser(img)),
        Container(
          margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
          alignment: Alignment.centerLeft,
          child: Text(
            name, 
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              wordSpacing: 0.0, //单词间隙(负值可以让单词更紧凑)
              letterSpacing: 0.0, //字母间隙(负值可以让字母更紧凑)
              color:Colors.black87, 
              fontSize: 13.0
            )
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
          alignment: Alignment.centerLeft,
          child: Row(
            children: <Widget>[
              Text(
                marketPrice == null ? 'RMB/$price' : '¥$price', 
                maxLines: 1,
                style: TextStyle(
                  color: marketPrice != null ? Colors.black : Colors.grey, 
                  fontSize: 12.0,
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
                    fontSize: 10.0,
                    letterSpacing: 0.0
                  ), 
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ) 
        )
      ],
    );
  }
}