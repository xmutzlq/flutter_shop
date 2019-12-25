import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommImgButton extends StatelessWidget {

  final String imgpath; 
  final String text; 
  @required
  final VoidCallback onPress;
  final double width;
  final double height;
  final Color color;

  CommImgButton({Key key, this.imgpath, this.text, this.onPress, 
    this.width = 230, this.height = 70, this.color = Colors.white}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(width),
      height: ScreenUtil().setHeight(height),
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage(imgpath),
          fit: BoxFit.fill
        ),
      ),
      alignment: Alignment.center,
      child: FlatButton(
        onPressed: onPress,
        child: Text(text, style: TextStyle(fontSize: ScreenUtil().setSp(28), color: color),),
        color: Colors.transparent,
        ),
    );
  }
}