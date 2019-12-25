import 'package:flutter_shop/entity/cate_right_nav_child.dart';

class CateRightNavEnity {
  List<CateRightNavChild> data;
  CateRightNavEnity(this.data);
  factory CateRightNavEnity.fromJson(List json) {
    return CateRightNavEnity(
      json.map((i)=>CateRightNavChild.fromJson((i))).toList()
    );
  }
}