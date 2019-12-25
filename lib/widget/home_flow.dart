import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_shop/config/service_url.dart';

class HomeFlow extends StatelessWidget {

  final String flowImg1;
  final String flowImg2;

  HomeFlow({Key key, this.flowImg1, this.flowImg2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          new Image.network(urlParser(flowImg1)),
          new Image.network(urlParser(flowImg2))
        ],
      )
    );
  }
}