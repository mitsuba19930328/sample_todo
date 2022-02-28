//list_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:sample_todo/components/input_container.dart';
import 'package:sample_todo/pages/completed_tasks.dart';
import 'package:sample_todo/db/task.dart';
import 'package:sample_todo/pages/app_background.dart';

var listPageKey = GlobalKey<_ListPageState>();

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  bool validate = false;
  List<Task> tasks = [];

  final TextEditingController eCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    eCtrl.dispose();
    super.dispose();
  }

  //現在時刻をフォーマット化するための関数を定義
  String createDateFormat(DateTime now) {
    var formatter = DateFormat('yyyy/MM/dd/HH:mm');
    String formatted = formatter.format(now);
    return formatted;
  }

  //　Validateの後に行われる処理
  // Listに新しいTaskが追加される処理です。
  void addListItem(String text) {
    validate = false;
    final Task newItem = Task(
        title: text,
        status: 'false',
        addedDate: createDateFormat(DateTime.now()),
        completedDate: '');
    // SetStateを行うことによってWidgetの内容を更新
    setState(() {
      //tasksの0番目に新しいタスクを追加
      tasks.insert(0, newItem);
    });
    // Controllerの内容を消去する
    eCtrl.clear();
  }

  //　Taskのアップデートを行う処理
  void _updateItems(Task task, int i) {
    print("1");
    if (task.status == 'false') {
      print("2");
      final updatedTask = Task(
          title: task.title,
          status: 'true',
          addedDate: task.addedDate,
          completedDate: createDateFormat(DateTime.now()));
      //tasksのi番目のタスクを新しいタスクと入れ替える。
      tasks[i] = updatedTask;
    } else if (task.status == 'true') {
      print("3");
      final updatedTask = Task(
          title: task.title,
          status: 'false',
          addedDate: task.addedDate,
          completedDate: '');
      tasks[i] = updatedTask;
    }
    setState(() {});
  }

  //タスクの削除を行う処理
  void _removeListItem(Task task) {
    print("削除");
    setState(() => tasks.remove(task));
  }

  //通ってるかチェック
  void checkRun(String text) {
    print(text);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Tasks'),
          centerTitle: true,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: IconButton(
                icon: Icon(Icons.check_box),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      // TODO tasksをcompleted_tasksに変更する
                      builder: (context) => CompletedTasks(
                        tasks,
                        _removeListItem,
                        _updateItems,
                        createDateFormat,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),

        //Stackを使用することによってZ軸上にWidgetを重ねることができます。
        body: Stack(
          children: <Widget>[
            AppBackgroundPage(),

            //Columnを使用することで二つのWidgetを重ねるように配置します
            Column(
              children: <Widget>[
                InputContainer(validate, eCtrl, addListItem),
                Expanded(
                  child: ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (BuildContext context, int i) {
                      if (tasks[i].status == 'false') {
                        return Column(
                          children: [
                            //ここに必要なリスト情報を渡す
                            buildListItem(tasks, i),
                          ],
                        );
                      } else {
                        return Column();
                      }
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Slidable buildListItem(List<Task> tasks, int i) {
    return Slidable(
      key: ObjectKey(tasks[i]),
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        dismissible: DismissiblePane(onDismissed: () {
          _removeListItem(tasks[i]);
        }),
        children: [
          // SlidableAction(
          //   flex: 2,
          //   onPressed: null,
          //   backgroundColor: Color(0xFF7BC043),
          //   foregroundColor: Colors.white,
          //   icon: Icons.archive,
          //   label: 'Archive',
          // ),
          SlidableAction(
            flex: 2,
            //TODO: onpressedのメソッドの書き方がイマイチ分からない。
            onPressed: (context) => _removeListItem(tasks[i]),
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: ListTile(
        subtitle: Text(tasks[i].addedDate.toString()),
        title: Text(
          tasks[i].title.toString(),
          style: TextStyle(
              color: tasks[i].status == 'false' ? Colors.black : Colors.grey,
              decoration: TextDecoration.none),
        ),
        leading: Icon(
          Icons.circle_outlined,
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.check_box_outline_blank,
            color: Colors.greenAccent,
          ),
          onPressed: () {
            _updateItems(tasks[i], i);
          },
        ),
      ),
    );
  }
}
