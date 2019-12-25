import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/event/event_bus.dart';
import 'package:flutter_shop/provide/provide_goods_list.dart';

class PopPriceDesc extends StatefulWidget {

  final int currentSortIndex;
  final String defaultStr;
  final String descStr;
  final String aesStr;

  PopPriceDesc({Key key, this.currentSortIndex, this.defaultStr, this.descStr, this.aesStr}) : super(key: key);

  @override
  _PopPriceDescState createState() => _PopPriceDescState();
}

class _PopPriceDescState extends State<PopPriceDesc> {

  final List<bool> isChecks = [false, false, false];

  void turnBack(String sortType) {
    eventBus.fire(ArrowIconUpdateEvent(false));
    eventBus.fire(GoodsListSortByPriceEvent(sortType));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    if(widget.currentSortIndex >= 0) {
      isChecks[widget.currentSortIndex] = true;
    }
    return Container(
      color: Colors.grey[100],
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          CheckboxListTile(
            value: isChecks[0],
            ///I18N.of(context).goodsSortDefault()
            title: Text(widget.defaultStr, style: TextStyle(fontSize: ScreenUtil().setSp(30),
            color: isChecks[0] ? Colors.purple : Theme.of(context).primaryColor),),
            activeColor: isChecks[0] ? Colors.purple : Theme.of(context).primaryColor,
            controlAffinity: ListTileControlAffinity.platform,
            onChanged: (bool) {
              isChecks[0] = bool;
              isChecks[1] = !bool;
              isChecks[2] = !bool;
              setState(() {
                turnBack(ProvideGoodsList.SORT_TYPE_DEFAULT);
              });
            },
          ),
          Divider(height: ScreenUtil().setHeight(1), color: Colors.grey[300],),
          CheckboxListTile(
            value: isChecks[1],
            ///I18N.of(context).goodsSortDesc()
            title: Text(widget.descStr, style: TextStyle(fontSize: ScreenUtil().setSp(30),
            color: isChecks[1] ? Colors.purple : Theme.of(context).primaryColor),),
            activeColor: isChecks[1] ? Colors.purple : Theme.of(context).primaryColor,
            controlAffinity: ListTileControlAffinity.platform,
            onChanged: (bool) {
              isChecks[0] = !bool;
              isChecks[1] = bool;
              isChecks[2] = !bool;
              setState(() {
                turnBack(ProvideGoodsList.SORT_TYPE_DESC);
              });
            },
          ),
          Divider(height: ScreenUtil().setHeight(1), color: Colors.grey[300],),
          CheckboxListTile(
            value: isChecks[2],
            ///I18N.of(context).goodsSortAsc()
            title: Text(widget.aesStr, style: TextStyle(fontSize: ScreenUtil().setSp(30),
            color: isChecks[2] ? Colors.purple : Theme.of(context).primaryColor),),
            activeColor: isChecks[2] ? Colors.purple : Theme.of(context).primaryColor,
            controlAffinity: ListTileControlAffinity.platform,
            onChanged: (bool) {
              isChecks[0] = !bool;
              isChecks[1] = !bool;
              isChecks[2] = bool;
              setState(() {
                turnBack(ProvideGoodsList.SORT_TYPE_AESC);
              });
            },
          )
        ],
      ),
    );
  }
}