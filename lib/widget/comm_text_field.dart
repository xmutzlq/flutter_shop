import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/config/ui_config.dart';
import 'package:flutter_shop/config/util/i18n.dart';
import 'package:flutter_shop/provide/provide_search.dart';
import 'package:flutter_shop/store/store.dart';

class CommTextField extends StatefulWidget {

  final bool isEnable;
  final bool isNeedPop;
  final String hintStr;

  CommTextField({Key key, this.isEnable, this.hintStr, this.isNeedPop}) : super(key : key);

  @override
  _CommTextFieldState createState() => _CommTextFieldState();
}

class _CommTextFieldState extends State<CommTextField> {
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if(widget.isEnable == null || !widget.isEnable) {
          if(widget.isNeedPop != null && widget.isNeedPop) {
            Navigator.of(context).pop();
          }
          Store.value<ProvideSearch>(context).goSearchPage(context, "");
        }
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.center,
        height: ScreenUtil().setHeight(UIConfig.app_bar_bottom_text_field_height),
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.circular(8.0)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, //有效，外层Colum高度为整个屏幕
          verticalDirection: VerticalDirection.up,
          children: <Widget>[
            new Container(
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(0, 0, 4.0, 0),
              child: new Icon(Icons.search, size: 20.0, color: Theme.of(context).primaryColor,),
            ),
            Expanded(
              child: new Container(
                alignment: Alignment.center,
                child: widget.isEnable == null || !widget.isEnable ? 
                TextField(
                    enabled: false,
                    maxLines: 1,
                    textAlign: TextAlign.left,//文本对齐方式
                    decoration: InputDecoration(
                      hintText: widget.hintStr == null ? I18N.of(context).getSearch : widget.hintStr,
                      hintStyle: TextStyle(fontSize: 13.0, color: Colors.grey),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0)
                    ),
                    style: TextStyle(fontSize: 13.0, color: Colors.black87),
                  ):
                Store.connect<ProvideSearch>(builder: (_, search, __) => 
                  TextField(
                    onChanged: (value) {Store.value<ProvideSearch>(context).setKeyWord(value);},
                    controller: TextEditingController.fromValue(TextEditingValue(
                      text: '${search.keyWord == null ? "" : search.keyWord}',  //判断keyword是否为空
                    // 保持光标在最后
                    selection: TextSelection.fromPosition(TextPosition(
                        affinity: TextAffinity.downstream,
                        offset: '${search.keyWord}'.length)))),
                    enabled: true,
                    maxLines: 1,
                    textAlign: TextAlign.left,//文本对齐方式
                    decoration: InputDecoration(
                      hintText: widget.hintStr == null ? I18N.of(context).getSearch : widget.hintStr,
                      hintStyle: TextStyle(fontSize: 13.0, color: Colors.grey),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0)
                    ),
                    style: TextStyle(fontSize: 13.0, color: Colors.black87),
                  )
                ),
              )
            )
          ],
        ),
      )
    );
  }
}