import 'package:flutter/material.dart';
import 'package:flutter_shop/entity/goods_list_parent_node.dart';
import 'package:flutter_shop/event/event_bus.dart';
import 'package:flutter_shop/provide/provide_goods_list.dart';
import 'package:flutter_shop/store/store.dart';
import 'package:flutter_shop/widget/comm_img_btn.dart';
import 'package:flutter_shop/widget/smart_drawer.dart';

import 'goods_filter_parent.dart';

class GoodsFilterDrawer extends StatefulWidget {
  GoodsFilterDrawer({Key key}) : super(key: key);

  @override
  GoodsFilterDrawerState createState() => GoodsFilterDrawerState();
}

class GoodsFilterDrawerState extends State<GoodsFilterDrawer> {

  @override
  void initState() {
    super.initState();
    print('drawer initState');
  }

  @override
  Widget build(BuildContext context) {
    print('drawer build');
    List<GoodsParentNode> filterNodes = Store.value<ProvideGoodsList>(context).filterNodes;
    return SmartDrawer(
      widthPercent: 0.8,
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 20),
              children: _buildParents(filterNodes),
            )
          ),
          Divider(height: 1, color: Colors.grey,),
          Container(
            padding: EdgeInsets.only(top: 5, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CommImgButton(imgpath:'images/left_gradient_btn.png', text:'重置', onPress: () {
                  Store.value<ProvideGoodsList>(context).reSetFilter();
                  setState(() {
                    
                  });
                }),
                CommImgButton(imgpath: 'images/right_gradient_btn.png', text:'确定', onPress: () {
                  //EventBus发射
                  eventBus.fire(FilterCommitEvent());
                }),
              ],
            )
          )
        ],
      )
    );
  }

  List<Widget> _buildParents(List<GoodsParentNode> nodes) {
    List<Widget> widgets = List();
    if (nodes != null && nodes.length > 0) {
      int index = 0;
      for (GoodsParentNode node in nodes) {
        widgets.add(GoodsFilterParent(parentNodeIndex: index, parentNodes: node));
        index ++;
      }
    }
    return widgets;
  }
}