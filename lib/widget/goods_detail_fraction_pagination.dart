import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class GoodsDetailFractionPagination extends FractionPaginationBuilder {

  final Color color;

  final Color activeColor;

  final double fontSize;

  final double activeFontSize;

  final Key key;

  const GoodsDetailFractionPagination(
      {this.color,
      this.fontSize: 12.0,
      this.key,
      this.activeColor,
      this.activeFontSize: 12.0});

  @override
  Widget build(BuildContext context, SwiperPluginConfig config) {
    ThemeData themeData = Theme.of(context);
    Color activeColor = this.activeColor ?? themeData.primaryColor;
    Color color = this.color ?? themeData.scaffoldBackgroundColor;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white30,
        borderRadius: new BorderRadius.all(Radius.circular(50))
      ),
      padding: EdgeInsets.only(top:2, left: 10, right: 10, bottom:2),
      child: _fractionContent(activeColor, color, config),
    );
  }

  Widget _fractionContent(Color activeColor, Color color, SwiperPluginConfig config) {
    if (Axis.vertical == config.scrollDirection) {
      return new Column(
        key: key,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Text(
            "${config.activeIndex + 1}",
            style: TextStyle(color: activeColor, fontSize: activeFontSize),
          ),
          new Text(
            "/",
            style: TextStyle(color: color, fontSize: fontSize),
          ),
          new Text(
            "${config.itemCount}",
            style: TextStyle(color: color, fontSize: fontSize),
          )
        ],
      );
    } else {
      return new Row(
        key: key,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Text(
            "${config.activeIndex + 1}",
            style: TextStyle(color: activeColor, fontSize: activeFontSize),
          ),
          new Text(
            "/${config.itemCount}",
            style: TextStyle(color: color, fontSize: fontSize),
          )
        ],
      );
    }
  }
} 