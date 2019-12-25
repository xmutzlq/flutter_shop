import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/config/service_url.dart';
import 'package:flutter_shop/config/ui_config.dart';
import 'package:flutter_shop/config/util/i18n.dart';
import 'package:flutter_shop/provide/provide_category.dart';
import 'package:flutter_shop/store/store.dart';
import 'package:flutter_shop/widget/cate_left_nav.dart';
import 'package:flutter_shop/widget/cate_right_nav.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive =>true;

  @override
  void initState() {
    print('CategoryPage_initState');
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((callback){
      Store.value<ProvideCategory>(context).getCategory();
    });
  }

  @override
  void didChangeDependencies() {
    print('CategoryPage_didChangeDependencies');
    super.didChangeDependencies();
  }

  void onTabClick(ProvideCategory category, bool left) {
    String sex = left ? SEX_MAN : SEX_WOMEN;
    return category.setCurrentSex(sex);
  }

  Widget _changTab(BuildContext context) {
    return Consumer<ProvideCategory> (
      builder: (context, category, child) {
        return Row(
          children: <Widget>[
            Expanded(
              child: GestureDetector(
                onTap: ()=>onTabClick(category, true),
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(I18N.of(context).male),
                      category.currentSex == SEX_MAN ? Icon(Icons.arrow_drop_down, color: Theme.of(context).primaryColor,) : Container()
                    ],
                  )
                )
              )
            ),
            Container(
              width: ScreenUtil().setWidth(1),
              height: ScreenUtil().setHeight(40),
              color: Colors.grey[300],
            ),
            Expanded(
              child: GestureDetector(
                onTap: ()=>onTabClick(category, false),
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(I18N.of(context).female),
                      category.currentSex != SEX_MAN ? Icon(Icons.arrow_drop_down, color: Theme.of(context).primaryColor) : Container()
                    ],
                  ),
                )
              )
            )
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    print('CategoryPage_build');
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(I18N.of(context).title),
        centerTitle: true,
      ),
      body:_categoryBody()
    );
  }

  Widget _categoryBody() {
    var data = Store.value<ProvideCategory>(context).responseJson; 
    if(data != null) {
      print('渲染分类数据');
      return _categoryContent();
    } else {
      return Center(
        child: SpinKitCircle(
          color: Theme.of(context).primaryColor,
        )
      );
    }
  }

  Widget _categoryContent() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: ScreenUtil().setHeight(UIConfig.tab_height),
            color: Colors.white,
            child: _changTab(context)
          ),
          Container(
            height: ScreenUtil().setHeight(1),
            decoration: BoxDecoration(
              color: Colors.grey[300],
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                CateLeftNav(),
                Expanded(
                  child:  CateRightNav(),
                )
              ],
            ),
          )
        ],
      )
    ); 
  }
}