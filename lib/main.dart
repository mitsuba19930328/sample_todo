import 'package:flutter/material.dart';
import 'package:sample_todo/completed_todo_page.dart';
import 'package:sample_todo/create_todo_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Todo App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  // Todoリストのデータ
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> todoList = [];
  int _counter = 0;

  // todoチケット作成メソッド
  void _createTodo() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.checklist),
            color: Colors.white,
            onPressed: () { // ボタン押したときに実行される
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CompletedTodoPage(), // SecondPageは遷移先のクラス
                ),
              );
            },
          ),
        ],
      ),

      // データを元にListViewを作成
      body: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(todoList[index]),
            ),
          );
        },
      ),

      // body: Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //
      //   children: [
      //     for (int i=0; i<3; i++)
      //     Container(
      //       child: Card(
      //         child: Column(
      //           mainAxisSize: MainAxisSize.min,
      //           children: <Widget>[
      //             const ListTile(
      //               leading: Icon(Icons.album),
      //               title: Text('The Enchanted Nightingale'),
      //               subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
      //             ),
      //             Row(
      //               mainAxisAlignment: MainAxisAlignment.end,
      //               children: <Widget>[
      //                 TextButton(
      //                   child: const Text('完了'),
      //                   onPressed: () {/* ... */},
      //                 ),
      //                 const SizedBox(width: 8),
      //               ],
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async { // ボタン押したときに実行される
          final newTodoMemo = await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                // 遷移先の画面としてリスト追加画面を指定
                return CreateTodoPage();
              }),
          );
          if (newTodoMemo != null) {
            setState(() {
              // リスト追加
              todoList.add(newTodoMemo);
            });
            // キャンセルした場合は newListText が null となるので注意
          }
        },
        tooltip: 'todoチケットの新規作成',
        child: const Icon(Icons.add),
      ),
    );
  }
}
