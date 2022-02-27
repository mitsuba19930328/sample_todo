import 'package:flutter/material.dart';
import 'package:sample_todo/pages/app_background.dart';

class CompletedTasks extends StatelessWidget {
  const CompletedTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Completed Tasks'),
        centerTitle: true,
        // actions: <Widget>[
        //   // ③次項で作成するページです。
        //   Padding(
        //     padding: EdgeInsets.all(8.0),
        //     child: IconButton(
        //       icon: Icon(Icons.arrow_back),
        //       onPressed: () {
        //         // 一旦ここはコメントアウト
        //         Navigator.pop(context);
        //       },
        //     ),
        //   ),
        // ],
      ),
      body: Stack(
        children: <Widget>[
          AppBackgroundPage(),
//Columnを使用することで二つのWidgetを重ねるように配置します
          Column(
            children: <Widget>[
              //後に定義するインプットボックスウィジェットを呼び出します
              Text('test'),
              Text('test'),
              //ここ変更
              // InputContainer(validate, eCtrl, addListItem),
              // // buildInputContainer(),
              // //ここまで

              // Expanded(
              //   child: ListView.builder(
              //     itemCount: tasks.length,
              //     itemBuilder: (BuildContext context, int i) {
              //       // List 一つのデザインを定義します。
              //       //// 好みで変更してみてください。
              //       return buildListItem(tasks, i);
              //     },
              //   ),
              // )
            ],
          ),
        ],
      ),
    );
  }
}
