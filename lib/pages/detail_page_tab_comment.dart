import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/config/util/i18n.dart';
import 'package:flutter_shop/provide/prvide_detail.dart';
import 'package:flutter_shop/store/store.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DetailTabComment extends StatefulWidget {
  @override
  _DetailTabCommentState createState() => _DetailTabCommentState();
}

class _DetailTabCommentState extends State<DetailTabComment> with AutomaticKeepAliveClientMixin{

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
      body:_tabCommentContent(),  
    );
  }

  Widget _tabCommentContent() {
    return Store.connect<ProvideDetail>(builder:(context, goods, child){
      List comments = (goods == null || goods.entity == null || goods.entity.goodsAppr == null)
        ? Store.value<ProvideDetail>(context).getCommentList() : goods.entity.goodsAppr;
      if(comments == null) {
        return Center(
          child: SpinKitCircle(
            color: Theme.of(context).primaryColor,
          ),
        );
      } else if(comments.length == 0) {
        return Center(child: Text(I18N.of(context).dataCommentEmpty));
      } else {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(15),
            child: _commentList(context, comments)
          ),
        );
      }
    });
  }

  Widget _commentList(BuildContext context, List comments) {
    List commentList = comments;
    return commentList.length != 0 ? Container(
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: commentList.length,
        itemBuilder: (context, index){
          return _commentItem(commentList, index);
        },
      )
    ) : Center(child: Text(I18N.of(context).dataCommentEmpty),);
  }

  Widget _commentItem(List commentList, int index) {
    return InkWell(
      onTap: (){},
      child: Container(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 10),
                  width: ScreenUtil().setWidth(60),
                  height: ScreenUtil().setHeight(50),
                  child: CircleAvatar(
                    radius: 100.0,
                    backgroundImage: NetworkImage(commentList[index].userPhoto),
                    backgroundColor: Colors.grey[400],
                  ),
                ),
                Text(
                  commentList[index].loginName,
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(25),
                    color: Colors.black54,
                  )
                )
              ],
            ),
            commentList[index].content == null ?
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(
                commentList[index].content,
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(30),
                  color: Colors.black54,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ) : Container()
          ],
        ),
      )
    );
  }
}