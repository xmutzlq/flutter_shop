import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/config/util/i18n.dart';
import 'package:flutter_shop/entity/cate_left_nav_child.dart';
import 'package:flutter_shop/entity/cate_left_nav_entity.dart';
import 'package:flutter_shop/provide/provide_category.dart';
import 'package:flutter_shop/store/store.dart';

class CateLeftNav extends StatefulWidget {
  @override
  _CateLeftNavState createState() => _CateLeftNavState();
}

class _CateLeftNavState extends State<CateLeftNav> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(180),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          right: BorderSide(width: 1, color:Colors.white)
        )
      ),
      child: Store.connect<ProvideCategory>(
        builder: (context, category, child)=>_leftNavContent(context, category.leftEntity)) 
    );
  }

  Widget _leftNavContent(BuildContext context, CateLeftNavEnity enity) {
    if(enity == null) {
      return Center(child: Text(I18N.of(context).loading));
    } else if(enity.data == null || enity.data.length == 0) {
      return Center(child: Text(I18N.of(context).dataEmpty));
    } else {
      return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: enity.data.length,
        itemBuilder: (context,index){
          return _leftInkWel(context, index, enity.data);
        }
      );
    }  
  }

  Widget _leftInkWel(BuildContext context, int index, List<CateLeftNavChild> leftNavChilds){
    bool isClick = false;
    isClick = (index == Store.value<ProvideCategory>(context).listIndex) ? true : false;
    return Store.connect<ProvideCategory>(
      builder: (context, category, chlid) {
        return InkWell(
        onTap: (){
          category.setListIndex(index);
        },
        child: Container(
          height: ScreenUtil().setHeight(100),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 246, 246, 246),
            border:Border(
              bottom:BorderSide(width: 1.5,color:Colors.white)
            )
          ),
          child: Stack(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Text(
                  leftNavChilds[index].catName,
                  style: TextStyle(
                    fontSize:ScreenUtil().setSp(28),
                    fontWeight: isClick ? FontWeight.w700 : FontWeight.normal,
                    color: isClick ? Theme.of(context).primaryColor : Colors.grey
                  ),
                ),
              ),
              Container(
                color: Theme.of(context).primaryColor,
                width: isClick ? ScreenUtil().setWidth(8) : 0,
              ),
            ],
          ),
        ),
      ); 
    });
  }
}