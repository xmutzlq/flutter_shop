import 'package:flutter/material.dart';
import 'package:flutter_shop/provide/provide_card.dart';
import 'package:flutter_shop/store/store.dart';

class CartPage extends StatefulWidget {
  CartPage({Key key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive =>true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((callback){
      // Store.value<ProvideCard>(context).getGoodsList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
       child: Center(),
    );
  }
}