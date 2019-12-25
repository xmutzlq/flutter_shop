import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_shop/config/util/i18n.dart';
import 'package:flutter_shop/provide/prvide_detail.dart';
import 'package:flutter_shop/store/store.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DetailTabDetail extends StatefulWidget {
  @override
  _DetailTabDetailState createState() => _DetailTabDetailState();
}

class _DetailTabDetailState extends State<DetailTabDetail> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive =>true;

  @override
  void initState() {
    super.initState();
    print('DetailTabDetail initState');
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body:_tabDetailContent()
    );
  }

  Widget _tabDetailContent() {
    return Store.connect<ProvideDetail>(builder:(context, goods, child){
      String htmlData = (goods == null || goods.entity == null || goods.entity.goodsDesc == null)
        ? Store.value<ProvideDetail>(context).getDetailContentHtml() : goods.entity.goodsDesc;
      if(htmlData != null) {
        return SingleChildScrollView(
          child: Html(
            data: htmlData,
          ),
        );
      } else {
        return Center(
          child: SpinKitCircle(
            color: Theme.of(context).primaryColor,
          )
        );
      }
    });
  }
}