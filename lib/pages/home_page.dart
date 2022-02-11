// home_page.dart
import 'package:flutter/material.dart';
import 'app_background.dart';
import 'list_page.dart';

var homePageKey = GlobalKey<_HomePageState>();

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: <Widget>[
          AppBackgroundPage(),
          ListPage(
            key: listPageKey,
          )
        ],
      ),
    );
  }
}



//return SafeAreaの位置にAppBackgroundPage()の内容をコピペすればうまく描画できることがわかった。
// return LayoutBuilder(builder: (context, constraint) {
// final height = constraint.maxHeight;
// final width = constraint.maxWidth;
// return Stack(
// children: <Widget>[
// Container(
// color: Color(0xFFE4E6F1),
// ),
// Positioned(
// right: (height / 9 - height / 2),
// top: -height * 0.09,
// child: Container(
// height: height,
// width: width,
// decoration: BoxDecoration(
// shape: BoxShape.circle, color: Colors.white.withOpacity(0.5)),
// ),
// ),
// Positioned(
// top: height * 0.60,
// right: height * 0.09,
// child: Container(
// height: height,
// width: width,
// decoration: BoxDecoration(
// shape: BoxShape.circle, color: Colors.white.withOpacity(0.4)),
// ),
// ),
// Positioned(
// top: -height * 0.20,
// left: -height * 0.39,
// child: Container(
// height: height,
// width: width,
// decoration: BoxDecoration(
// shape: BoxShape.circle, color: Colors.white.withOpacity(0.2)),
// ),
// ),
// ],
// );
// });