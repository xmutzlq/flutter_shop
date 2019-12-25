import 'package:flutter_shop/entity/cate_left_nav_child.dart';

class CateLeftNavEnity {
  List<CateLeftNavChild> data;
  CateLeftNavEnity(this.data);
  factory CateLeftNavEnity.fromJson(List json) {
    return CateLeftNavEnity(
      json.map((i)=>CateLeftNavChild.fromJson((i))).toList()
    );
  }
}