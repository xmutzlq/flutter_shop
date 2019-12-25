import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/config/ui_config.dart';
import 'package:flutter_shop/config/util/i18n.dart';
import 'package:flutter_shop/provide/provide_goods_list.dart';
import 'package:flutter_shop/provide/provide_search.dart';
import 'package:flutter_shop/store/store.dart';
import 'package:flutter_shop/widget/comm_text_field.dart';

class SearchPage extends StatefulWidget {

  final String inputContent;

  SearchPage({this.inputContent});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive =>true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((callback){
      Store.value<ProvideSearch>(context).loadSearchHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(I18N.of(context).title),
        centerTitle: true,
      ),
      body:_searchContent(context),
      resizeToAvoidBottomInset:false,
    );
  }

  void goGoodsList() {
    if(Store.value<ProvideSearch>(context).keyWord != null) {
      Store.value<ProvideGoodsList>(context).goGoodsListPage(context, "",
      Store.value<ProvideSearch>(context).keyWord, true);
    }
  }

  Widget _searchContent(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 15.0),
          height: ScreenUtil().setHeight(UIConfig.app_bar_bottom_height),
          color: Theme.of(context).primaryColor,
          child: Row(
            children: <Widget>[
              Expanded(
                child: CommTextField(isEnable: true, hintStr: "", isNeedPop: true,),
              ),
              InkWell(
                onTap: () => {
                  FocusScope.of(context).requestFocus(FocusNode()),
                  Store.value<ProvideSearch>(context).updateHistory(
                    Store.value<ProvideSearch>(context).keyWord == null ? 
                    "":Store.value<ProvideSearch>(context).keyWord.trim().toString()),
                  goGoodsList()
                },
                child: Container(
                  height: ScreenUtil().setHeight(UIConfig.app_bar_bottom_height),
                  padding: EdgeInsets.only(left: 20, right: 20),
                  alignment: Alignment.center,
                  child: Text(
                    I18N.of(context).btnSearch,
                    style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(30)),
                  ),
                ) ,
              )
            ],
          )
        ),
        //History List
        Expanded(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(18),
                child: Text(
                  I18N.of(context).searchHistory,
                  style: TextStyle(fontSize: ScreenUtil().setSp(35), color: Colors.black),
                ),
              ),
              Container(width: double.infinity, height: ScreenUtil().setHeight(2), color: Colors.grey[200],),
              Store.connect<ProvideSearch>(builder: (_, sp, __) => 
                Store.value<ProvideSearch>(context).historyCache == null ?
                Container():
                ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  separatorBuilder: (BuildContext context, int index) => new Divider(),
                  itemCount:Store.value<ProvideSearch>(context).historyCache.length,
                  itemBuilder: (context,index){
                    return ListTile(
                      onTap: () => {
                        FocusScope.of(context).requestFocus(FocusNode()),
                        Store.value<ProvideSearch>(context).updateKeyWord(Store.value<ProvideSearch>(context).historyCache[index]),
                        goGoodsList()
                      },
                      title: Text(
                        Store.value<ProvideSearch>(context).historyCache[index],
                        style: TextStyle(fontSize: ScreenUtil().setSp(32), color: Colors.black54),),
                    );
                  },
                )
              )
            ],
          )
        )
      ],
    );
  }
}